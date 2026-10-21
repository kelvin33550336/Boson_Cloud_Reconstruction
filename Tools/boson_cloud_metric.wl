(* ::Package:: *)
(* boson_cloud_metric.wl -- evaluate the reconstructed metric perturbation of the boson cloud, and its derivatives, at any (r, chi),
   from the spectral data exported by boson_cloud_pipeline_diag.wl (h_ORG_cloud.mx or h_ORG_cloud.wdx).

   Usage
     Get["boson_cloud_metric.wl"];
     loadMetric["/path/to/diag_11688456/h_ORG_cloud.wdx"];      (* or .mx (same Wolfram version / OS only) *)
     bcmSelfTest[]                                               (* reference values, coframe, derivatives: run once *)

     hComponent["hmbmb", r, chi]              A^2 h_{mbar mbar} (particular ORG solution)
     hComponent["hlmb",  r, chi, {i, j}]      d^i/dr^i d^j/dchi^j of A^2 h_{l mbar}
     hTetrad[r, chi]                          all tetrad components (ll, lm, lmb, mm, mbmb, mmb), A^2 (h_ORG + h_comp)
     hTetrad[r, chi, {i, j}, "Completion" -> False, "Amplitude" -> "Unit"]
     hCoord[r, chi, {i, j}]                   coordinate components h_{mu nu}, mu, nu in (v, r, chi, phi)   (4 x 4 matrix)
     gKerr[r, chi, {i, j}]                    Kerr background g_{mu nu} (M = 1, a = threshold spin) in the same coordinates
     gTotal[r, chi, {i, j}]                   gKerr + A^2 (h_ORG + h_comp)   (the full metric to first order in A^2)

   Conventions (as in the pipeline): M = 1; ingoing Kerr coordinates (v, r, chi = cos theta, phi); boosted Kinnersley tetrad
   l, n = -d_r, m, mbar; traceful ORG h_{ab} n^b = 0; delta G_ab[h] = T_ab (8 pi G = 1). Everything (T_ab, h_ORG, the completion) is per unit
   amplitude^2 A^2 of the Leaver normalization; the physical perturbation is A^2 (h_ORG + h_comp) with A^2 = completion["amp2"]
   (A^2 = 3.99e-9 for a cloud of mass 1e-4 M in diag_11688456). All functions return PHYSICAL values (times A^2) by default;
   the option "Amplitude" -> "Unit" (hComponent, hCompletion, hTetrad, hCoord) gives them per unit A^2.
   Tetrad components (order l, n, m, mbar):  ll, lm, lmb (= l mbar), mm, mbmb (= mbar mbar), mmb (= m mbar); all n-components vanish.
   h_lm = conj(h_lmb), h_mm = conj(h_mbmb) (real metric); h_ll, h_mmb are real.

   How each component is rebuilt (same formulas as the pipeline, sections 10, 11, 15):
     h_mbmb = sum_l Y_l(chi) [ -4 (r + i a chi)/(r - i a chi)^2 I3_l(r) - 2 (r + i a chi)^2/(r - i a chi)^2 I2_l(r) ],  Y_l = _{-2}Y_{l0};
              I2, I3 from their per-panel Chebyshev coefficients for r - r+ < xMax, closed-form (Legendre Q) tails beyond.
     h_mmb  = -(1 - chi^2) P(chi)^2 [ K2(r) + 2 r/(r^2 + a^2 chi^2) K3(r) ]  (S = sqrt(1 - chi^2) P); zero beyond xMax (|h| < e^{2 q xMax}).
     h_lmb, h_ll: 2D Chebyshev interpolation of the node values (radial panel x chi); h_lmb is interpolated as h_lmb/sin(theta).
              Outer region r > rMax: panels in zeta = rMax/r.
     Derivatives are exact derivatives of these representations (Chebyshev differentiation, symbolic chain/Leibniz rules), to any order.
   Inputs are converted to the working precision of the run (wp = 60 digits): give r, chi as exact numbers or with >= wp digits;
   machine numbers are used as exact decimals (SetPrecision). Valid for r >= r+ and -1 <= chi <= 1 (chi-derivatives of h_lmb, which contains
   sin(theta), are singular at chi = +-1). *)

BeginPackage["BosonCloudMetric`"];

loadMetric::usage = "loadMetric[file] loads h_ORG_cloud.mx or h_ORG_cloud.wdx exported by boson_cloud_pipeline_diag.wl.";
hComponent::usage = "hComponent[comp, r, chi, {i, j}] gives d^i/dr^i d^j/dchi^j of the ORG tetrad component comp (\"hmbmb\", \"hmmb\", \"hlmb\", \"hll\") of the particular solution. {i, j} defaults to {0, 0}. Option \"Amplitude\" -> \"Physical\" (default: times A^2 of the run) or \"Unit\" (per unit A^2).";
hCompletion::usage = "hCompletion[r, chi, {i, j}] gives the completion (ER zero modes with the Komar-fixed amplitudes) as an Association of tetrad components ll, lm, lmb. Option \"Amplitude\" -> \"Physical\" (default) or \"Unit\".";
hTetrad::usage = "hTetrad[r, chi, {i, j}, opts] gives all tetrad components (ll, lm, lmb, mm, mbmb, mmb) of h_ORG + h_comp (options \"Completion\" -> True|False, \"Amplitude\" -> \"Physical\" (default) | \"Unit\").";
hCoord::usage = "hCoord[r, chi, {i, j}, opts] gives the coordinate components h_{mu nu} (mu, nu = v, r, chi, phi) as a 4 x 4 matrix; same options as hTetrad.";
gKerr::usage = "gKerr[r, chi, {i, j}] gives the (i, j) derivative of the Kerr metric g_{mu nu} (M = 1, a = threshold spin) in ingoing coordinates (v, r, chi, phi).";
gTotal::usage = "gTotal[r, chi, {i, j}, opts] gives gKerr + A^2 (h_ORG + h_comp) (option \"Completion\" -> True|False).";
bcmParameters::usage = "bcmParameters[] gives the run parameters, grid sizes and completion data.";
bcmSelfTest::usage = "bcmSelfTest[] checks the rebuilt components against the reference values of the run, the coframe against the stored completion, and the derivatives against finite differences.";

Begin["`Private`"];

(* ---------------------------------------------------------------- loading *)
loadMetric[file_String] := Module[{d},
   If[! FileExistsQ[file], Message[loadMetric::nofile, file]; Return[$Failed]];
   If[ValueQ[Global`r] || ValueQ[Global`\[Chi]], Message[loadMetric::glob]; Return[$Failed]];
   d = Block[{$Context = "Global`", $ContextPath = {"System`", "Global`"}}, Import[file]];
   If[! AssociationQ[d], Message[loadMetric::bad, file]; Return[$Failed]];
   setup[d];
   Print["loaded ", file, ":  a = ", N[aN, 15], ",  lmax = ", Max[lList], ",  wp = ", wp, ",  ", nPan, " inner + ", nOut, " outer panels x ", nPn,
     " nodes,  nchi = ", nchi, ",  A^2 = ", N[amp2, 12]];
   ];
loadMetric::nofile = "file `1` not found.";
loadMetric::bad = "`1` does not contain the expected Association.";
loadMetric::bcmnl = "no data loaded: call loadMetric[file] first.";
loadMetric::glob = "Global`r or Global`\[Chi] has a value; the exported expressions use these symbols. Clear them (Clear[r, \[Chi]]) and load again.";

(* the exported expressions (P(chi), the completion modes) contain the coordinates r and chi as symbols. Their context depends on how the file
   was read (Global` or the context current at Import), so they are replaced by NAME, whatever their context *)
rcSub[e_, rv_, cv_] := e /. s_Symbol /; (Context[s] =!= "System`" && MemberQ[{"r", "\[Chi]"}, SymbolName[s]]) :> If[SymbolName[s] === "r", rv, cv];

setup[d_] := Module[{g = d["grid"], p = d["params"]},
   dat = d;
   wp = p["wp"]; aN = p["a"]; rp = p["rplus"];
   kap = Sqrt[1 - aN^2];
   xB = g["xB"]; xMax = g["xMax"]; nPn = g["nPn"]; nchi = g["nchi"]; zB = g["zetaB"];
   nPan = Length[xB] - 1; nOut = Length[zB] - 1; rMax = rp + xMax;
   chiN = g["chiNodes"]; sN = Sqrt[1 - chiN^2];
   lList = d["hmbmb"]["lList"];
   I123 = d["hmbmb"]["I123"]; gC = d["hmbmb"]["g"]; Cup = d["hmbmb"]["Cup"];
   K123 = d["hmmb"]["K123"]; tauC = d["hmmb"]["tau"];
   Ppoly = Function[Evaluate[rcSub[d["hmmb"]["PpolyR"], 0, #]]];
   nodes["hlmb"] = {d["hlmb"]["inner"], d["hlmb"]["outer"]};
   nodes["hll"] = {d["hll"]["inner"], d["hll"]["outer"]};
   comp = d["completion"]; amp2 = comp["amp2"]; {cM, cA} = comp["coefficients"];
   cache = <||>;                                       (* cached coefficient matrices and derivative formulas of this data set *)
   loaded = True;
   ];
loaded = False; cache = <||>;
SetAttributes[memo, HoldRest];
memo[key_, expr_] := If[KeyExistsQ[cache, key], cache[key], cache[key] = expr];
check[] := If[TrueQ[loaded], True, Message[loadMetric::bcmnl]; Abort[]];

(* ---------------------------------------------------------------- numbers and Chebyshev utilities (as in the pipeline) *)
toWP[x_] := Which[Precision[x] === Infinity, N[x, wp], Precision[x] === MachinePrecision, SetPrecision[x, wp], True, x];
chebMat[nn_] := memo[{"chebMat", nn}, N[Table[(2/nn) If[k == 0, 1/2, 1] Cos[k Pi (j + 1/2)/nn], {k, 0, nn - 1}, {j, 0, nn - 1}], wp]];
chebDer[c_List] := Module[{nn = Length[c] - 1, dd},                    (* coefficients of df/dz *)
   dd = ConstantArray[0, nn + 2];
   Do[dd[[k]] = dd[[k + 2]] + 2 k c[[k + 1]], {k, nn, 1, -1}];
   dd[[1]] = dd[[1]]/2; Take[dd, nn + 1]];
chebEval[c_List, z_] := c . ChebyshevT[Range[0, Length[c] - 1], z];
panelIndex[x_] := Min[nPan, Max[1, LengthWhile[xB, # <= x &]]];
panMid[p_] := (xB[[p]] + xB[[p + 1]])/2; panH[p_] := (xB[[p + 1]] - xB[[p]])/2;
zMid[q_] := (zB[[q]] + zB[[q + 1]])/2; zH[q_] := (zB[[q + 1]] - zB[[q]])/2;
(* d-th r-derivative of a panel-wise Chebyshev function (inner region) *)
panelEval[coefs_, r0_, d_] := Module[{x = r0 - rp, p, t},
   p = panelIndex[x]; t = (x - panMid[p])/panH[p];
   chebEval[Nest[chebDer, coefs[[p]], d], t]/panH[p]^d];

(* ---------------------------------------------------------------- spin-weighted harmonics _{-2}Y_{l0} and chi-derivatives
   Y_l = N_l (1 - chi^2) P_l''(chi), N_l = sqrt((2l+1)(l-2)!/(4 pi (l+2)!)) (sign convention of SpinWeightedSphericalHarmonicY);
   P_l^{(k)} = (2k-1)!! C^{(k+1/2)}_{l-k} (Gegenbauer) *)
Pder[l_, k_, c_] := If[k > l, 0, (2 k - 1)!! GegenbauerC[l - k, k + 1/2, c]];
Nl[l_] := Sqrt[(2 l + 1) (l - 2)!/(4 Pi (l + 2)!)];
Yd[l_, m_, c_] := N[Nl[l], wp] ((1 - c^2) Pder[l, m + 2, c] - 2 m c Pder[l, m + 1, c] - m (m - 1) Pder[l, m, c]);     (* d^m/dchi^m of (1 - chi^2) P'' *)

(* ---------------------------------------------------------------- h_mbarmbar *)
(* closed-form tails beyond r+ + xMax: I_k^{(d)}(r) = Cup NUp kappa^{-d} F_k^{(d)}(X), X = (r - 1)/kappa *)
QH[l_, X_] := Sqrt[Pi] Gamma[l + 1]/(Gamma[l + 3/2] (2 X)^(l + 1)) Hypergeometric2F1[(l + 1)/2, (l + 2)/2, l + 3/2, 1/X^2];
NUp[l_] := (2 l + 1)!!/((l + 2)! kap^(l + 3));
tailF[l_, k_, d_] := memo[{"tail", l, k, d}, Module[{X, F},
   F = Switch[k, 0, D[QH[l, X], {X, 2}], 1, -kap D[QH[l, X], X], 2, kap^2 QH[l, X], 3, kap^3 (QH[l - 1, X] - QH[l + 1, X])/(2 l + 1)];
   Function[Evaluate[{X}], Evaluate[Cup[l] NUp[l] kap^-d D[F, {X, d}]]]]];
Ival[l_, k_, d_, r0_] := If[r0 - rp >= xMax, tailF[l, k, d][(r0 - 1)/kap],
   panelEval[If[k == 0, gC[l], I123[l][[All, k]]], r0, d]];
(* symbolic (i, j)-derivative of one mode, linear in i2[n] = I2^{(n)}, i3[n] = I3^{(n)}, y[m] = Y^{(m)} *)
hmbD[i_, j_] := memo[{"hmb", i, j}, Module[{rr, cc, I2f, I3f, Yf, e},
   e = Yf[cc] (-4 (rr + I aN cc)/(rr - I aN cc)^2 I3f[rr] - 2 (rr + I aN cc)^2/(rr - I aN cc)^2 I2f[rr]);
   e = D[e, {rr, i}, {cc, j}] /. {Derivative[n_][I3f][rr] :> i3[n], I3f[rr] :> i3[0], Derivative[n_][I2f][rr] :> i2[n], I2f[rr] :> i2[0],
       Derivative[m_][Yf][cc] :> y[m], Yf[cc] :> y[0]};
   Function[Evaluate[{rr, cc}], Evaluate[e]]]];
hmbmb[r0_, c0_, {i_, j_}] := Module[{e = hmbD[i, j][r0, c0]},
   Sum[e /. {i3[n_] :> Ival[l, 3, n, r0], i2[n_] :> Ival[l, 2, n, r0], y[m_] :> Yd[l, m, c0]}, {l, lList}]];

(* ---------------------------------------------------------------- h_mmbar *)
hmmD[i_, j_] := memo[{"hmm", i, j}, Module[{rr, cc, K2f, K3f, e},
   e = -(1 - cc^2) Ppoly[cc]^2 (K2f[rr] + 2 rr/(rr^2 + aN^2 cc^2) K3f[rr]);
   e = D[e, {rr, i}, {cc, j}] /. {Derivative[n_][K3f][rr] :> k3[n], K3f[rr] :> k3[0], Derivative[n_][K2f][rr] :> k2[n], K2f[rr] :> k2[0]};
   Function[Evaluate[{rr, cc}], Evaluate[e]]]];
hmmb[r0_, c0_, {i_, j_}] := If[r0 - rp >= xMax, 0 r0,
   hmmD[i, j][r0, c0] /. {k2[n_] :> panelEval[K123[[All, 2]], r0, n], k3[n_] :> panelEval[K123[[All, 3]], r0, n]}];

(* ---------------------------------------------------------------- h_lmbar, h_ll: 2D Chebyshev interpolation of the node values *)
(* coefficient matrix [[t-index, chi-index]] of the panel, differentiated i times in t and j times in chi (cached) *)
c2Cache[cname_, reg_, p_, i_, j_] := memo[{"c2", cname, reg, p, i, j}, Which[
   i > 0, Transpose[chebDer /@ Transpose[c2Cache[cname, reg, p, i - 1, j]]],
   j > 0, chebDer /@ c2Cache[cname, reg, p, i, j - 1],
   True, Module[{V = nodes[cname][[If[reg === "in", 1, 2], p]]},
     If[cname === "hlmb", V = (#/sN) & /@ V];          (* spin weight -1: interpolate h/sin(theta) *)
     chebMat[nPn] . V . Transpose[chebMat[nchi]]]]];
(* d^n/dr^n of F(t(r)) on the outer panels, t = (rMax/r - zm)/zh: coefficients of F^{(k)}(t), k = 0..n *)
chainOuter[n_] := chainOuter[n] = Module[{rr, zm, zh, rM, F, e},          (* data independent *)
   e = D[F[(rM/rr - zm)/zh], {rr, n}] /. {Derivative[k_][F][_] :> fd[k], F[_] :> fd[0]};
   Function[Evaluate[{rr, zm, zh, rM}], Evaluate[Table[Coefficient[e, fd[k]], {k, 0, n}]]]];
sinD[k_, c_] := D[Sqrt[1 - cc^2], {cc, k}] /. cc -> c;
(* (i, j)-derivative of Q = h / sin^sw(theta) in the panel variables, then the r chain rule; the sin(theta) factor by Leibniz in chi *)
interpQ[cname_, r0_, c0_, i_, jq_] := Module[{x = r0 - rp, p, q, t, z0, co, Tt, Tc},
   Tc = ChebyshevT[Range[0, nchi - 1], c0];
   If[x < xMax,
    p = panelIndex[x]; t = (x - panMid[p])/panH[p]; Tt = ChebyshevT[Range[0, nPn - 1], t];
    (Tt . c2Cache[cname, "in", p, i, jq] . Tc)/panH[p]^i,
    z0 = rMax/r0; q = Min[nOut, Max[1, LengthWhile[zB, # <= z0 &]]]; t = (z0 - zMid[q])/zH[q]; Tt = ChebyshevT[Range[0, nPn - 1], t];
    co = chainOuter[i][r0, zMid[q], zH[q], rMax];
    Sum[co[[k + 1]] (Tt . c2Cache[cname, "out", q, k, jq] . Tc), {k, 0, i}]]];
hInterp[cname_, r0_, c0_, {i_, j_}] := If[cname === "hlmb",
   Sum[Binomial[j, m] sinD[j - m, c0] interpQ[cname, r0, c0, i, m], {m, 0, j}],
   interpQ[cname, r0, c0, i, j]];

(* ---------------------------------------------------------------- public: ORG components *)
(* amplitude factor: "Physical" (default) = A^2 of the run (cloud mass BOSON_CLOUDMASS), "Unit" = per unit A^2 (Leaver normalization) *)
ampF[a_] := Switch[a, "Physical", amp2, "Unit", 1, _, Message[hComponent::amp, a]; Abort[]];
hComponent::amp = "\"Amplitude\" must be \"Physical\" or \"Unit\", not `1`.";
Options[hComponent] = {"Amplitude" -> "Physical"};
hComponent[cname_String, r0_?NumericQ, c0_?NumericQ, ij : {_Integer?NonNegative, _Integer?NonNegative} : {0, 0}, OptionsPattern[]] :=
  (check[]; ampF[OptionValue["Amplitude"]] hComp0[cname, r0, c0, ij]);
(* per unit A^2 *)
hComp0[cname_String, r0_?NumericQ, c0_?NumericQ, {i_Integer?NonNegative, j_Integer?NonNegative}] := (check[];
   With[{rr = toWP[r0], cc = toWP[c0]},
    Switch[cname,
     "hmbmb", hmbmb[rr, cc, {i, j}],
     "hmmb", hmmb[rr, cc, {i, j}],
     "hlmb" | "hll", hInterp[cname, rr, cc, {i, j}],
     "hmm", Conjugate[hmbmb[rr, cc, {i, j}]],
     "hlm", Conjugate[hInterp["hlmb", rr, cc, {i, j}]],
     _, Message[hComponent::comp, cname]; $Failed]]);
hComponent::comp = "unknown component `1`; use \"hmbmb\", \"hmmb\", \"hlmb\", \"hll\" (or \"hmm\", \"hlm\").";

(* ---------------------------------------------------------------- completion (closed form) *)
compD[which_, i_, j_] := memo[{"comp", which, i, j}, Module[{rr, cc, e},
   e = rcSub[comp[which], rr, cc];
   Function[Evaluate[{rr, cc}], Evaluate[D[e, {rr, i}, {cc, j}]]]]];
Options[hCompletion] = {"Amplitude" -> "Physical"};
hCompletion[r0_?NumericQ, c0_?NumericQ, ij : {_Integer?NonNegative, _Integer?NonNegative} : {0, 0}, OptionsPattern[]] :=
  (check[]; Map[ampF[OptionValue["Amplitude"]] # &, hCompletion0[r0, c0, ij]]);
(* per unit A^2 *)
hCompletion0[r0_?NumericQ, c0_?NumericQ, {i_Integer?NonNegative, j_Integer?NonNegative}] := (check[];
   With[{rr = toWP[r0], cc = toWP[c0]},
    AssociationThread[{"ll", "lm", "lmb"}, cM compD["tetrad_ER_unit_dM", i, j][rr, cc] + cA compD["tetrad_ER_unit_da", i, j][rr, cc]]]);

(* ---------------------------------------------------------------- all tetrad components *)
Options[hTetrad] = {"Completion" -> True, "Amplitude" -> "Physical"};
hTetrad[r0_?NumericQ, c0_?NumericQ, ij : {_Integer?NonNegative, _Integer?NonNegative} : {0, 0}, OptionsPattern[]] := Module[{lmb, mbmb, h, hc, s},
   check[];
   lmb = hComp0["hlmb", r0, c0, ij]; mbmb = hComp0["hmbmb", r0, c0, ij];
   h = <|"ll" -> hComp0["hll", r0, c0, ij], "lm" -> Conjugate[lmb], "lmb" -> lmb, "mm" -> Conjugate[mbmb], "mbmb" -> mbmb,
     "mmb" -> hComp0["hmmb", r0, c0, ij]|>;
   If[TrueQ[OptionValue["Completion"]], hc = hCompletion0[r0, c0, ij];
    h = <|"ll" -> h["ll"] + hc["ll"], "lm" -> h["lm"] + hc["lm"], "lmb" -> h["lmb"] + hc["lmb"], "mm" -> h["mm"], "mbmb" -> h["mbmb"], "mmb" -> h["mmb"]|>];
   s = ampF[OptionValue["Amplitude"]];
   Map[s # &, h]];

(* ---------------------------------------------------------------- background: Kerr metric and the coframe (pipeline section 1, M = 1) *)
bgSym := memo[{"bg"}, Module[{rr, cc, a = aN, gdd, lu, nu, mu, mbu, eDu, eDd, eta},
   gdd = {{-(1 - (2 rr)/(rr^2 + a^2 cc^2)), 1, 0, -(2 a rr (1 - cc^2))/(rr^2 + a^2 cc^2)},
     {1, 0, 0, -a (1 - cc^2)},
     {0, 0, (rr^2 + a^2 cc^2)/(1 - cc^2), 0},
     {-(2 a rr (1 - cc^2))/(rr^2 + a^2 cc^2), -a (1 - cc^2), 0, (1 - cc^2) (rr^2 + a^2 + (2 a^2 rr (1 - cc^2))/(rr^2 + a^2 cc^2))}};
   lu = {(rr^2 + a^2)/(rr^2 + a^2 cc^2), (rr^2 - 2 rr + a^2)/(2 (rr^2 + a^2 cc^2)), 0, a/(rr^2 + a^2 cc^2)};
   nu = {0, -1, 0, 0};
   mu = 1/(Sqrt[2] (rr + I a cc)) {I a Sqrt[1 - cc^2], 0, -Sqrt[1 - cc^2], I/Sqrt[1 - cc^2]};
   mbu = 1/(Sqrt[2] (rr - I a cc)) {-I a Sqrt[1 - cc^2], 0, -Sqrt[1 - cc^2], -I/Sqrt[1 - cc^2]};       (* conj(m) for real r, chi, a *)
   eDu = {lu, nu, mu, mbu};
   eDd = eDu . gdd;                                     (* e_{a mu} = g_{mu nu} e_a^nu *)
   eta = {{0, -1, 0, 0}, {-1, 0, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}};
   {rr, cc, gdd, Inverse[eta] . eDd}]];                 (* coframe omega^a_mu = eta^{ab} e_{b mu} *)
frameD[i_, j_] := memo[{"frame", i, j}, With[{b = bgSym}, Function[Evaluate[{b[[1]], b[[2]]}], Evaluate[D[b[[4]], {b[[1]], i}, {b[[2]], j}]]]]];
kerrD[i_, j_] := memo[{"kerr", i, j}, With[{b = bgSym}, Function[Evaluate[{b[[1]], b[[2]]}], Evaluate[D[b[[3]], {b[[1]], i}, {b[[2]], j}]]]]];
gKerr[r0_?NumericQ, c0_?NumericQ, {i_Integer?NonNegative, j_Integer?NonNegative}] := (check[]; kerrD[i, j][toWP[r0], toWP[c0]]);
gKerr[r0_?NumericQ, c0_?NumericQ] := gKerr[r0, c0, {0, 0}];

hTetMat[h_] := {{h["ll"], 0, h["lm"], h["lmb"]}, {0, 0, 0, 0}, {h["lm"], 0, h["mm"], h["mmb"]}, {h["lmb"], 0, h["mmb"], h["mbmb"]}};   (* order l, n, m, mbar *)
(* h_{mu nu} = omega^a_mu h_ab omega^b_nu; derivatives by the Leibniz rule over the three factors *)
Options[hCoord] = Options[hTetrad];
hCoord[r0_?NumericQ, c0_?NumericQ, {i_Integer?NonNegative, j_Integer?NonNegative}, opts : OptionsPattern[]] := Module[{rr = toWP[r0], cc = toWP[c0], H, W},
   check[];
   H[a1_, b1_] := H[a1, b1] = hTetMat[hTetrad[rr, cc, {a1, b1}, opts]];
   W[a1_, b1_] := W[a1, b1] = frameD[a1, b1][rr, cc];
   Sum[Multinomial[i1, i2, i - i1 - i2] Multinomial[j1, j2, j - j1 - j2] Transpose[W[i1, j1]] . H[i2, j2] . W[i - i1 - i2, j - j1 - j2],
    {i1, 0, i}, {i2, 0, i - i1}, {j1, 0, j}, {j2, 0, j - j1}]];
hCoord[r0_?NumericQ, c0_?NumericQ, opts : OptionsPattern[]] := hCoord[r0, c0, {0, 0}, opts];

Options[gTotal] = {"Completion" -> True};
gTotal[r0_?NumericQ, c0_?NumericQ, ij : {_Integer?NonNegative, _Integer?NonNegative} : {0, 0}, OptionsPattern[]] :=
  gKerr[r0, c0, ij] + hCoord[r0, c0, ij, "Completion" -> OptionValue["Completion"], "Amplitude" -> "Physical"];

bcmParameters[] := (check[]; <|"params" -> dat["params"], "rplus" -> rp, "xMax" -> xMax, "rMax" -> rMax, "innerPanels" -> nPan, "outerPanels" -> nOut,
    "nodesPerPanel" -> nPn, "nchi" -> nchi, "lList" -> lList, "amp2" -> amp2, "completionCoefficients" -> {cM, cA},
    "totalMass" -> comp["totalMass"], "totalAngularMomentum" -> comp["totalAngularMomentum"], "conventions" -> dat["conventions"]|>);

(* ---------------------------------------------------------------- self-test *)
relE[x_, y_] := Abs[x - y]/Max[Abs[y], 10^-300];
(* a computed difference is either a number or a zero of significance arithmetic (0``k, i.e. below 10^-k): print it as such *)
fmt[x_] := Which[! NumericQ[x], "NOT NUMERIC", x == 0, If[Accuracy[x] === Infinity, "0", "< 1e-" <> ToString[Floor[Accuracy[x]]]],
   True, Module[{e = Floor[Log10[Abs[N[x]]]]}, ToString[NumberForm[N[x/10^e], {3, 2}]] <> "e" <> ToString[e]]];
passQ[x_, tol_] := NumericQ[x] && If[x == 0, Accuracy[x] === Infinity || Accuracy[x] > -Log10[N[tol]], x < tol];
bcmSelfTest[] := Module[{ref, res, pts, eps, ok = True, e, w, cr},
   check[];
   (* 1. reference values stored by the pipeline *)
   ref = dat["reference"];
   Print["1. reference values of the run (relative difference):"];
   Do[res = Table[relE[hComp0[c, pt["r"], pt["chi"], {0, 0}], pt[c]], {c, {"hmbmb", "hmmb", "hlmb", "hll"}}];
    Print["   (r, chi) = (", NumberForm[N[pt["r"]], 9], ", ", NumberForm[N[pt["chi"]], 4], "):  hmbmb ", fmt[res[[1]]], ",  hmmb ", fmt[res[[2]]],
     ",  hlmb ", fmt[res[[3]]], ",  hll ", fmt[res[[4]]]];
    If[! AllTrue[res, passQ[#, 10^-25] &], ok = False], {pt, ref}];
   (* 2. coframe: tetrad -> coordinates of the ER zero modes vs the coordinate components stored by the pipeline *)
   e = Max[Table[Module[{t = tc[[1]], c = tc[[2]], tet, crd, W0},
       tet = rcSub[comp[t], 37/10, 3/10]; crd = rcSub[comp[c], 37/10, 3/10]; W0 = frameD[0, 0][N[37/10, wp], N[3/10, wp]];
       Max[Abs[Flatten[N[Transpose[W0] . hTetMat[<|"ll" -> tet[[1]], "lm" -> tet[[2]], "lmb" -> tet[[3]], "mm" -> 0, "mbmb" -> 0, "mmb" -> 0|>] . W0 - crd, wp]]]]/
        Max[Abs[Flatten[N[crd, wp]]]]], {tc, {{"tetrad_ER_unit_dM", "coord_ER_unit_dM"}, {"tetrad_ER_unit_da", "coord_ER_unit_da"}}}]];
   Print["2. coframe: omega^T h_tetrad omega of the ER modes = stored coordinate components (relative difference):  ", fmt[e]];
   If[! passQ[e, 10^-25], ok = False];
   (* 3. derivatives vs central finite differences; steps 10^-10 in chi and 10^-10 max(1, r - r+) in r: truncation error <~ 10^-14 relative
      (panel width ~ 10^-3 at the innermost point), round-off of the 2nd differences ~ 10^-17 with the ~37 significant digits of h_ll;
      points inside panels, inner and outer region *)
   eps = N[10^-10, wp];
   pts = {{rp + 3/1000, 21/100}, {37/10, -3/10}, {12, 7/10}, {150, 1/3}, {5000, 21/100}};
   Print["3. derivatives vs finite differences (max relative difference over the points; h_mmbar only inside rMax):"];
   Do[Module[{dr, dc, drr, dcc, drc},
      w = Select[pts, c =!= "hmmb" || #[[1]] - rp < xMax &];
      {dr, dc, drr, dcc, drc} = Max /@ Transpose[Table[Module[{r0 = N[pt[[1]], wp], c0 = N[pt[[2]], wp], f, er},
          er = eps Max[1, r0 - rp];
          f[a1_, b1_] := hComp0[c, r0 + a1 er, c0 + b1 eps, {0, 0}];
          {relE[hComp0[c, r0, c0, {1, 0}], (f[1, 0] - f[-1, 0])/(2 er)],
           relE[hComp0[c, r0, c0, {0, 1}], (f[0, 1] - f[0, -1])/(2 eps)],
           relE[hComp0[c, r0, c0, {2, 0}], (f[1, 0] - 2 f[0, 0] + f[-1, 0])/er^2],
           relE[hComp0[c, r0, c0, {0, 2}], (f[0, 1] - 2 f[0, 0] + f[0, -1])/eps^2],
           relE[hComp0[c, r0, c0, {1, 1}], (f[1, 1] - f[1, -1] - f[-1, 1] + f[-1, -1])/(4 er eps)]}], {pt, w}]];
      Print["   ", c, ":  d_r ", fmt[dr], ",  d_chi ", fmt[dc], ",  d_r^2 ", fmt[drr], ",  d_chi^2 ", fmt[dcc], ",  d_r d_chi ", fmt[drc]];
      If[! AllTrue[{dr, dc, drr, dcc, drc}, passQ[#, 10^-10] &], ok = False]], {c, {"hmbmb", "hmmb", "hlmb", "hll"}}];
   (* 4. spectral d_r of h_lmbar, h_ll at the nodes vs the d_r values stored by the pipeline (from the ODE solution) *)
   cr = Max[Table[Module[{p = pp, j = 7, V, r0},
       r0 = rp + panMid[p] + panH[p] Cos[Pi (j - 1/2)/nPn];
       V = dat[c]["drInner"][[p, j]];
       Max[Table[relE[hComp0[c, r0, chiN[[k]], {1, 0}], V[[k]]], {k, {5, Ceiling[nchi/2], nchi - 5}}]]], {c, {"hlmb", "hll"}}, {pp, {1, 30, Ceiling[nPan/2], nPan}}]];
   Print["4. spectral d_r of h_lmbar, h_ll at nodes vs the stored d_r (ODE):  ", fmt[cr]];
   If[! passQ[cr, 10^-20], ok = False];
   (* 5. completion: numeric at a test point, and hTetrad - hTetrad(no completion) = hCompletion *)
   e = Module[{hc = hCompletion[3, 1/2, "Amplitude" -> "Unit"], d1 = hTetrad[3, 1/2, "Amplitude" -> "Unit"], d0 = hTetrad[3, 1/2, "Completion" -> False, "Amplitude" -> "Unit"]},
      If[! AllTrue[Values[hc], NumericQ], "NOT NUMERIC", Max[Table[relE[d1[k] - d0[k], hc[k]], {k, {"ll", "lm", "lmb"}}]]]];
   Print["5. completion at (r, chi) = (3, 1/2), per unit A^2: ", N[hCompletion[3, 1/2, "Amplitude" -> "Unit"], 12],
    ";  hTetrad with - without completion vs hCompletion: ", fmt[e]];
   If[! passQ[e, 10^-30], ok = False];
   Print["6. completion (c_M, c_a) = ", N[{cM, cA}, 12], ",  A^2 = ", N[amp2, 12], ",  total mass = ", N[comp["totalMass"], 12],
    ",  total J = ", N[comp["totalAngularMomentum"], 12]];
   Print[If[ok, "SELF-TEST PASSED", "SELF-TEST: SOME DIFFERENCES ABOVE THE EXPECTED LEVEL (see above)"]];
   ok];

End[];
EndPackage[];
