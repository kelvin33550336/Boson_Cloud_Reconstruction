(* ::Package:: *)
(* Spin_Scan_G1/boson_cloud_pipeline_spinscan_lm_slim.wl  --  SLIM-OUTPUT version of Spin_Scan_G1/boson_cloud_pipeline_spinscan_lm.wl (that file is unchanged).
   Same physics, numerics and checks; only the output changes: ONE data file, boson_cloud.wdx (portable WDX; no .mx files except the cloud-independent
   Einstein-operator cache ORG_Einstein_operators_M1.mx in BOSON_CACHEDIR), an Association with the keys
     "format", "params", "conventions"                 run parameters (wp digits) and conventions (G = 1, delta G_ab = 8 Pi T_ab, Phi = Sqrt[amp2] Phi_unit);
     "grid", "hmbmb", "hmmb", "hlmb", "hll",           the metric perturbation h_ORG (per unit amp2): panel grid, spectral coefficients of h_mbarmbar (I1, I2, I3,
       "homogeneous", "completion", "reference"         g per l, Cup) and h_mmbar (tau, K1..K3), node values of h_lmbar, h_ll; the completion (zero modes,
                                                        amp2, charges); reference values of h at 5 points (the former h_ORG_cloud.wdx, without the node
                                                        d_r of h_lmbar, h_ll, the operator coefficients and the l-convergence copy);
     "scalar"                                          the cloud: <|"cloud" -> <|"fPanels" (Chebyshev coefficients of f and its first three r-derivatives per radial panel),
                                                        "seriesTerms", "cP", "jList", "bBHPT", "PpolyR", "aThreshold", "nCF"|>, "reference" (f, S, Psi4, T at
                                                        4 points)|> (instead of the Leaver series a_n: up to 1e7 terms at 70 digits);
     "psi4"                                            Psi4 modes: lList, xB, xMax, nPn, W4, sol (per l: cRp = Chebyshev coefficients of R_l per panel, Cin,
                                                        Cup, Wronskian);
     "diagnostics"                                     everything plot_boson_cloud.wl plots (the former h_diagnostics.wdx, machine precision).
   Text files as before: checks.tsv, timing.tsv, l_convergence.tsv, adm_charges.tsv, spin_scan_point.tsv (small; also inside "diagnostics"/"completion").
   Readers: Spin_Scan_G1/Tools/boson_cloud_tools.wl (metric + scalar field, loadCloud["boson_cloud.wdx"]) and Spin_Scan_G1/plot_boson_cloud.wl.
   Header of Spin_Scan_G1/boson_cloud_pipeline_spinscan_lm.wl:
   Spin_Scan_G1/boson_cloud_pipeline_spinscan_lm.wl  --  G = 1 CONVENTION version of Spin_Scan/boson_cloud_pipeline_spinscan_lm.wl (that file is unchanged).
   Units G = c = 1, M = 1; the Einstein equation is G_ab = 8 Pi T_ab, linearized  delta G_ab[h] = 8 Pi T_ab, with the complex-field stress tensor
     T_ab = d_a Phi d_b conj(Phi) + d_b Phi d_a conj(Phi) - g_ab (g^cd d_c Phi d_d conj(Phi) + mu^2 |Phi|^2),   Phi = A Phi_unit,
   Phi_unit = e^{-i omega t + i m phi} f(r) S(theta) with the Leaver normalization a_0 = 1 and Integral |S|^2 dOmega = 1.
   Everything stored (T_ab, Psi4, h_ORG, the completion, E_cloud, J_cloud) is per unit A^2 = amp2; the physical scalar field is Sqrt[amp2] Phi_unit and the
   physical metric perturbation is amp2 (h_ORG + h_comp). Cloud charges: E_cloud = 2 Pi Integral dchi dr Sigma (-T^v_v), J_cloud = 2 Pi Integral dchi dr Sigma T^v_phi
   (the standard mass and angular momentum of the field; amp2 E_cloud = M_cloud = BOSON_CLOUDMASS).
   Changes with respect to Spin_Scan/boson_cloud_pipeline_spinscan_lm.wl (8 Pi G = 1, delta G_ab = T_ab, E_cloud = (1/4) Integral Sigma (-T^v_v)):
     the Einstein source is kapE T_ab with kapE = 8 Pi (TnnC, TnmbC, TmbmbC (Teukolsky source S4T, T_nn, T_nmbar), tau = T_nn/S^2 (h_mmbar), TabSym (the
     sources of h_lmbar, h_ll and every Einstein residual)); Tdd1 and the charge densities stay T_ab; E_cloud, J_cloud = 2 Pi (integral) instead of (1/4) (integral).
     Hence, for the same cloud: h_ORG, h_comp, Psi4, E_cloud, J_cloud per unit amp2 are 8 Pi times the old ones, amp2 is 1/(8 Pi) times the old A2, and the physical
     metric amp2 (h_ORG + h_comp), the ADM charges and every check (all relative) are unchanged. params -> "einsteinEquation" marks the convention.
   Header of Spin_Scan/boson_cloud_pipeline_spinscan_lm.wl:
   boson_cloud_pipeline_spinscan_lm.wl  --  GENERAL (l, m) version of Spin_Scan/boson_cloud_pipeline_spinscan.wl (that file is unchanged).
   The cloud is the ground state (no radial node) of the (l, m) scalar mode, BOSON_L = l, BOSON_M = m, integers with l >= m >= 1 (default l = m = 1).
   Changes with respect to boson_cloud_pipeline_spinscan.wl (each reduces exactly to the original expression for l = m = 1):
     omega = m Omega_H; angular continued fraction k1 = k2 = m/2; start of the eigenvalue search A = l(l+1); hydrogenic estimates with n = l + 1:
     mu_g = omega (1 + omega^2/(2 n^2)), |q| ~ omega^2/n; mc -> m in the stress tensor; S = sin^m(theta) P(chi) with
     _0Y_{jm} = (-1)^m Sqrt[(2j+1)(j-m)!/(4 Pi (j+m)!)] sin^m(theta) P_j^{(m)}(chi); h_mmbar = -(1-chi^2)^m P^2 (...).
     Root selection: with one sign change of F in the mass window (always the case for l = m = 1) the bracket is used as before; with several, each
     is classified by bisection (|F| -> 0: root, |F| -> infinity: pole of the continued fraction) and the root with the LARGEST mu is taken
     (overtones n_r > 0 have smaller mu at fixed omega); the node check of section 4 confirms the ground state.
     New check: S(chi) = sin^m P from the polynomial vs the BHPToolkit spheroidal harmonic. New outputs: "l", "m" in params, columns l, m in spin_scan_point.tsv.
   Header of boson_cloud_pipeline_spinscan.wl:
   boson_cloud_pipeline_spinscan.wl  --  SPIN SCAN version of Stable/boson_cloud_pipeline_diag.wl (that file is unchanged).
   The spin a is GIVEN (environment variable BOSON_SPIN, e.g. "1/20" or "0.05"), and the cloud is kept exactly at the superradiant threshold,
   omega = m Omega_H(a): the scalar mass mu(a) is SOLVED from the Leaver eigencondition (ground state l = m = 1, n = 0; the existence line of Kerr
   black holes with scalar clouds). Everything after stage 2 is the diag pipeline, with the length scales that were tuned for mu = 0.3 rescaled by
   sc = |q*|/|q| (q* = q at mu = 0.3, |q| ~ mu^2/2 the decay rate of the cloud): radial panel width cap 15 sc, tail-integral range, far test radius,
   NIntegrate split points; the continued-fraction scan depth grows like 1/|q|. Extra outputs: spin_scan_point.tsv (one line per run, collected by
   collect_spin_scan.sh). Extra checks: D: mu > omega (bound state); D: ground state (no radial node of f).
   Original header of boson_cloud_pipeline_diag.wl:
   boson_cloud_pipeline_diag.wl
   = boson_cloud_pipeline_fast.wl + diagnostics for plotting (plot_boson_cloud.wl): writes h_diagnostics.mx / h_diagnostics.wdx with
     all four tetrad components (h_ll, h_lmbar, h_mmbar, h_mbarmbar) on the node grid, the Einstein residuals of the full solution at every node of
     every BOSON_DIAGSTRIDE-th panel (default 4), the per-panel Teukolsky residual of every mode, Chebyshev spectra (radial and \[Chi]) of all components,
     the Klein-Gordon residual profile, the \[ScriptL]-convergence data, the checks and the timing. Physics, numerics and the other outputs are unchanged.
   Optimized version of boson_cloud_pipeline.wl: same physics, numerics, checks and output files. Changes (see the methods notes):
     - numeric functions of large symbolic expressions are built with common-subexpression elimination (optFun), each verified against the plain function;
     - every independent loop runs as parallel jobs (symbolic set-up, Green-function solves split by (\[ScriptL], panel set), mode integrals, checks, NIntegrals
       split by sub-interval, Einstein residuals one node per job);
     - the reconstruction pass keeps the inner radial panels RESIDENT on the subkernels (only panel totals and carries are exchanged).
   Stationary superradiant scalar cloud around Kerr (l = m = 1): Teukolsky source, particular solution \[CapitalPsi]4 (approach 1: fully spectral,
   Gauss-Legendre projection), and the traceful outgoing-radiation-gauge metric reconstruction h_mbarmbar, h_mmbar, h_lmbar, h_ll.
   Batch version of Psi4_scalar_cloud_v10.nb (approach 1 only) + Psi4_metric_reconstruction_v7.nb; no plots, no notebook front end.

   Run:      wolframscript -file boson_cloud_pipeline_diag.wl     (or: math -noprompt -script boson_cloud_pipeline_diag.wl)
   Environment variables (BOSON_SPIN required, the others optional):
     BOSON_SPIN        spin a/M of the black hole, 0 < a < 1, exact ("1/20") or decimal ("0.05", read exactly)
     BOSON_L, BOSON_M  the scalar mode (l, m) of the cloud, integers l >= m >= 1   (default 1, 1)
     BOSON_KERNELMESSAGES  1 = keep messages from the parallel subkernels in the log (default 0: dropped)
     BOSON_OUTDIR      output directory                          (default: the directory of this script)
     BOSON_CACHEDIR    directory of ORG_Einstein_operators_M1.mx  (default: BOSON_OUTDIR; point several runs to one cache)
     BOSON_NKERNELS    number of parallel subkernels              (default: SLURM_CPUS_PER_TASK - 1, else $ProcessorCount - 1; 0 = serial)
     BOSON_LMAX        \[CapitalPsi]4 modes \[ScriptL] = 2..lmax                       (default 36)
     BOSON_WP          working precision in digits                (default 60)
     BOSON_NPN         Chebyshev nodes per radial panel           (default 32)
     BOSON_NCHI        Gauss-Legendre nodes of the angular projection of the source (default 64)
     BOSON_NCHIREC     Chebyshev nodes in \[Chi] of the reconstruction of h_lmbar, h_ll (default 80)
     BOSON_LCUTS       \[ScriptL]_cut values of the \[ScriptL]-convergence study, e.g. "6,12,18,24,30" (default; lmax is always included; "none" = no study).
                       All cuts are computed in the same pass as the full solution. Results: l_convergence.tsv and key "lConvergence" of h_ORG_cloud.
   Output (in BOSON_OUTDIR):
     Psi4_Tab_cloud.mx                 \[CapitalPsi]4, T_ab and the cloud (same layout as block J of the notebooks, without the brute-force TDD)
     h_ORG_cloud.mx                    all components of the metric perturbation (same layout as section 12 of the reconstruction notebook)
     Psi4_Tab_cloud.wdx, h_ORG_cloud.wdx   the same data in the portable WDX format (.mx files can only be read by the same Wolfram version
                                       and operating system: copy the .wdx files to another machine, e.g. for h_ORG_visualization.nb)
     ORG_Einstein_operators_M1.mx      (in BOSON_CACHEDIR) cache of the linearized Einstein operator (independent of the cloud; reused when present)
     checks.tsv                        every check: name, error, tolerance, PASS/FAIL (rewritten after every stage)
   Exit code: 0 if all checks pass, 3 if a check fails (all output files are still written), 1 on an abort. *)

$HistoryLength = 0;
tRun0 = AbsoluteTime[];
envInt[name_String, def_] := With[{v = Environment[name]}, If[StringQ[v] && StringMatchQ[v, DigitCharacter ..], ToExpression[v], def]];
scriptDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[ExpandFileName[$InputFileName]], Directory[]];
outDir = With[{v = Environment["BOSON_OUTDIR"]}, If[StringQ[v] && v =!= "", ExpandFileName[v], scriptDir]];
If[! DirectoryQ[outDir], CreateDirectory[outDir, CreateIntermediateDirectories -> True]];
cacheDir = With[{v = Environment["BOSON_CACHEDIR"]}, If[StringQ[v] && v =!= "", ExpandFileName[v], outDir]];      (* cache of the Einstein operator *)
If[! DirectoryQ[cacheDir], CreateDirectory[cacheDir, CreateIntermediateDirectories -> True]];

(* ---------- plain-text output (no front end: no Style, Grid, 2D exponents) ---------- *)
fmtE = (If[#3 === "", #1, Row[{#1, "e", #3}]] &);
numStr[x_, d_ : 10] := Which[
   ! NumericQ[x], ToString[x, InputForm],
   Head[x] === Complex, numStr[Re[x], d] <> If[TrueQ[Im[x] < 0], " - ", " + "] <> numStr[Abs[Im[x]], d] <> " I",
   ExactNumberQ[x], If[Abs[x] < 10^6 && Abs[x] > 10^-6 || x == 0, ToString[x, InputForm], numStr[N[x, 20], d]],
   x == 0, "0(+-1e" <> ToString[Round[-Accuracy[x]]] <> ")",                 (* a zero of significance arithmetic: show its uncertainty *)
   True, ToString[ScientificForm[N[x], d, NumberFormat -> fmtE]]];
sci[x_List, d_ : 3] := "{" <> StringRiffle[sci[#, d] & /@ x, ", "] <> "}";
sci[x_, d_ : 3] := numStr[x, d];
toStr[s_String] := s;
toStr[l_List] := "{" <> StringRiffle[toStr /@ l, ", "] <> "}";
toStr[x_?NumericQ] := numStr[x, 12];
toStr[x_] := ToString[x, InputForm];
log[args___] := Print[StringJoin[toStr /@ {args}]];
printGrid[Grid[d_List, ___]] := Scan[log[StringRiffle[toStr /@ #, "  |  "]] &, d];

(* ---------- checks ---------- *)
passTol = 10^-8;
(* ---------- diagnostics collected for h_diagnostics.mx/.wdx ---------- *)
diag = <||>;
diagStride = Max[1, envInt["BOSON_DIAGSTRIDE", 4]];          (* node-by-node Einstein residuals on every diagStride-th inner panel (plus the test panels and all outer panels) *)
bndS[x_] := Abs[x] + If[NumberQ[x] && ! MemberQ[{Infinity, MachinePrecision}, Precision[x]], 10^-Accuracy[x], 0];      (* |x| + its significance uncertainty *)
toMach[e_] := e /. x_?(InexactNumberQ[#] && Precision[#] =!= MachinePrecision &) :> SetPrecision[x, MachinePrecision];          (* also inside associations *)
checkLog = {};
checkFile = FileNameJoin[{outDir, "checks.tsv"}];
(* PASS requires err < tol; for a zero of significance arithmetic (0.\[Times]10^-k) its uncertainty 10^-k must also be below tol *)
check[name_String, err_, tol_ : Automatic] := Module[{e = Quiet[N[err]], t = If[tol === Automatic, passTol, tol], ok},
   If[! (NumberQ[e] && Im[e] == 0),
    (* a symbolic / complex leftover: FAIL, keep only a short description in the log and in checks.tsv *)
    log["FAIL ", name, ":   err is NOT NUMERIC: ", ToString[Short[e, 2], InputForm]];
    AppendTo[checkLog, {name, "NOT_NUMERIC", t, False}],
    ok = TrueQ[e < t] && If[Precision[e] =!= Infinity && Precision[e] =!= MachinePrecision && e == 0, Accuracy[e] > -Log10[N[t]], True];
    AppendTo[checkLog, {name, e, t, ok}];
    log[If[ok, "PASS ", "FAIL "], name, ":   err = ", sci[e], "   (tol ", sci[N[t], 1], ")"]];
   e];
(* checks.tsv: plain text, numbers in e-notation; uncertainty = 10^-Accuracy for significance-arithmetic numbers (0 for exact / machine numbers) *)
checkUnc[e_?NumberQ] := If[MemberQ[{Infinity, MachinePrecision}, Precision[e]], 0, 10^-Round[Accuracy[e]]];          (* exact power of ten: printed without underflow *)
checkUnc[e_] := "NA";
saveChecks[] := writeTSV[checkFile, Prepend[{#[[1]], #[[2]], checkUnc[#[[2]]], #[[3]], If[#[[4]], "PASS", "FAIL"]} & /@ checkLog,
    {"check", "error", "uncertainty", "tolerance", "result"}]];
(* ---------- timing: every stage and every tm[...] step is timed; the table is printed at the end and written to timing.tsv ---------- *)
stageLog = {}; tmLog = {}; stageName = "0. setup"; stageT0 = AbsoluteTime[];
stage[title_String] := Module[{t = AbsoluteTime[]},
   AppendTo[stageLog, {stageName, t - stageT0}];
   log["   [", stageName, " took ", Round[t - stageT0, 0.1], " s]"];
   stageName = title; stageT0 = t; saveChecks[];
   log["\n==== ", title, "   [", Round[t - tRun0], " s elapsed, ", Round[MemoryInUse[]/10.^9, 0.01], " GB in use, checks so far: ",
     Count[checkLog[[All, 4]], True], " pass / ", Count[checkLog[[All, 4]], False], " fail]"]];
SetAttributes[tm, HoldRest];
tm[label_String, expr_] := Module[{t = AbsoluteTiming[expr;]}, AppendTo[tmLog, {stageName, label, First[t]}]; log["   ", label, ": ", Round[First[t], 0.1], " s"]];
timingReport[] := Module[{tot = AbsoluteTime[] - tRun0},
   log["\n==== TIMING (wall clock, ", If[useParallel, Length[Kernels[]], 0], " subkernels)"];
   Scan[log["   ", StringPadRight[#[[1]], 72], StringPadLeft[ToString[Round[#[[2]], 0.1]], 10], " s   ", StringPadLeft[ToString[Round[100 #[[2]]/tot, 0.1]], 5], " %"] &, stageLog];
   log["   ", StringPadRight["total", 72], StringPadLeft[ToString[Round[tot, 0.1]], 10], " s"];
   log["   timed steps:"]; Scan[log["      ", #[[1]], "  |  ", #[[2]], ": ", Round[#[[3]], 0.1], " s"] &, tmLog];
   writeTSV[FileNameJoin[{outDir, "timing.tsv"}], Join[{{"section", "step", "seconds"}}, {#[[1]], "(whole section)", Round[#[[2]], 0.01]} & /@ stageLog,
      {#[[1]], #[[2]], Round[#[[3]], 0.01]} & /@ tmLog, {{"total", "NA", Round[tot, 0.01]}}]]];
tsvCell[x_String] := x;
tsvCell[x_Integer] := ToString[x];
(* numbers: exact ones at 16 digits without binary rounding (10^-45 -> 1.e-45, not 1.0000000000000001e-45); machine ones as they are; arbitrary-precision ones
   at their own precision (max 16 digits). Tiny values do not underflow (an uncertainty 10^-324 stays 1.e-324) *)
tsvCell[x_?NumericQ] := Which[x == 0, "0",
   Precision[x] === MachinePrecision, ToString[CForm[x]],
   True, StringReplace[ToString[CForm[N[x, Min[16, Max[1, Precision[x]]]]]], RegularExpression["[.]0+(e|$)"] -> ".$1"]];          (* 1.000e-45 -> 1.e-45 *)
tsvCell[x_] := "NA";
writeTSV[file_String, rows_List] := Quiet[Export[file, StringRiffle[Map[tsvCell, rows, {2}], "\n", "\t"] <> "\n", "Text"]];
relErr[x_, y_] := Abs[N[x - y, wp]]/Max[Abs[N[y, wp]], 10^-300];
(* largest |x| + (uncertainty of x) over an array: a zero of significance arithmetic 0.\[Times]10^-k counts as 10^-k *)
maxB[l_] := Max[(Abs[#] + If[MemberQ[{Infinity, MachinePrecision}, Precision[#]], 0, 10^-Accuracy[#]]) & /@ Flatten[{l}]];
localExp[f_, x0_] := With[{h = 10^-6}, (Log[Abs[f[x0 (1 + h)]]] - Log[Abs[f[x0 (1 - h)]]])/(Log[1 + h] - Log[1 - h])];   (* d ln|f| / d ln x *)

(* ---------- settings ---------- *)
wp = envInt["BOSON_WP", 60];                (* working precision (digits) *)
lmax = envInt["BOSON_LMAX", 36];            (* \[CapitalPsi]4 modes \[ScriptL] = 2..lmax *)
nChi = envInt["BOSON_NCHI", 64];            (* Gauss-Legendre nodes in \[Chi] for the projection of the source *)
nP = 32;                                    (* Chebyshev nodes in \[Chi] for P(\[Chi]) = S(\[Chi])/sin^m\[Theta] *)
nTail = Max[64, nChi + 24];                 (* Gauss-Legendre nodes for the \[ScriptL] > lmax remainder (\[ScriptL] up to lmax + 20) *)
nPn = envInt["BOSON_NPN", 32];              (* Chebyshev nodes per radial panel *)
gPan = 13/10; wPan = 15;                    (* radial panels: geometric (ratio gPan) from r - r+ = 10^-6 until the width reaches wPan, then width wPan *)
n\[Chi] = envInt["BOSON_NCHIREC", 80];           (* Chebyshev nodes in \[Chi] for h_lmbar, h_ll *)
(* \[ScriptL]-convergence study: the reconstruction is also done for \[ScriptL] <= each \[ScriptL]_cut, in the same pass as the full solution *)
lCuts = With[{v = Environment["BOSON_LCUTS"]}, If[StringQ[v], ToExpression /@ StringCases[v, DigitCharacter ..], {6, 12, 18, 24, 30}]];
lCuts = Select[Union[lCuts], 2 <= # < lmax &];
doLConv = Length[lCuts] > 0;
(* the spin (exact): "1/20" or "0.05" *)
spinS = With[{v = Environment["BOSON_SPIN"]}, If[! StringQ[v] || StringTrim[v] === "", Missing[],
    With[{x = Quiet[ToExpression[StringReplace[StringTrim[v], {"e" -> "*^", "E" -> "*^"}]]]},
     If[NumericQ[x], If[ExactNumberQ[x], x, Rationalize[x]], Missing[]]          (* "0.05" -> 1/20 *)]]];
If[MissingQ[spinS] || ! (0 < spinS < 1), Print["ERROR: set BOSON_SPIN to the spin a/M, 0 < a < 1 (e.g. BOSON_SPIN=1/20)"]; Exit[1]];
(* the scalar mode (l, m) of the cloud: superradiant (m >= 1), l >= m *)
ellS = envInt["BOSON_L", 1]; emS = envInt["BOSON_M", 1];
If[! (IntegerQ[ellS] && IntegerQ[emS] && ellS >= emS >= 1), Print["ERROR: BOSON_L, BOSON_M must be integers with l >= m >= 1 (got ", ellS, ", ", emS, ")"]; Exit[1]];

Needs["Teukolsky`"]; Needs["SpinWeightedSpheroidalHarmonics`"]; Needs["NumericalDifferentialEquationAnalysis`"];
$Assumptions = {r > 2 M, -1 < \[Chi] < 1, 0 < \[Phi] < 2 Pi, 0 <= a <= 1, 0 < b <= 1, M > 0};
$MaxExtraPrecision = 2000;

(* ---------- parallel subkernels ---------- *)
nKernels = envInt["BOSON_NKERNELS", Max[0, envInt["SLURM_CPUS_PER_TASK", $ProcessorCount] - 1]];
useParallel = nKernels > 0;
kernelMessages = envInt["BOSON_KERNELMESSAGES", 0] == 1;
If[useParallel,
  Quiet[LaunchKernels[nKernels]];
  If[Length[Kernels[]] == 0, useParallel = False; log["WARNING: no subkernels could be launched (license?); running serially"],
   ParallelNeeds["Teukolsky`"]; ParallelNeeds["SpinWeightedSpheroidalHarmonics`"]; ParallelNeeds["NumericalDifferentialEquationAnalysis`"];      (* GaussianQuadratureWeights in the E4 jobs *)
   ParallelEvaluate[$HistoryLength = 0; $MaxExtraPrecision = 2000; $Assumptions = {r > 2 M, -1 < \[Chi] < 1, 0 < \[Phi] < 2 Pi, 0 <= a <= 1, 0 < b <= 1, M > 0}];
   (* messages issued on the subkernels are forwarded to the log with a "From KernelObject[...]" prefix, which a batch kernel prints in raw internal form;
      by default they are dropped (BOSON_KERNELMESSAGES=1 keeps them) *)
   If[! kernelMessages, ParallelEvaluate[$Messages = {}]]]];
(* pMap: one item per job on the subkernels (definitions of Global` symbols are distributed automatically), or Map *)
pMap[f_, list_List] := If[useParallel, ParallelMap[f, list, Method -> "FinestGrained"], Map[f, list]];
(* rEval: evaluate on every subkernel (kernel-resident data of section 14), or once on the master when serial; returns the list of results *)
SetAttributes[rEval, HoldFirst];
rEval[expr_] := If[useParallel, ParallelEvaluate[expr], {expr}];
(* optFun: numeric function of a symbolic expression with its common subexpressions computed once (Experimental`OptimizeExpression). It is compared with
   the plain Function at the test arguments; if they differ by more than 10^-(wp-20) (relative) the plain Function is used. *)
relDiffL[x_, y_] := Max[Abs[Flatten[{N[x - y, wp]}]]]/Max[Max[Abs[Flatten[{N[y, wp]}]]], 10^-300];
(* the Function is assembled with Apply, so that its parameters are not renamed (a rule r.h.s. Function[vars, b] would rename them, the optimized Block containing
   the same symbols); the test is done at a scalar point and with \[Chi] (2nd argument) a 2-vector, as on the node grids *)
optFun[vars_List, expr_, test_List] := Module[{oe = Quiet[Check[Experimental`OptimizeExpression[expr], $Failed]], fo, fp = Function @@ {vars, expr}, d, testV},
   fo = If[MatchQ[oe, Experimental`OptimizedExpression[_]], Function @@ Join[Hold @@ {vars}, Apply[Hold, oe]], fp];
   testV = ReplacePart[test, 2 -> {test[[2]], -test[[2]]/2}];
   d = Quiet[Max[relDiffL[fo @@ test, fp @@ test], relDiffL[fo @@ testV, fp @@ testV]]];
   If[TrueQ[d < 10^-(wp - 20)], fo, log["WARNING: CSE-optimized function differs from the plain one (", If[NumericQ[d], d, "not numeric"], "); using the plain function"]; fp]];
log["boson_cloud_pipeline_diag.wl   ", DateString[], "   $Version = ", $Version, "   host = ", $MachineName];
log["output directory: ", outDir, ";  operator cache: ", cacheDir];
log["subkernels: ", If[useParallel, Length[Kernels[]], 0], ";  wp = ", wp, ", lmax = ", lmax, ", \[ScriptL]_cut = ", lCuts, ", nChi = ", nChi, ", nP = ", nP, ", nPn = ", nPn, ", n\[Chi] (reconstruction) = ", n\[Chi]];

(* ==================================================================================================== *)
stage["1. Kerr background: ingoing coordinates, tetrad, spin coefficients, GHP operators"];
x = {v, r, \[Chi], \[Phi]}; dim = Length[x];
gdd = {{-(1 - (2 M r)/(r^2 + a^2 \[Chi]^2)), 1, 0, -(2 a M r (1 - \[Chi]^2))/(r^2 + a^2 \[Chi]^2)},
       {1, 0, 0, -a (1 - \[Chi]^2)},
       {0, 0, (r^2 + a^2 \[Chi]^2)/(1 - \[Chi]^2), 0},
       {-(2 a M r (1 - \[Chi]^2))/(r^2 + a^2 \[Chi]^2), -a (1 - \[Chi]^2), 0, (1 - \[Chi]^2) (r^2 + a^2 + (2 a^2 M r (1 - \[Chi]^2))/(r^2 + a^2 \[Chi]^2))}} // Simplify;
guu = Inverse[gdd] // Factor;
\[Eta]DD = {{0, -1, 0, 0}, {-1, 0, 0, 0}, {0, 0, 0, 1}, {0, 0, 1, 0}};
lu = {(r^2 + a^2)/(r^2 + a^2 \[Chi]^2), (r^2 - 2 M r + a^2)/(2 (r^2 + a^2 \[Chi]^2)), 0, a/(r^2 + a^2 \[Chi]^2)} // Simplify;
nu = {0, -1, 0, 0};
mu = 1/(Sqrt[2] (r + I a \[Chi])) {I a Sqrt[1 - \[Chi]^2], 0, -Sqrt[1 - \[Chi]^2], I/Sqrt[1 - \[Chi]^2]} // FullSimplify;
mbaru = Conjugate[mu] // FullSimplify;
eDu = {lu, nu, mu, mbaru} // Simplify;
eDd = ArrayReshape[pMap[FullSimplify, Flatten[Table[Sum[gdd[[i, j]] eDu[[\[Beta]1, i]], {i, 1, dim}], {\[Beta]1, 1, dim}, {j, 1, dim}]]], {dim, dim}];      (* one entry per job *)
(* Christoffel symbols and the connection coefficients \[Gamma]_{cdb} = e_c^i e_b^j \:2207_j e_{d i} *)
\[CapitalGamma]ddd = ArrayReshape[pMap[Function[kij, With[{k = kij[[1]], i = kij[[2]], j = kij[[3]]}, Factor[1/2 (D[gdd[[k, i]], x[[j]]] + D[gdd[[k, j]], x[[i]]] - D[gdd[[i, j]], x[[k]]])]]],
    Tuples[Range[dim], 3]], {dim, dim, dim}];          (* one (k, i, j) per job *)
\[CapitalGamma]udd = ArrayReshape[pMap[Function[kij, Factor[Sum[guu[[kij[[1]], l1]] \[CapitalGamma]ddd[[l1, kij[[2]], kij[[3]]]], {l1, dim}]]], Tuples[Range[dim], 3]], {dim, dim, dim}];
(* 64 independent Simplify calls: one (c, d, b) per job *)
\[Gamma]ddd = ArrayReshape[pMap[Function[cdb, Simplify[Sum[(D[eDd[[cdb[[2]], i]], x[[j]]] - Sum[\[CapitalGamma]udd[[k, i, j]] eDd[[cdb[[2]], k]], {k, dim}]) eDu[[cdb[[1]], i]] eDu[[cdb[[3]], j]], {i, dim}, {j, dim}]]],
    Tuples[Range[dim], 3]], {dim, dim, dim}];
(* NP spin coefficients (mostly-plus conventions) *)
{\[Kappa]\[Kappa], \[Rho]\[Rho], \[Epsilon]\[Epsilon], \[Sigma]\[Sigma], \[Mu]\[Mu], \[Gamma]\[Gamma], \[Lambda]\[Lambda], \[Tau]\[Tau], \[Alpha]\[Alpha], \[Nu]\[Nu], \[Pi]\[Pi], \[Beta]\[Beta]} = pMap[Simplify, {\[Gamma]ddd[[1, 3, 1]], \[Gamma]ddd[[1, 3, 4]], 1/2 (\[Gamma]ddd[[1, 2, 1]] - \[Gamma]ddd[[3, 4, 1]]), \[Gamma]ddd[[1, 3, 3]],
    -\[Gamma]ddd[[2, 4, 3]], 1/2 (\[Gamma]ddd[[1, 2, 2]] - \[Gamma]ddd[[3, 4, 2]]), -\[Gamma]ddd[[2, 4, 4]], \[Gamma]ddd[[1, 3, 2]], 1/2 (\[Gamma]ddd[[1, 2, 4]] - \[Gamma]ddd[[3, 4, 4]]), -\[Gamma]ddd[[2, 4, 2]],
    -\[Gamma]ddd[[2, 4, 1]], 1/2 (\[Gamma]ddd[[1, 2, 3]] - \[Gamma]ddd[[3, 4, 3]])}];          (* one Simplify per job *)
(* GHP primes and conjugates *)
\[Rho]\[Rho]p = -\[Mu]\[Mu]; \[Epsilon]\[Epsilon]p = -\[Gamma]\[Gamma]; \[Beta]\[Beta]p = -\[Alpha]\[Alpha]; \[Tau]\[Tau]p = -\[Pi]\[Pi]; \[Kappa]\[Kappa]p = -\[Nu]\[Nu]; \[Sigma]\[Sigma]p = -\[Lambda]\[Lambda];
{\[Rho]\[Rho]c, \[Epsilon]\[Epsilon]c, \[Beta]\[Beta]c, \[Tau]\[Tau]c, \[Kappa]\[Kappa]c, \[Sigma]\[Sigma]c, \[Rho]\[Rho]cp, \[Epsilon]\[Epsilon]cp, \[Beta]\[Beta]cp, \[Tau]\[Tau]cp, \[Kappa]\[Kappa]cp, \[Sigma]\[Sigma]cp} =
  pMap[FullSimplify[Conjugate[#]] &, {\[Rho]\[Rho], \[Epsilon]\[Epsilon], \[Beta]\[Beta], \[Tau]\[Tau], \[Kappa]\[Kappa], \[Sigma]\[Sigma], \[Rho]\[Rho]p, \[Epsilon]\[Epsilon]p, \[Beta]\[Beta]p, \[Tau]\[Tau]p, \[Kappa]\[Kappa]p, \[Sigma]\[Sigma]p}];
\[CapitalPsi]2 = -M/(r - I a \[Chi])^3;
(* directional derivatives *)
Dder[xx_] := Sum[lu[[i]] D[xx, x[[i]]], {i, 1, dim}];
\[CapitalDelta]der[xx_] := Sum[nu[[i]] D[xx, x[[i]]], {i, 1, dim}];
\[Delta]der[xx_] := Sum[mu[[i]] D[xx, x[[i]]], {i, 1, dim}];
\[Delta]starder[xx_] := Sum[mbaru[[i]] D[xx, x[[i]]], {i, 1, dim}];
(* GHP derivatives on a quantity of type {p, q} *)
\[Thorn][p_, q_][xx_] := Dder[xx] + (-p \[Epsilon]\[Epsilon] - q \[Epsilon]\[Epsilon]c) xx;
\[Thorn]p[p_, q_][xx_] := \[CapitalDelta]der[xx] + (p \[Epsilon]\[Epsilon]p + q \[Epsilon]\[Epsilon]cp) xx;
\[Eth][p_, q_][xx_] := \[Delta]der[xx] + (-p \[Beta]\[Beta] + q \[Beta]\[Beta]cp) xx;
\[Eth]p[p_, q_][xx_] := \[Delta]starder[xx] + (p \[Beta]\[Beta]p - q \[Beta]\[Beta]c) xx;
(* extended GHP operators: Ext[p, q, r1, s1] adds r1 (spin coeff) + s1 (its conjugate) *)
\[Thorn]Ext[p_, q_, r1_, s1_][xx_] := Simplify[Dder[xx] + (-p \[Epsilon]\[Epsilon] - q \[Epsilon]\[Epsilon]c + r1 \[Rho]\[Rho] + s1 \[Rho]\[Rho]c) xx];
\[Thorn]pExt[p_, q_, r1_, s1_][xx_] := Simplify[\[CapitalDelta]der[xx] + (p \[Epsilon]\[Epsilon]p + q \[Epsilon]\[Epsilon]cp + r1 \[Rho]\[Rho]p + s1 \[Rho]\[Rho]cp) xx];
\[Eth]Ext[p_, q_, r1_, s1_][xx_] := Simplify[\[Delta]der[xx] + (-p \[Beta]\[Beta] + q \[Beta]\[Beta]cp + r1 \[Tau]\[Tau] + s1 \[Tau]\[Tau]cp) xx];
\[Eth]pExt[p_, q_, r1_, s1_][xx_] := Simplify[\[Delta]starder[xx] + (p \[Beta]\[Beta]p - q \[Beta]\[Beta]c + r1 \[Tau]\[Tau]p + s1 \[Tau]\[Tau]c) xx];

(* ==================================================================================================== *)
stage["2. Scalar cloud at the threshold of the given spin: Leaver / Dolan solver for the mass \[Mu]"];
(* Spin scan: the spin a = BOSON_SPIN is given and the cloud sits exactly at the superradiant threshold \[Omega] = m \[CapitalOmega]_H(a). The l = m = 1 ground state is
   stationary there for one value of the scalar mass, \[Mu](a): with \[Omega] fixed the Leaver recurrence coefficients are real and the eigencondition is one real
   equation F(\[Mu]) = 0 for the real unknown \[Mu] (the angular eigenvalue A(\[Mu]) from its own continued fraction).
   Root selection: hydrogenic estimate \[Mu]g = \[Omega] (1 + \[Omega]^2/8) (ground state: \[Omega] ~ \[Mu] (1 - \[Mu]^2/8)), scan of F in \[Mu] = \[Mu]g (1 + \[Delta] \[Omega]^2),
   \[Delta] = -1/100 .. 6/100. In these units the ground state lies at \[Delta] = 0 .. 0.025 for a = 0.05 .. 0.95, a pole of the continued fraction near \[Delta] = -0.02 and the
   first overtone near \[Delta] = -0.07 (verified for all spins of the scan); the ground state is confirmed by the node count of f (check in section 4).
   The series coefficients decay like exp(-c Sqrt[n]) with c ~ Sqrt[|q|]: |a_n| < 10^-70 needs ~5e4 terms at a = 0.88 and 0.95, 3e5 at a = 0.3, 2.3e6 at a = 0.1,
   8e6 at a = 0.05. The continued fraction and the Miller recursion therefore compute their coefficients on the fly (no arrays of the full depth), and the depth
   of the bracketing scan is scaled with 1/|q|. *)
l1 = ellS; m1 = emS;                               (* the scalar mode (BOSON_L, BOSON_M) *)
log["scalar mode: l = ", l1, ", m = ", m1, ",  ground state (no radial node), hydrogenic n = ", l1 + 1];
aa = spinS;                                        (* the given spin (exact) *)
precL = Max[2 wp + 40, 120];                       (* digits for the eigenvalue problem and the coefficients (FindRoot::precw suppressed; checked by the D checks) *)
tolA = 10^-(wp + 10);                              (* series truncation: |a_n| < tolA *)
\[Omega]Hof[as_] := m1 as/(2 (1 + Sqrt[1 - as^2]));       (* m \[CapitalOmega]_H, M = 1 *)
(* \[Mu]S (the scalar mass) is a global read by leaverC and angularCF; the functions ...Mu[\[Mu], ...] evaluate them at a trial mass with Block *)
leaverC[as_, A_] := Module[{w = \[Omega]Hof[as], q, b = Sqrt[1 - as^2], m = m1, \[Mu] = \[Mu]S},
   q = -Sqrt[\[Mu]^2 - w^2];
   {1 - 2 I w - (2 I)/b (w - (as m)/2),
    -4 + 4 I (w - I q (1 + b)) + (4 I)/b (w - (as m)/2) - (2 (w^2 + q^2))/q,
    3 - 2 I w - (2 I)/b (w - (as m)/2) - 2 (q^2 - w^2)/q,
    2 I (w - I q)^3/q + 2 (w - I q)^2 b + q^2 as^2 + 2 I q as m - A - 1 - (w - I q)^2/q + 2 q b + 2 I/b ((w - I q)^2/q + 1) (w - (as m)/2),
    (w - I q)^4/q^2 + 2 I w (w - I q)^2/q - 2 I/b (w - I q)^2/q (w - (as m)/2)}];
(* \[Alpha]_n = n^2 + (c1 + 1) n + c1, \[Beta]_n = -2 n^2 + (c2 + 2) n + c4, \[Gamma]_n = n^2 + (c3 - 3) n + c5 (real at threshold: Re removes the round-off of the cancelling
   imaginary parts); evaluated on the fly *)
radialCF[as_, A_, nn_] := Module[{c1, c2, c3, c4, c5, R = 0},
   {c1, c2, c3, c4, c5} = Re[leaverC[as, A]];
   Do[R = (k^2 + (c3 - 3) k + c5)/((-2 k^2 + (c2 + 2) k + c4) - (k^2 + (c1 + 1) k + c1) R), {k, nn, 1, -1}];
   c4/c1 - R];
angularCF[as_, A_, nn_] := Module[{w = \[Omega]Hof[as], q, k1 = m1/2, k2 = m1/2, R = 0, aa, bb, gg},
   q = -Sqrt[\[Mu]S^2 - w^2];
   aa[n_] := -2 (n + 1) (n + 2 k1 + 1);
   bb[n_] := n (n - 1) + 2 n (k1 + k2 + 1 - 2 as I q) - (2 as I q (2 k1 + 1) - (k1 + k2) (k1 + k2 + 1)) - (as^2 (I q)^2 + A);
   gg[n_] := 2 as I q (n + k1 + k2);
   Do[R = gg[k]/(bb[k] - aa[k] R), {k, nn, 1, -1}];
   bb[0]/aa[0] - R];
(* A(a, \[Mu]) cached per (a, \[Mu]) *)
Aof[as_?NumericQ] := Aof[as, \[Mu]S];
Aof[as_?NumericQ, mu_?NumericQ] := Aof[as, mu] = Block[{\[Mu]S = mu},
    Re[A0 /. Quiet[FindRoot[angularCF[as, A0, 400] == 0, {A0, l1 (l1 + 1)}, WorkingPrecision -> precL, AccuracyGoal -> precL - 30, PrecisionGoal -> precL - 30], {FindRoot::precw}]]];
Fr[as_?NumericQ, nn_] := radialCF[as, Aof[as], nn];
FrMu[mu_?NumericQ, nn_] := Block[{\[Mu]S = mu}, Fr[aa, nn]];
(* backward (Miller) recursion: a_n/a_(n-1) = -\[Gamma]_n/(\[Beta]_n + \[Alpha]_n a_(n+1)/a_n), started at depth nn (coefficients on the fly) *)
millerCoeffs[as_, nn_] := Module[{c1, c2, c3, c4, c5, rat = ConstantArray[0, nn], R = 0},
   {c1, c2, c3, c4, c5} = Re[leaverC[as, Aof[as]]];
   Do[R = -(k^2 + (c3 - 3) k + c5)/((-2 k^2 + (c2 + 2) k + c4) + (k^2 + (c1 + 1) k + c1) R); rat[[k]] = R, {k, nn, 1, -1}];
   FoldList[Times, 1, rat]];
millerMu[mu_?NumericQ, nn_] := Block[{\[Mu]S = mu}, millerCoeffs[aa, nn]];
\[Omega]0 = \[Omega]Hof[aa];
qStar = 470139437329/10^13;                         (* |q| of the reference cloud, \[Mu] = 0.3 (spin 0.8771530276) *)
qEst = N[\[Omega]0^2/(l1 + 1), 30];                    (* hydrogenic |q| ~ \[Mu]^2/n, n = l + 1 *)
nScan = Max[4000, Ceiling[4000 qStar/qEst]];          (* continued-fraction depth of the bracketing scan (4000 at the reference spin) *)
log["spin a = ", aa, " (given):  \[Omega] = m \[CapitalOmega]_H = ", N[\[Omega]0, 20], ",  hydrogenic |q| ~ ", N[qEst, 4], ",  scan depth ", nScan];
(* 1) bracket: scan F(\[Mu]) on \[Mu] = \[Mu]g (1 + \[Delta] \[Omega]^2), \[Delta] = -0.010, -0.009, .., 0.060 (only \[Mu] > \[Omega]); the sign change with the smallest |F| on both ends
      (a root, not a pole) *)
tm["mass: bracketing scan (71 points, one per job)",
  Module[{\[Mu]g = \[Omega]0 (1 + \[Omega]0^2/(2 (l1 + 1)^2)), grid, fv, cand, isRoot, roots},
   grid = Select[N[\[Mu]g (1 + (Range[-10, 60]/1000) \[Omega]0^2), precL], # > \[Omega]0 (1 + 10^-8) &];
   fv = pMap[FrMu[#, nScan] &, grid];
   cand = Select[Range[Length[grid] - 1], Sign[fv[[#]]] != Sign[fv[[# + 1]]] &];
   If[cand === {}, log["ERROR: no sign change of the eigencondition F(\[Mu]) near \[Mu] = ", N[\[Mu]g, 12]]; Exit[1]];
   log["   sign changes of F at \[Delta] = ", N[(grid[[cand]]/\[Mu]g - 1)/\[Omega]0^2, 4], " with |F| = ", sci[Abs[fv[[cand]]] + Abs[fv[[cand + 1]]], 2]];
   If[Length[cand] == 1, cand = First[cand],
    (* several sign changes: bisect each 10 times; at a root |F| at the bracket ends shrinks, at a pole of the continued fraction it grows *)
    isRoot[k_] := Module[{lo = grid[[k]], hi = grid[[k + 1]], flo = fv[[k]], fhi = fv[[k + 1]], md, fm},
      Do[md = (lo + hi)/2; fm = FrMu[md, nScan]; If[Sign[fm] == Sign[flo], lo = md; flo = fm, hi = md; fhi = fm], {10}];
      Max[Abs[flo], Abs[fhi]] < Max[Abs[fv[[k]]], Abs[fv[[k + 1]]]]];
    roots = Select[cand, isRoot];
    log["   roots (not poles) at \[Delta] = ", N[(grid[[roots]]/\[Mu]g - 1)/\[Omega]0^2, 4], ";  ground state = the root with the largest \[Mu]"];
    If[roots === {}, log["   no sign change classified as a root: smallest |F| taken"]; cand = First[SortBy[cand, Abs[fv[[#]]] + Abs[fv[[# + 1]]] &]], cand = Last[roots]]];
   \[Mu]Bracket = {grid[[cand]], grid[[cand + 1]]}]];
(* 2) root at the scan depth, 3) series length from Miller recursion (doubling the depth until |a_n| < tolA), 4) root again at twice that depth *)
tm["mass: Brent root (scan depth)", \[Mu]0 = mm /. Quiet[FindRoot[FrMu[mm, nScan] == 0, {mm, \[Mu]Bracket[[1]], \[Mu]Bracket[[2]]}, Method -> "Brent", WorkingPrecision -> precL,
      AccuracyGoal -> precL - 30, PrecisionGoal -> precL - 30], {FindRoot::precw}]];
(* start depth from the scan depth (the series length grows like |q|^-0.8, the scan depth like 1/|q|: the start is at most ~2x too deep) *)
nCF = 8000 2^Max[0, Ceiling[Log[2, N[nScan/4000]]] - 1];
millerOK[nn_] := Min[Abs[Take[millerMu[\[Mu]0, nn], -Ceiling[nn/10]]]] <= tolA;
tm["Leaver series: Miller recursion until |a_n| < 10^-(wp+10) (depths nCF x 2^k, k = 0..3, one per job, while nCF < 2e6; else serial doubling)",
  If[nCF < 2000000,
   Module[{deps = nCF 2^Range[0, 3], ok},
    ok = pMap[millerOK, deps];
    If[MemberQ[ok, True], nCF = deps[[First[FirstPosition[ok, True]]]],
     nCF = Last[deps]; While[! millerOK[nCF], nCF = 2 nCF; If[nCF > 128000000, log["ERROR: Leaver series not converged at depth 1.28e8"]; Exit[1]]]]],
   (* deep series (small spin): serial, one recursion in memory at a time *)
   While[! millerOK[nCF], nCF = 2 nCF; If[nCF > 128000000, log["ERROR: Leaver series not converged at depth 1.28e8"]; Exit[1]]]]];
nCF = 2 nCF;                                       (* continued-fraction depth: twice the depth at which |a_n| < tolA *)
tm["mass: secant root at depth " <> ToString[nCF] <> " (from the scan-depth root)",
  \[Mu]root = mm /. Quiet[FindRoot[FrMu[mm, nCF] == 0, {mm, \[Mu]0, \[Mu]0 (1 + 10^-30)}, Method -> "Secant", WorkingPrecision -> precL, AccuracyGoal -> precL - 30,
      PrecisionGoal -> precL - 30], {FindRoot::precw, FindRoot::lstol, FindRoot::cvmit}];
  If[! (NumericQ[\[Mu]root] && \[Mu]Bracket[[1]] <= \[Mu]root <= \[Mu]Bracket[[2]] && Abs[FrMu[\[Mu]root, nCF]] < 10^-(wp + 5) Abs[FrMu[\[Mu]Bracket[[1]], nCF]]),
   log["   secant step not accepted; Brent on the bracket"];
   \[Mu]root = mm /. Quiet[FindRoot[FrMu[mm, nCF] == 0, {mm, \[Mu]Bracket[[1]], \[Mu]Bracket[[2]]}, Method -> "Brent", WorkingPrecision -> precL,
       AccuracyGoal -> precL - 30, PrecisionGoal -> precL - 30], {FindRoot::precw}]]];
\[Mu]S = \[Mu]root;                                       (* from here on: the solved mass *)
If[useParallel, DistributeDefinitions[\[Mu]S]];
tm["Leaver series coefficients (Miller, depth " <> ToString[nCF] <> ")",
  Module[{an = millerCoeffs[aa, nCF], k}, k = LengthWhile[Abs[an], # >= tolA/10^5 &] + 1;
   If[k > nCF/2, log["WARNING: Leaver series truncated at ", k, " of depth ", nCF]];
   coeffLeaver = Take[an, Min[k, Length[an]]]]];
Alm = Aof[aa]; \[Omega] = \[Omega]Hof[aa];
rminus = 1 - Sqrt[1 - aa^2]; rplus = 1 + Sqrt[1 - aa^2]; \[Omega]Horizon = \[Omega];
log["spin a = ", aa, "  ->  scalar mass \[Mu] M = ", N[\[Mu]S, 40], "\n   \[Omega] = m \[CapitalOmega]_H = ", N[\[Omega], 30], ",  \[Omega]/\[Mu] = ", N[\[Omega]/\[Mu]S, 20],
  ",  A = ", N[Alm, 30], ",  series terms = ", Length[coeffLeaver], ",  continued-fraction depth = ", nCF, ",  |a_N|/|a_0| = ", sci[Abs[Last[coeffLeaver]], 3]];
check["D: threshold eigencondition at the root, continued fraction of depth 2 nCF (relative to \[Beta]0/\[Alpha]0)",
  Abs[Fr[aa, 2 nCF]]/Abs[Module[{c = Re[leaverC[aa, Alm]]}, c[[4]]/c[[1]]]], 10^-(wp + 5)];
check["D: Leaver series converged, |a_N|/|a_0|", Abs[Last[coeffLeaver]], 10^-(wp + 5)];
check["D: bound state, \[Mu] > \[Omega] (error = \[Omega]/\[Mu] - 1 + 1/2; must be < 1/2)", N[\[Omega]/\[Mu]S - 1, 20] + 1/2, 1/2];

(* ==================================================================================================== *)
stage["3. Compact T_ab, Teukolsky operator O4 and source S4T"];
\[CapitalDelta]K = r^2 - 2 M r + a^2;
\[CapitalSigma]K = r^2 + a^2 \[Chi]^2;
KK = \[Omega]c (r^2 + a^2) - a mc;                          (* K = \[Omega] (r^2 + a^2) - a m *)
VV = mc/Sqrt[1 - \[Chi]^2] - a \[Omega]c Sqrt[1 - \[Chi]^2];          (* mc csc\[Theta] - a \[Omega]c sin\[Theta] *)
thS[Sf_] := -Sqrt[1 - \[Chi]^2] D[Sf, \[Chi]];                 (* \[PartialD]_\[Theta] S, with \[Chi] = cos\[Theta] *)
(* G = 1: the Einstein (and Teukolsky) source is kapE T_ab, kapE = 8 Pi. TnnC, TnmbC, TmbmbC below are the SOURCE components kapE T_nn, kapE T_nmbar, kapE T_mbarmbar *)
kapE = 8 Pi;
If[useParallel, DistributeDefinitions[kapE]];
TnnC[ff_, Sf_] := kapE 2 (D[ff, r]^2 + (KK/\[CapitalDelta]K)^2 ff^2) Sf^2;
TnmbC[ff_, Sf_] := -kapE Sqrt[2] Sf (ff D[ff, r] thS[Sf] - I (KK/\[CapitalDelta]K) ff^2 VV Sf)/(r - I a \[Chi]);
TmbmbC[ff_, Sf_] := kapE ff^2 (thS[Sf]^2 - VV^2 Sf^2)/(r - I a \[Chi])^2;
O4[\[Psi]_] := \[Thorn]pExt[-3, 1, -4, -1][\[Thorn]Ext[-4, 0, -1, 0][\[Psi]]] - \[Eth]pExt[-3, -1, -4, -1][\[Eth]Ext[-4, 0, -1, 0][\[Psi]]] - 3 \[CapitalPsi]2 \[Psi];
S4op[Tnn_, Tnmb_, Tmbmb_] := 1/2 \[Eth]pExt[-3, -1, -4, -1][\[Thorn]pExt[-2, 0, 0, -2][Tnmb] - \[Eth]pExt[-2, -2, 0, -1][Tnn]] + 1/2 \[Thorn]pExt[-3, 1, -4, -1][\[Eth]pExt[-2, 0, 0, -2][Tnmb] - \[Thorn]pExt[-2, 2, 0, -1][Tmbmb]];
W4 = Simplify[\[Rho]\[Rho]p^2/\[Rho]\[Rho]cp^2/\[CapitalDelta]K^2];      (* (r + i a \[Chi])^2/((r - i a \[Chi])^2 \[CapitalDelta]^2) *)
Y2[l_, c_] := SpinWeightedSphericalHarmonicY[-2, l, 0, ArcCos[c], 0];
Y2N[l_, c_] := Y2N[l, c] = N[Y2[l, c], wp];
\[Lambda][l_] := (l - 1) (l + 2);
(* S4T = 1/2 \[Eth]p'[\[Thorn]p'[Tnmb] - \[Eth]p'[Tnn]] + 1/2 \[Thorn]p'[\[Eth]p'[Tnmb] - \[Thorn]p'[Tmbmb]] (S4op): its two halves (same symbolic form as S4op) and the unseparated
   O4 on one product term (used by the end-to-end check G3) are three independent symbolic jobs *)
s4piece[{1, tn_, tnm_, tmm_}] := \[Eth]pExt[-3, -1, -4, -1][\[Thorn]pExt[-2, 0, 0, -2][tnm] - \[Eth]pExt[-2, -2, 0, -1][tn]];
s4piece[{2, tn_, tnm_, tmm_}] := \[Thorn]pExt[-3, 1, -4, -1][\[Eth]pExt[-2, 0, 0, -2][tnm] - \[Thorn]pExt[-2, 2, 0, -1][tmm]];
s4piece[{3, __}] := O4[W4 Rt[r] St[\[Chi]]];
tm["S4T (the two halves of S4op) and the unseparated O4 (symbolic, one per job)",
  Module[{pcs = pMap[s4piece, Table[{k, TnnC[fs[r], Ss[\[Chi]]], TnmbC[fs[r], Ss[\[Chi]]], TmbmbC[fs[r], Ss[\[Chi]]]}, {k, 3}]]},
   src4 = 1/2 pcs[[1]] + 1/2 pcs[[2]]; O4gen = pcs[[3]]]];
calT = -2 \[CapitalSigma]K src4/W4;

(* ==================================================================================================== *)
stage["4. Numerical parameters, Chebyshev utilities, radial and angular functions of the cloud"];
aN = N[aa, wp]; \[Mu]N = N[\[Mu]S, wp];
bN = Sqrt[1 - aN^2]; rpN = 1 + bN; rmN = 1 - bN;
\[Omega]H = N[\[Omega]Hof[aa], wp];                  (* m \[CapitalOmega]_H with m = 1, M = 1 (from the exact spin) *)
(* q, \[Alpha], \[Gamma] from the solved mass at wp + 10 digits and the exact spin: \[Mu]^2 - \[Omega]^2 cancels ~log10(\[Mu]^2/q^2) digits (3 at a = 0.25, 4.4 at a = 0.05),
   which at wp digits left q (and through the length scale factor the panel boundaries) below wp digits *)
Module[{\[Mu]X = SetPrecision[\[Mu]S, Max[wp + 10, Min[Precision[\[Mu]S], precL]]], wX = N[\[Omega]Hof[aa], wp + 10], aX = N[aa, wp + 10]},
  qN = N[-Sqrt[\[Mu]X^2 - wX^2], wp]; \[Alpha]N = N[(\[Mu]X^2 - 2 wX^2)/(-Sqrt[\[Mu]X^2 - wX^2]), wp]; \[Gamma]N = N[aX Sqrt[wX^2 - \[Mu]X^2], wp]];
If[! (Min[Precision /@ {qN, \[Alpha]N, Im[\[Gamma]N]}] >= wp - 1), log["ERROR: q, \[Alpha], \[Gamma] have precision ", Precision /@ {qN, \[Alpha]N, \[Gamma]N}, " < wp = ", wp]; Exit[1]];
cL = N[coeffLeaver, wp + 10];            (* Leaver coefficients a_0 .. a_N (real at threshold) *)
\[CapitalDelta]N[rr_] := rr^2 - 2 rr + aN^2;
numPar = {M -> 1, a -> aN, \[Omega]c -> \[Omega]H, mc -> m1};
log["a = ", N[aN, 12], ",  \[Mu] = ", N[\[Mu]N, 12], ",  \[Omega]c = m\[CapitalOmega]_H = ", N[\[Omega]H, 15], ",  q = ", N[qN, 12], ",  \[Alpha] = ", N[\[Alpha]N, 12], ",  \[Gamma] = ", N[\[Gamma]N, 12], ",  #a_n = ", Length[cL]];
\[Kappa]N = bN;
chebNodes[nn_] := N[Table[Cos[Pi (j + 1/2)/nn], {j, 0, nn - 1}], wp];
chebMat[nn_] := chebMat[nn] = N[Table[(2/nn) If[k == 0, 1/2, 1] Cos[k Pi (j + 1/2)/nn], {k, 0, nn - 1}, {j, 0, nn - 1}], wp];
chebCoef[vals_List] := chebMat[Length[vals]] . vals;                     (* values at chebNodes -> coefficients c_k, f = \[CapitalSigma] c_k T_k *)
chebEval[c_List, z_] := c . ChebyshevT[Range[0, Length[c] - 1], z];
chebDer[c_List] := Module[{nn = Length[c] - 1, dd},                     (* coefficients of df/dz *)
   dd = ConstantArray[0, nn + 2];
   Do[dd[[k]] = dd[[k + 2]] + 2 k c[[k + 1]], {k, nn, 1, -1}];
   dd[[1]] = dd[[1]]/2; Take[dd, nn + 1]];
chebInt[c_List] := Module[{nn = Length[c] - 1, cc, ci},                 (* coefficients of \[Integral]_{-1}^{z} f *)
   cc = Join[c, {0, 0}]; ci = ConstantArray[0, nn + 2];
   ci[[2]] = cc[[1]] - cc[[3]]/2;
   Do[ci[[k + 1]] = (cc[[k]] - cc[[k + 2]])/(2 k), {k, 2, nn + 1}];
   ci[[1]] = -Sum[ci[[k + 1]] (-1)^k, {k, 1, nn + 1}]; ci];
chebValMat[nn_] := chebValMat[nn] = N[Table[Cos[k Pi (j + 1/2)/nn], {j, 0, nn - 1}, {k, 0, nn - 1}], wp];   (* coefficients -> values at chebNodes *)
TmatAt[nn_] := TmatAt[nn] = N[Table[ChebyshevT[k, t1], {t1, tP}, {k, 0, nn - 1}], wp];   (* coefficients (nn of them) -> values at the radial panel nodes tP *)
(* ---------- radial function of the cloud: f = e^{q r} (r - r-)^{\[Alpha]-1} R(u), R = \[CapitalSigma] a_n u^n, u = (r - r+)/(r - r-) ----------
   fLeaver: exact jets {f, df, d2f, d3f} from the series, truncated adaptively where |a_n| u^n < 10^-(wp+10) (few terms near H+, ~10^4 at r ~ 2000).
   fEx: the same jets from a Chebyshev interpolant on the radial panels (fast; used everywhere off the nodes); fLeaver beyond the panels. *)
logA = N[Log[Abs[cL] + 10^-(3 wp)]];          (* machine precision: only used to decide the truncation (memory: the series can have 8e6 terms) *)
tailMaxLog = Reverse[FoldList[Max, Reverse[logA]]];            (* max_{k >= n} log|a_k| *)
nOfu[u_] := Module[{lu = Log[Max[u, 10^-300]], target = -(wp + 10) Log[10], lo = 1, hi = Length[cL], mid},
   If[tailMaxLog[[hi]] + (hi - 1) lu >= target, hi,
    While[hi - lo > 1, mid = Quotient[lo + hi, 2]; If[tailMaxLog[[mid]] + (mid - 1) lu < target, hi = mid, lo = mid]]; hi]];
Rjet[u_] := Module[{n = nOfu[u], d0 = 0, d1 = 0, d2 = 0, d3 = 0},           (* Horner for R and its first three u-derivatives *)
   Do[d3 = d3 u + d2; d2 = d2 u + d1; d1 = d1 u + d0; d0 = d0 u + cL[[k]], {k, n, 1, -1}];
   {d0, d1, 2 d2, 6 d3}];
fJetSym = Table[D[Exp[qN x0] (x0 - rmN)^(\[Alpha]N - 1) Rf[(x0 - rpN)/(x0 - rmN)], {x0, k}], {k, 0, 3}];
fJetFun = Function[Evaluate[{x0, R0, R1, R2, R3}], Evaluate[fJetSym /. {Derivative[k_][Rf][_] :> {R1, R2, R3}[[k]], Rf[_] :> R0}]];
fLeaver[r0_] := fJetFun[r0, Sequence @@ Rjet[(r0 - rpN)/(r0 - rmN)]];
Rser[rr_] := First[Rjet[(rr - rpN)/(rr - rmN)]];
(* radial panels in x = r - r+ (geometric near H+, width 15 up to xMax, where e^{2 q xMax} < 10^-(3/2 (wp+5))) *)
xMax = N[Ceiling[3/2 (wp + 5) Log[10]/(2 Abs[qN])], wp];
(* Chebyshev interpolation on a panel converges like \[Rho]^-nPn, \[Rho] \[TildeTilde] 4 d/w (d: distance from the panel to the nearest singularity of the solution, the
   branch point r = r- (x = -(r+ - r-)); w: panel width). Panels of width w(x) = min((gPan - 1) x, 4 (x + r+ - r-)/\[Rho]Pan, wPan), starting at x = 10^-6:
   geometric (ratio gPan) near H+, then \[Rho] = \[Rho]Pan, then width wPan. \[Rho]Pan = 10^((wp - 10)/nPn) gives ~10^-(wp-10) on every panel. (The previous rule, ratio 1.3
   up to width 15, has \[Rho] -> 4/0.3 \[TildeTilde] 13 for 1 \:2272 x \:2272 50, i.e. ~10^-36 there against ~10^-50 elsewhere: the dip in accuracy around r - r+ ~ 1-100.) *)
(* everything at wp digits: a machine-precision \[Rho]Pan made every panel boundary beyond x ~ 0.5 (and so every node there) a machine number *)
\[Rho]Pan = With[{v = Environment["BOSON_PANRHO"]}, If[StringQ[v] && StringMatchQ[v, NumberString], SetPrecision[ToExpression[v], wp], N[10^((wp - 10)/nPn), wp]]];
(* spin scan: the width cap 15 was tuned for |q*| = 0.047 (\[Mu] = 0.3); scaled by sc = |q*|/|q| so that the panels resolve e^{2 q r} equally well at every spin
   (and their number stays ~300 at small spin, where xMax ~ 1/|q| reaches 1.4e6) *)
scN = Rationalize[N[qStar/Abs[qN], 30], 10^-25]; wPan = 15 scN;          (* exact rational: a grid parameter, not physics *)
log["length scale factor sc = |q*|/|q| = ", N[scN, 6], ":  panel width cap ", N[wPan, 6]];
xB = Module[{xs = {0, 10^-6}, x = N[10^-6, wp]},
   While[x < xMax, x = x + Min[(gPan - 1) x, 4 (x + 2 bN)/\[Rho]Pan, wPan]; AppendTo[xs, x]];
   xs = Most[xs]; If[xMax - Last[xs] < wPan/3, xs = Most[xs]];          (* the last panel ends at xMax (at most 4/3 wPan wide) *)
   N[Append[xs, xMax], wp]];
If[! (Precision[xB] >= wp - 3), log["ERROR: radial panel boundaries have precision ", Precision[xB], " < wp = ", wp]; Exit[1]];
log["radial panels: \[Rho] target ", N[\[Rho]Pan, 4], " (interpolation error ~ \[Rho]^-nPn = ", sci[N[\[Rho]Pan]^-nPn, 2], ")"];
nPan = Length[xB] - 1; tP = chebNodes[nPn];
panMid[p_] := (xB[[p]] + xB[[p + 1]])/2; panH[p_] := (xB[[p + 1]] - xB[[p]])/2;
rPan = Table[rpN + panMid[p] + panH[p] tP, {p, nPan}];
panelIndex[x_] := Min[nPan, Max[1, LengthWhile[xB, # <= x &]]];
log["xMax = ", N[xMax, 6], ",  panels = ", nPan, ",  radial points = ", nPan nPn];
tm["f-jets from the Leaver series at the panel nodes (one panel per job)", fP = pMap[Function[p, fLeaver /@ rPan[[p]]], Range[nPan]]];
cfP = Table[chebCoef /@ Transpose[fP[[p]]], {p, nPan}];       (* per panel: Chebyshev coefficients of f and its first three r-derivatives *)
fPanel[r0_] := Module[{x = r0 - rpN, p, t}, p = panelIndex[x]; t = (x - panMid[p])/panH[p]; chebEval[#, t] & /@ cfP[[p]]];
fEx[r0_] := If[0 <= r0 - rpN < xMax, fPanel[r0], fLeaver[r0]];
fSpec[r0_] := fEx[r0];
Module[{pts = Join[rpN + {10^-7, 10^-4, 1/10}, {2, 7, 31/3, 55, 222, 777, N[rpN + xMax - 7, wp]}], err},
  err = pMap[Function[r0, Module[{a1 = fPanel[r0], b1 = fLeaver[r0]}, Max[Abs[a1 - b1]/Abs[b1]]]], pts];
  log["f: panel interpolation vs Leaver series at r = ", N[pts, 5], ": ", sci[err, 2]];
  diag["fInterp"] = <|"r" -> pts, "relErr" -> Map[bndS, err]|>;
  check["f: Chebyshev panel interpolation of f and its first three r-derivatives vs the Leaver series (10 off-node points)", maxB[err], 10^-25]];
(* ground state: f has no radial node between r+ and r+ + xMax (an overtone n has n nodes) *)
Module[{fv = Flatten[fP[[All, All, 1]]], nn},
  nn = Count[Partition[Sign[fv], 2, 1], {s1_, s2_} /; s1 != s2];
  log["radial nodes of f on the panel nodes: ", nn];
  check["D: ground state (number of radial nodes of f on [r+, r+ + xMax])", nn, 1/2]];
s0SlmFunc = SpinWeightedSpheroidalHarmonicS[0, l1, m1, \[Gamma]N, Method -> {"SphericalExpansion", "NumTerms" -> Max[20, Ceiling[wp/2]]}];
bBHPT = Re /@ s0SlmFunc["ExpansionCoefficients"];        (* <|j -> b_j|>, spheroidal-spherical mixing coefficients *)
SEx[c_] := Re[s0SlmFunc[ArcCos[c], 0]];
SExSym = Sum[bBHPT[j] SpinWeightedSphericalHarmonicY[0, j, m1, ArcCos[y0], 0], {j, Keys[bBHPT]}];
(* S(\[Chi]) = sin^m\[Theta] P(\[Chi]) with P a polynomial: _0Y_{jm} = (-1)^m Sqrt[(2j+1)(j-m)!/(4\[Pi](j+m)!)] sin^m\[Theta] P_j^{(m)}(\[Chi])
   (m = 1: -Sqrt[(2j+1)/(4\[Pi] j(j+1))] sin\[Theta] P_j'); rational coefficients (10^-(wp+5)) *)
ratz = Rationalize[#, 10^-(wp + 5)] &;
pS = CoefficientList[N[(-1)^m1 Sum[bBHPT[j] Sqrt[(2 j + 1) (j - m1)!/(4 Pi (j + m1)!)] D[LegendreP[j, \[Chi]], {\[Chi], m1}], {j, Keys[bBHPT]}], wp], \[Chi]];
PpolyR = (ratz /@ pS) . \[Chi]^Range[0, Length[pS] - 1];
SExD = Table[D[(1 - y0^2)^(m1/2) (PpolyR /. \[Chi] -> y0), {y0, k}], {k, 0, 3}];
SExAt[c0_] := N[SExD /. y0 -> c0, wp];                  (* {S, dS, d2S, d3S} (exact polynomial form) *)
cN = chebNodes[nP];
cP = chebCoef[(PpolyR /. \[Chi] -> #) & /@ cN];              (* P is a polynomial of degree < nP: its Chebyshev series is exact *)
cPd = NestList[chebDer, cP, 3];
ClearAll[PC];
PC[c_?NumericQ] := chebEval[cPd[[1]], c];
Derivative[k_Integer][PC][c_?NumericQ] := chebEval[cPd[[k + 1]], c];
SSpecD = Table[D[(1 - y0^2)^(m1/2) PC[y0], {y0, k}], {k, 0, 3}];
SSpec[c0_] := SSpecD /. y0 -> c0;
log["mixing coefficients b_j (j = ", m1, "..", m1 + 6, "): ", N[Take[Values[bBHPT], 7], 6], ";  deg P = ", Exponent[PpolyR, \[Chi]]];
(* general (l, m): the polynomial form sin^m P against the BHPToolkit spheroidal harmonic at 7 points *)
Module[{cs = {-99/100, -7/10, -3/10, 1/10, 37/100, 4/5, 97/100}, sv},
  sv = Table[SEx[N[c, wp]], {c, cs}];
  check["S: sin^m P(\[Chi]) (polynomial) vs SpinWeightedSpheroidalHarmonicS (7 points, relative to max|S|; overall sign free)",
   Min[Max[Abs[Table[SExAt[c][[1]], {c, cs}] - sv]], Max[Abs[Table[SExAt[c][[1]], {c, cs}] + sv]]]/Max[Abs[sv]], 10^-15]];

(* ==================================================================================================== *)
stage["5. Source on the \[Chi] grid and projection onto _{-2}Y_{\[ScriptL]0} (approach 1)"];
fRules = {Derivative[3][fs][r] -> fq3, Derivative[2][fs][r] -> fq2, Derivative[1][fs][r] -> fq1, fs[r] -> fq0};
sRules = {Derivative[3][Ss][\[Chi]] -> sq3, Derivative[2][Ss][\[Chi]] -> sq2, Derivative[1][Ss][\[Chi]] -> sq1, Ss[\[Chi]] -> sq0};
tm["CSE-optimized numeric calT and S4T (one per job)",
  {calTfun, src4fun} = pMap[optFun[{r, \[Chi], fq0, fq1, fq2, fq3, sq0, sq1, sq2, sq3}, #, N[{37/10, 3/10, 1/3, 1/5, 1/7, 1/11, 2/3, 1/4, 1/6, 1/8}, wp]] &,
    {(calT /. numPar) /. fRules /. sRules, (src4 /. numPar) /. fRules /. sRules}]];
gl = GaussianQuadratureWeights[nChi, -1, 1, wp]; \[Chi]G = gl[[All, 1]]; wG = gl[[All, 2]];
lList = Range[2, lmax];
Y2G = pMap[Function[l, Table[N[Y2[l, c], wp], {c, \[Chi]G}]], lList];
SGrid = SSpec /@ \[Chi]G;
SGridT = Transpose[SGrid];
YW = 2 Pi (wG Transpose[Y2G]);
(* T_\[ScriptL] at one radius for all \[ScriptL], from the jets fv of f: calTfun is evaluated on the whole \[Chi]-vector at once (listable arithmetic) *)
TlAtF[r0_, fv_] := Module[{v},
   v = calTfun[r0, \[Chi]G, Sequence @@ fv, Sequence @@ SGridT];
   If[! (VectorQ[v] && Length[v] == nChi), v = Table[calTfun[r0, \[Chi]G[[k]], Sequence @@ fv, Sequence @@ SGrid[[k]]], {k, nChi}]];   (* fallback if not listable *)
   v . YW];
TlAtS[r0_] := TlAtF[r0, fSpec[r0]];       (* f from the spectral R: same route as the source table TlP (serial use only) *)
TlAt[r0_] := TlAtF[r0, fEx[r0]];         (* f from the Leaver sum: used off the nodes (also on subkernels; avoids distributing the Derivative rules of RC) *)
(* convergence of the angular quadrature: nChi + 16 nodes *)
TlQuad[r0_, nq_] := Module[{g = GaussianQuadratureWeights[nq, -1, 1, wp], fv = fSpec[r0]},
   2 Pi Table[Sum[g[[k, 2]] calTfun[r0, g[[k, 1]], Sequence @@ fv, Sequence @@ SSpec[g[[k, 1]]]] N[Y2[l, g[[k, 1]]], wp], {k, nq}], {l, lList}]];
Module[{rs = {3, 12, 45}, res},
  res = pMap[Function[r0, Max[Abs[TlQuad[r0, nChi + 16] - TlAtS[r0]]]/Max[Abs[TlAtS[r0]]]], rs];          (* one radius per job *)
  Do[check["E4: angular quadrature converged (nChi vs nChi + 16) at r = " <> ToString[rs[[k]]], res[[k]], 10^-12], {k, Length[rs]}]];
(* truncation remainder: the part of calT carried by \[ScriptL] = lmax+1 .. lmax+20, projected with nTail-point Gauss-Legendre *)
gl64 = GaussianQuadratureWeights[nTail, -1, 1, wp]; \[Chi]64 = gl64[[All, 1]]; w64 = gl64[[All, 2]];
lTail = Range[lmax + 1, lmax + 20];
Y64tail = pMap[Function[l, Table[N[Y2[l, c], wp], {c, \[Chi]64}]], lTail];
tailT[r0_, c0_] := tailT[r0, c0] = Module[{fv = fEx[r0], v},
   v = Table[calTfun[r0, \[Chi]64[[k]], Sequence @@ fv, Sequence @@ SExAt[\[Chi]64[[k]]]], {k, nTail}];
   (2 Pi Y64tail . (w64 v)) . Table[N[Y2[l, c0], wp], {l, lTail}]];
(* completeness in \[ScriptL]: \[CapitalSigma]_{\[ScriptL]\[LessEqual]lmax} T_\[ScriptL] Y_\[ScriptL] + remainder = calT off the \[Chi] grid *)
Module[{pts = Tuples[{{3, 12, 45}, {37/100, -71/100}}], res},
  res = pMap[Function[pt, Module[{lhs = TlAt[pt[[1]]] . Table[N[Y2[l, pt[[2]]], wp], {l, lList}], rhs = calTfun[pt[[1]], pt[[2]], Sequence @@ fEx[pt[[1]]], Sequence @@ SExAt[pt[[2]]]]},
       {relErr[lhs, rhs], relErr[lhs + tailT[pt[[1]], pt[[2]]], rhs]}]], pts];
  Do[log["   \[ScriptL]-truncation error of \[CapitalSigma]_{\[ScriptL]\[LessEqual]", lmax, "} T_\[ScriptL] Y_\[ScriptL] at (r, \[Chi]) = ", pts[[i]], ": ", sci[res[[i, 1]]]], {i, Length[pts]}];
  check["E4: \[CapitalSigma]_{\[ScriptL]\[LessEqual]lmax} T_\[ScriptL] Y_\[ScriptL] + (\[ScriptL] > lmax remainder) = calT at 6 off-grid points", Max[res[[All, 2]]], 10^-9]];

(* ==================================================================================================== *)
stage["6. Homogeneous solutions, radial panels, Green-function solution"];
Rhom[l_] := Rhom[l] = TeukolskyRadial[-2, l, 0, aN, 0];
TlPanel[p_] := Table[TlAtF[rPan[[p, j]], fP[[p, j]]], {j, nPn}];
If[useParallel, DistributeDefinitions[TlPanel]];
tm["source table TlP (one panel per job)", TlP = pMap[TlPanel, Range[nPan]]];       (* TlP[[p, j, l-1]] = T_\[ScriptL](r_{p,j}) *)
pChk = {1, Quotient[nPan, 2]};       (* panels recomputed serially *)
(* generic Green-function solver: the source table (layout TlP[[p, node, \[ScriptL]-1]]) is an argument, so the same code serves approach 1 and approach 2 *)
vopGen[l_, Ttab_] := Module[{j = l - 1, Rin = Rhom[l]["In"], Rup = Rhom[l]["Up"], Cw, pan, cin, cup, RpPan},
   Cw = (Rin[5] Rup'[5] - Rup[5] Rin'[5])/\[CapitalDelta]N[5];
   pan = Table[Module[{rs = rPan[[p]], h = panH[p], ri, ru, F, Pin, Pup},
       ri = Rin[rs]; ru = Rup[rs]; F = Ttab[[p, All, j]]/\[CapitalDelta]N[rs]^2;
       Pin = h chebInt[chebCoef[ri F]]; Pup = h chebInt[chebCoef[ru F]];
       <|"ri" -> ri, "ru" -> ru, "Pin" -> Pin, "Pup" -> Pup, "totIn" -> chebEval[Pin, 1], "totUp" -> chebEval[Pup, 1]|>], {p, nPan}];
   cin = Most[FoldList[Plus, 0, pan[[All, "totIn"]]]];
   cup = Reverse[Most[FoldList[Plus, 0, Reverse[pan[[All, "totUp"]]]]]];
   RpPan = Table[Module[{d = pan[[p]], IinV, IupV},
       IinV = cin[[p]] + (chebEval[d["Pin"], #] & /@ tP);
       IupV = cup[[p]] + d["totUp"] - (chebEval[d["Pup"], #] & /@ tP);
       (d["ru"] IinV + d["ri"] IupV)/Cw], {p, nPan}];
   <|"cRp" -> (chebCoef /@ RpPan), "Cin" -> Total[pan[[All, "totUp"]]]/Cw, "Cup" -> Total[pan[[All, "totIn"]]]/Cw, "Wronskian" -> Cw,
     "Pin" -> pan[[All, "Pin"]], "Pup" -> pan[[All, "Pup"]], "totUp" -> pan[[All, "totUp"]], "cin" -> cin, "cup" -> cup, "Iinf" -> Total[pan[[All, "totIn"]]]|>];
vop[l_] := vopGen[l, TlP];
(* one \[ScriptL] per subkernel; if a subkernel fails (e.g. BHPToolkit objects not transferable) fall back to the serial loop *)
(* the expensive part, R_in and R_up on all panel nodes (static BHPToolkit solutions at wp digits), runs as jobs (\[ScriptL], panel set): ~4 jobs per subkernel instead
   of one \[ScriptL] per job (35 jobs on 31 subkernels took two rounds); the per-\[ScriptL] assembly (cumulative sums, node values) is one job per \[ScriptL] *)
greenPiece[l_, ps_List, Tsl_] := Module[{Rin = Rhom[l]["In"], Rup = Rhom[l]["Up"]},
   Table[Module[{p = ps[[i]], rs, h, ri, ru, F, Pin, Pup},
     rs = rPan[[p]]; h = panH[p]; ri = Rin[rs]; ru = Rup[rs]; F = Tsl[[i]]/\[CapitalDelta]N[rs]^2;
     Pin = h chebInt[chebCoef[ri F]]; Pup = h chebInt[chebCoef[ru F]];
     {p, <|"ri" -> ri, "ru" -> ru, "Pin" -> Pin, "Pup" -> Pup, "totIn" -> chebEval[Pin, 1], "totUp" -> chebEval[Pup, 1]|>}], {i, Length[ps]}]];
greenTask[{l_, ps_, ts_}] := {l, greenPiece[l, ps, ts]};
greenAssemble[{l_, pan0_}] /; Sort[pan0[[All, 1]]] =!= Range[nPan] := $Failed;          (* a failed (\[ScriptL], panel set) job: the serial fallback below takes over *)
greenAssemble[{l_, pan0_}] := Module[{Rin = Rhom[l]["In"], Rup = Rhom[l]["Up"], pan = SortBy[pan0, First][[All, 2]], Cw, cin, cup, RpPan},
   Cw = (Rin[5] Rup'[5] - Rup[5] Rin'[5])/\[CapitalDelta]N[5];
   cin = Most[FoldList[Plus, 0, pan[[All, "totIn"]]]];
   cup = Reverse[Most[FoldList[Plus, 0, Reverse[pan[[All, "totUp"]]]]]];
   RpPan = Table[Module[{d = pan[[p]], IinV, IupV},
       IinV = cin[[p]] + TmatAt[Length[d["Pin"]]] . d["Pin"];
       IupV = cup[[p]] + d["totUp"] - TmatAt[Length[d["Pup"]]] . d["Pup"];
       (d["ru"] IinV + d["ri"] IupV)/Cw], {p, nPan}];
   <|"cRp" -> (chebCoef /@ RpPan), "Cin" -> Total[pan[[All, "totUp"]]]/Cw, "Cup" -> Total[pan[[All, "totIn"]]]/Cw, "Wronskian" -> Cw,
     "Pin" -> pan[[All, "Pin"]], "Pup" -> pan[[All, "Pup"]], "totUp" -> pan[[All, "totUp"]], "cin" -> cin, "cup" -> cup, "Iinf" -> Total[pan[[All, "totIn"]]]|>];
If[useParallel, DistributeDefinitions[greenTask, greenAssemble]];
tm["Green-function solves: R_in, R_up on the panel nodes (jobs \[ScriptL] x panel set) and the assembly (one \[ScriptL] per job)",
  Module[{nC = Min[nPan, Max[1, Ceiling[4 Max[1, If[useParallel, Length[Kernels[]], 1]]/Length[lList]]]], jobs, res},
   jobs = Flatten[Table[With[{ps = Range[c, nPan, nC]}, {l, ps, TlP[[ps, All, l - 1]]}], {l, lList}, {c, nC}], 1];
   res = Quiet[pMap[greenTask, jobs]];
   sol = Quiet[AssociationThread[lList, pMap[greenAssemble, Table[{l, Join @@ Cases[res, {l, x_List} :> x]}, {l, lList}]]]]]];
If[! AllTrue[Values[sol], AssociationQ[#] && NumericQ[#["Cup"]] &], log["WARNING: parallel \[ScriptL]-solve failed, recomputing serially"]; sol = AssociationMap[vop, lList]];
(* R_\[ScriptL] and its r-derivatives anywhere, directly from the Green-function representation (no numerical differentiation):
     R   = (R_up I_in + R_in I_up)/C
     R'  = (R_up' I_in + R_in' I_up)/C                    (the boundary terms cancel)
     R'' = (R_up'' I_in + R_in'' I_up)/C + T_\[ScriptL]/\[CapitalDelta]          (using C \[CapitalDelta] = R_in R_up' - R_up R_in')
   I_in, I_up at any r come from the stored panel integrals; beyond r+ + xMax, I_in = I_in(\[Infinity]) and I_up = 0. *)
IinUpGen[s_, l_, r0_] := Module[{x = r0 - rpN, p, t},
   If[x >= xMax, {s[l]["Iinf"], 0},
    p = panelIndex[x]; t = (x - panMid[p])/panH[p];
    {s[l]["cin"][[p]] + chebEval[s[l]["Pin"][[p]], t], s[l]["cup"][[p]] + s[l]["totUp"][[p]] - chebEval[s[l]["Pup"][[p]], t]}]];
(* R, R', R'' from the Green-function representation; Tat[r0] returns the vector {T_2, ..., T_lmax} at r0 *)
RpEvalGen[s_, Tat_, l_, r0_, k_ : 0] := Module[{Rin = Rhom[l]["In"], Rup = Rhom[l]["Up"], i2 = IinUpGen[s, l, r0], hom},
   hom = If[k == 0, Rup[r0] i2[[1]] + Rin[r0] i2[[2]], Derivative[k][Rup][r0] i2[[1]] + Derivative[k][Rin][r0] i2[[2]]]/s[l]["Wronskian"];
   If[k == 2, hom + If[r0 - rpN >= xMax, 0, Tat[r0][[l - 1]]]/\[CapitalDelta]N[r0], hom]];
TlAtMemo[r0_] := TlAtMemo[r0] = If[r0 - rpN >= xMax, ConstantArray[0, Length[lList]], TlAt[r0]];
RpEval[l_, r0_, k_ : 0] := RpEvalGen[sol, TlAtMemo, l, r0, k];
RpDer[l_, r0_] := Table[RpEval[l, r0, k], {k, 0, 2}];
Rval[l_, r0_, k_ : 0] := RpEval[l, r0, k];        (* name used by the reconstruction *)

(* ==================================================================================================== *)
stage["7. Checks of the particular solution \[CapitalPsi]4"];
(* G1: residual of the radial Teukolsky equation at every panel node, from Chebyshev derivatives of the stored R_\[ScriptL] (independent of the Green-function formula).
   The residual of mode \[ScriptL] is divided by the largest \[CapitalSigma]|terms| over all modes at the same node: for large \[ScriptL] and r, T_\[ScriptL] ~ (a/r)^(\[ScriptL]-2) T_2 lies below the
   round-off of the angular projection (~10^-wp |calT|), so a per-mode relative residual would measure round-off, not an error of the solution. *)
radialResidualTerms[l_, cR_, Tl_] := Flatten[Table[Module[{c = cR[[p]], h = panH[p], rs = rPan[[p]], c1, c2, R0, R1, R2, terms},
     c1 = chebDer[c]; c2 = chebDer[c1];
     R0 = chebValMat[nPn] . c; R1 = (chebValMat[nPn] . c1)/h; R2 = (chebValMat[nPn] . c2)/h^2;          (* node values: one matrix product each *)
     terms = {\[CapitalDelta]N[rs] R2, -2 (rs - 1) R1, -\[Lambda][l] R0, -Tl[[p]]};      (* \[CapitalDelta]^2 (R'/\[CapitalDelta])' = \[CapitalDelta] R'' - \[CapitalDelta]' R' *)
     Transpose[{Abs[Total[terms]], Total[Abs[terms]]}]], {p, nPan}], 1];
Module[{rt = pMap[radialResidualTerms @@ # &, Table[{l, sol[l]["cRp"], TlP[[All, All, l - 1]]}, {l, lList}]], scale, res},      (* one \[ScriptL] per job; only that \[ScriptL]'s data is sent *)
  scale = Max /@ Transpose[rt[[All, All, 2]]];
  res = Table[maxB[rt[[i, All, 1]]/scale], {i, Length[lList]}];
  log["G1: residual per mode (\[ScriptL] = 2..lmax): ", sci[res, 2]];
  diag["G1"] = <|"l" -> lList, "rPanelMid" -> Table[rpN + panMid[p], {p, nPan}], "residualPerPanel" -> Table[Max /@ Partition[Map[bndS, rt[[i, All, 1]]/scale], nPn], {i, Length[lList]}]|>;
  check["G1: radial Teukolsky equation at all panel nodes, all modes (|residual_\[ScriptL]| / max_\[ScriptL] \[CapitalSigma]|terms| per node)", Max[res], 10^-6]];
(* R: radial resolution of the panel series: last Chebyshev coefficient of every mode, relative to the largest coefficient of all modes on that panel *)
Module[{res = Table[Max[Table[Abs[Last[sol[l]["cRp"][[p]]]], {l, lList}]]/Max[Abs[Flatten[Table[sol[l]["cRp"][[p]], {l, lList}]]]], {p, nPan}]},
  log["R: worst panel = ", First[Ordering[res, -1]], " (r - r+ in [", numStr[N[xB[[First[Ordering[res, -1]]]], 3]], ", ", numStr[N[xB[[First[Ordering[res, -1]] + 1]], 3]], "])"];
  check["R: radial resolution of the \[CapitalPsi]4 modes (last panel Chebyshev coefficient / largest, all modes)", maxB[res], 10^-12];
  diag["Rpanel"] = <|"rPanelMid" -> Table[rpN + panMid[p], {p, nPan}], "lastCoeffRatio" -> Map[bndS, res]|>;
  diag["psi4Spectrum"] = <|"l" -> lList, "spectrum" -> Table[Table[Max[Table[bndS[c[[k]]]/Max[Abs[c]], {c, sol[l]["cRp"]}]], {k, nPn}], {l, lList}]|>];      (* [[\[ScriptL], k]]: max over panels of |c_k|/max|c| *)
O4fun = optFun[{r, \[Chi], rq0, rq1, rq2, yq0, yq1, yq2}, (O4gen /. {M -> 1, a -> aN}) /. {Derivative[2][Rt][r] -> rq2, Derivative[1][Rt][r] -> rq1, Rt[r] -> rq0, Derivative[2][St][\[Chi]] -> yq2, Derivative[1][St][\[Chi]] -> yq1, St[\[Chi]] -> yq0},
   N[{37/10, 3/10, 1/3, 1/5, 1/7, 2/3, 1/4, 1/6}, wp]];
(* symbolic \[Chi]-derivatives of _{-2}Y_\[ScriptL]0 once per \[ScriptL] (one per job), then substituted (they were re-derived at every point) *)
Y2Dsym[l_] := Y2Dsym[l] = Table[D[Y2[l, y1], {y1, k}], {k, 0, 2}];
Module[{ys = pMap[Function[l, Table[D[Y2[l, y1], {y1, k}], {k, 0, 2}]], lList]}, Do[Y2Dsym[lList[[i]]] = ys[[i]], {i, Length[lList]}]];
Y2D[l_, c0_] := Y2Dsym[l] /. y1 -> c0;
O4Psi4[r0_, c0_, lm_ : lmax] := Sum[O4fun[r0, c0, Sequence @@ RpDer[l, r0], Sequence @@ N[Y2D[l, c0], wp]], {l, 2, lm}];
S4Tex[r0_, c0_] := src4fun[r0, c0, Sequence @@ fEx[r0], Sequence @@ SExAt[c0]];
S4Tpred[r0_, c0_] := S4Tex[r0, c0] + N[(W4/(2 \[CapitalSigma]K)) /. {M -> 1, a -> aN, r -> r0, \[Chi] -> c0}, wp] tailT[r0, c0];
(* G3: the unseparated O4 applied to \[CapitalPsi]4 = W4 \[CapitalSigma] R_\[ScriptL] Y_\[ScriptL] equals the exact source plus the known \[ScriptL] > lmax remainder (15 points;
   jobs: (point, half of the \[ScriptL]-list) for O4 \[CapitalPsi]4 and one per point for the source) *)
O4part[pt_, ls_] := Sum[O4fun[pt[[1]], pt[[2]], Sequence @@ RpDer[l, pt[[1]]], Sequence @@ N[Y2D[l, pt[[2]]], wp]], {l, ls}];
g3Task[{"o4", pt_, ls_}] := O4part[pt, ls];
g3Task[{"s4", pt_}] := {S4Tex[pt[[1]], pt[[2]]], S4Tpred[pt[[1]], pt[[2]]]};
Module[{pts = Tuples[{{2, 4, 15, 50, 200}, {-83/100, 21/100, 66/100}}], hl = Ceiling[Length[lList]/2], np, out, lhs, res},
  np = Length[pts];
  out = pMap[g3Task, Join[Flatten[Table[{"o4", pt, ch}, {pt, pts}, {ch, {Take[lList, hl], Drop[lList, hl]}}], 1], Table[{"s4", pt}, {pt, pts}]]];
  lhs = Total /@ Partition[Take[out, 2 np], 2];
  res = Table[{relErr[lhs[[i]], out[[2 np + i, 1]]], relErr[lhs[[i]], out[[2 np + i, 2]]]}, {i, np}];
  Do[log["   (r, \[Chi]) = ", pts[[i]], ":  pure \[ScriptL]-truncation error |O4\[CapitalPsi]4 - S4T|/|S4T| = ", sci[res[[i, 1]]], ",  with the remainder: ", sci[res[[i, 2]]]], {i, np}];
  diag["G3"] = <|"points" -> pts, "pureTruncation" -> Map[bndS, res[[All, 1]]], "withRemainder" -> Map[bndS, res[[All, 2]]]|>;
  check["G3: O4 \[CapitalPsi]4 = S4T + (\[ScriptL] > lmax remainder) at 15 off-grid points", Max[res[[All, 2]]], 10^-9]];
Psi4[r0_?NumericQ, c0_?NumericQ] := N[(W4 /. {M -> 1, a -> aN, r -> r0, \[Chi] -> c0}), wp] Sum[RpEval[l, r0] Y2N[l, c0], {l, lList}];
Psi4H[c0_] := N[((rpN + I aN c0)/(rpN - I aN c0))^2, wp] Sum[sol[l]["Cin"] Y2N[l, c0], {l, lList}];      (* \[CapitalPsi]4 on H+ *)

(* ==================================================================================================== *)
stage["8. Export of \[CapitalPsi]4 and T_ab (Psi4_Tab_cloud.mx)"];
exportFile = FileNameJoin[{outDir, "Psi4_Tab_cloud.mx"}];
fRulesAll = {Derivative[3][fs][r] -> fq3, Derivative[2][fs][r] -> fq2, Derivative[1][fs][r] -> fq1, fs[r] -> fq0};
sRulesAll = {Derivative[3][Ss][\[Chi]] -> sq3, Derivative[2][Ss][\[Chi]] -> sq2, Derivative[1][Ss][\[Chi]] -> sq1, Ss[\[Chi]] -> sq0};
TabCompact = <|"nn" -> ((TnnC[fs[r], Ss[\[Chi]]] /. numPar) /. fRulesAll /. sRulesAll),
   "nmb" -> ((TnmbC[fs[r], Ss[\[Chi]]] /. numPar) /. fRulesAll /. sRulesAll),
   "mbmb" -> ((TmbmbC[fs[r], Ss[\[Chi]]] /. numPar) /. fRulesAll /. sRulesAll),
   "S4T" -> ((src4 /. numPar) /. fRulesAll /. sRulesAll)|>;
(* numeric value of an expression in {r, \[Chi], fq0..fq3, sq0..sq3} from the exact Leaver f and the exact mixing-coefficient S *)
TabAt[e_, r0_, c0_] := Module[{fv = fEx[r0], sv = SExAt[c0]},
   N[e /. {fq0 -> fv[[1]], fq1 -> fv[[2]], fq2 -> fv[[3]], fq3 -> fv[[4]], sq0 -> sv[[1]], sq1 -> sv[[2]], sq2 -> sv[[3]], sq3 -> sv[[4]], r -> r0, \[Chi] -> c0}, wp]];
(* reference values at four test points *)
refPts = {{rpN + 1/1000, 21/100}, {3, -1/2}, {12, 7/10}, {150, 1/3}};
refVals = pMap[Function[pt, <|"r" -> pt[[1]], "chi" -> pt[[2]], "Psi4" -> Psi4[pt[[1]], pt[[2]]],
    "R" -> Table[RpDer[l, pt[[1]]], {l, lList}],
    "Rin" -> Table[Rhom[l]["In"][pt[[1]]], {l, lList}], "Rup" -> Table[Rhom[l]["Up"][pt[[1]]], {l, lList}],
    "f" -> fEx[pt[[1]]], "S" -> SExAt[pt[[2]]],
    "Tnn" -> TabAt[TabCompact["nn"], pt[[1]], pt[[2]]], "Tnmb" -> TabAt[TabCompact["nmb"], pt[[1]], pt[[2]]], "Tmbmb" -> TabAt[TabCompact["mbmb"], pt[[1]], pt[[2]]]|>], refPts];          (* one point per job *)
exportData = <|
   "params" -> <|"einsteinEquation" -> "G = 1: delta G_ab = 8 Pi T_ab, Phi = Sqrt[amp2] Phi_unit, E_cloud = 2 Pi Integral Sigma (-T^v_v)", "l" -> l1, "m" -> m1, "a" -> aN, "mu" -> \[Mu]N, "omegac" -> \[Omega]H, "q" -> qN, "alpha" -> \[Alpha]N, "gamma" -> \[Gamma]N, "rplus" -> rpN, "rminus" -> rmN,
     "wp" -> wp, "lmax" -> lmax, "nChi" -> nChi, "nP" -> nP, "nPn" -> nPn, "nchiRec" -> n\[Chi], "omegaLeaver" -> \[Omega], "Alm" -> Alm|>,
   "cloud" -> <|"fPanels" -> <|"xB" -> xB, "xMax" -> xMax, "nPn" -> nPn, "coef" -> cfP,
        "note" -> "per radial panel p (x = r - r+ in [xB[[p]], xB[[p+1]]], t = (x - mid)/half-width): Chebyshev coefficients (in t) of {f, df/dr, d2f/dr2, d3f/dr3}; |f| < e^{q xMax} beyond xMax"|>,
      "seriesTerms" -> Length[cL], "cP" -> cP, "jList" -> Keys[bBHPT], "bBHPT" -> bBHPT, "PpolyR" -> PpolyR, "aThreshold" -> aa, "nCF" -> nCF|>,
   "Psi4" -> <|"lList" -> lList, "xB" -> xB, "xMax" -> xMax, "nPn" -> nPn, "sol" -> AssociationMap[KeyTake[sol[#], {"cRp", "Cin", "Cup", "Wronskian"}] &, lList], "W4" -> W4|>,
   "reference" -> refVals|>;
(* exportData (cloud, Psi4) is written at the end, in the single file boson_cloud.wdx *)
par = exportData["params"];

(* ==================================================================================================== *)
stage["9. Reconstruction operators T4 (h_mbarmbar) and E_nn (h_mmbar)"];
rMax = rpN + xMax;
(* spin scan: NIntegrate split points beyond r = 400 (geometric, up to rMax) and the far radius of the decay checks (10^6 for the reference cloud) *)
farPts = Table[400 4^k, {k, 1, Max[0, Floor[Log[4, N[rMax/400]]]]}];
rFar = Max[10^6, 100 Ceiling[rMax]];
panelEval[coefs_, rr_, d_ : 0] := Module[{xx = rr - rpN, p, t},       (* d-th r-derivative of a panel-wise Chebyshev function *)
   p = panelIndex[xx]; t = (xx - panMid[p])/panH[p];
   chebEval[Nest[chebDer, coefs[[p]], d], t]/panH[p]^d];
\[CapitalDelta]K = r^2 - 2 M r + a^2; \[CapitalSigma]K = r^2 + a^2 \[Chi]^2;
EF = (r - I a \[Chi])^2/(r + I a \[Chi]);
T4h = -1/2 \[Thorn]pExt[-3, 1, 0, -1][\[Thorn]pExt[-2, 2, 0, -1][hs[r, \[Chi]]]];
Ennh = -(\[Thorn]pExt[-1, -1, 0, 0][\[Thorn]pExt[0, 0, -1, -1][hs[r, \[Chi]]]] + 2 \[Rho]\[Rho]p \[Rho]\[Rho]cp hs[r, \[Chi]]);
testPt = {M -> 1, a -> 3/5, r -> 37/10, \[Chi] -> 3/10};
hTest = Function[{rr, cc}, Exp[rr/3] Sin[cc + rr] + I rr^2 cc];
(* numeric operator functions: arguments (r, \[Chi], h, \[PartialD]_r h, \[PartialD]_r^2 h) *)
hRules = {Derivative[2, 0][hs][r, \[Chi]] -> hq2, Derivative[1, 0][hs][r, \[Chi]] -> hq1, hs[r, \[Chi]] -> hq0};
T4fun = Function[Evaluate[{r, \[Chi], hq0, hq1, hq2}], Evaluate[(T4h /. {M -> 1, a -> aN}) /. hRules]];
Ennfun = Function[Evaluate[{r, \[Chi], hq0, hq1, hq2}], Evaluate[(Ennh /. {M -> 1, a -> aN}) /. hRules]];

(* ==================================================================================================== *)
stage["10. h_mbarmbar from \[CapitalPsi]4"];
QH[l_, X_] := Sqrt[Pi] Gamma[l + 1]/(Gamma[l + 3/2] (2 X)^(l + 1)) Hypergeometric2F1[(l + 1)/2, (l + 2)/2, l + 3/2, 1/X^2];
QHd[l_, k_] := QHd[l, k] = Function[{Xs}, Evaluate[D[QH[l, Xs], {Xs, k}]]];
NUp[l_] := (2 l + 1)!!/((l + 2)! \[Kappa]N^(l + 3));
Xof[rr_] := (rr - 1)/\[Kappa]N;
cupA = AssociationMap[sol[#]["Cup"] &, lList];          (* only the Up normalizations: tailMB no longer drags sol to the subkernels *)
tailMB[l_, rr_] := Module[{X = Xof[rr], c = cupA[l] NUp[l]},          (* {g, I1, I2, I3} for r >= r+ + xMax *)
   {c QHd[l, 2][X], -\[Kappa]N c QHd[l, 1][X], \[Kappa]N^2 c QH[l, X], \[Kappa]N^3 c (QH[l - 1, X] - QH[l + 1, X])/(2 l + 1)}];

(* repInt3[gc, tail]: gc[[p]] = Chebyshev coefficients (in t) of the integrand on panel p; tail = {I1, I2, I3} at the outer end r+ + xMax.
   Returns, per panel, the Chebyshev coefficients of {I1, I2, I3},  I_k(r) = I_k(right end) + \[Integral]_r^{right end} I_{k-1}.  Exact polynomial algebra; the
   integration runs from the outermost panel inward, so decaying integrands keep their relative accuracy. *)
repInt3[gc_List, tail_List] := Module[{np = Length[gc], out, start = tail, cur, Fc, new, ik},
   out = ConstantArray[0, np];
   Do[cur = gc[[p]]; ik = {};
    Do[Fc = panH[p] chebInt[cur];
     new = -Fc; new[[1]] += start[[k]] + chebEval[Fc, 1];
     AppendTo[ik, new]; cur = new, {k, 3}];
    out[[p]] = ik;
    start = chebEval[#, -1] & /@ ik,
    {p, np, 1, -1}];
   out];
(* g_\[ScriptL] = R_\[ScriptL]/\[CapitalDelta]^2 on the panels and its repeated integrals: one \[ScriptL] per job (only that \[ScriptL]'s panel series is sent) *)
gcTask[{l_, cR_, tl_}] := Module[{g = Table[chebCoef[(chebValMat[nPn] . cR[[p]])/\[CapitalDelta]N[rPan[[p]]]^2], {p, nPan}]}, {g, repInt3[g, tl]}];
tm["g_\[ScriptL] and the repeated integrals I1, I2, I3 of all modes (one \[ScriptL] per job)",
  Module[{res = pMap[gcTask, Table[{l, sol[l]["cRp"], Rest[tailMB[l, rMax]]}, {l, lList}]]},
   gC = AssociationThread[lList, res[[All, 1]]]; mbData = AssociationThread[lList, res[[All, 2]]]]];
(* I_j^{(d)}(r) for mode \[ScriptL] (j = 0 is g itself); closed form beyond r+ + xMax, where d/dr I_j = -I_{j-1} (needs j >= d) *)
IMB[l_, j_, rr_, d_ : 0] := If[rr - rpN >= xMax, (-1)^d tailMB[l, rr][[j - d + 1]], panelEval[If[j == 0, gC[l], mbData[l][[All, j]]], rr, d]];
uMB = Table[D[1/EF, {r, k}], {k, 0, 2}] /. {a -> aN};
HMB[rr_, cc_, d_] := Module[{ra = rr + I aN cc},                      (* d-th r-derivative of H = E h_mbarmbar *)
   -2 Sum[Y2N[l, cc] (2 IMB[l, 3, rr, d] + ra IMB[l, 2, rr, d] + If[d > 0, d IMB[l, 2, rr, d - 1], 0]), {l, lList}]];
hMB[rr_?NumericQ, cc_?NumericQ] := HMB[rr, cc, 0] N[uMB[[1]] /. {r -> rr, \[Chi] -> cc}, wp];
hMBder[rr_, cc_] := Module[{H = Table[HMB[rr, cc, d], {d, 0, 2}], u = N[uMB /. {r -> rr, \[Chi] -> cc}, wp]},
   {H[[1]] u[[1]], H[[2]] u[[1]] + H[[1]] u[[2]], H[[3]] u[[1]] + 2 H[[2]] u[[2]] + H[[1]] u[[3]]}];
hMBmode[l_, rr_, cc_] := -2 Y2N[l, cc] (2 IMB[l, 3, rr] + (rr + I aN cc) IMB[l, 2, rr]) N[uMB[[1]] /. {r -> rr, \[Chi] -> cc}, wp];
log["resolution, max over panels of |last coeff|/max|coeffs|:  g_2: ", sci[Max[Table[Abs[Last[c]]/Max[Abs[c]], {c, gC[2]}]], 3],
  ",  I3 (\[ScriptL] = 2): ", sci[Max[Table[Abs[Last[c[[3]]]]/Max[Abs[c[[3]]]], {c, mbData[2]}]], 3]];
gM[l_, s_?NumericQ] := gM[l, s] = Rval[l, s]/\[CapitalDelta]N[s]^2;
(* (i) panel repeated integrals vs direct NIntegrate of the single-integral Green formulas (4 cases, one per job) *)
Module[{cases = Tuples[{{2, 3}, {rpN + 1/10, 8}}], res},
  res = pMap[Function[lr, Module[{l = lr[[1]], r0 = lr[[2]], pts, tl, L, i2n, i3n},
      pts = Join[{r0}, Select[Join[{3, 6, 20, 100, 400}, farPts], r0 < # < rMax &], {rMax}]; tl = tailMB[l, rMax]; L = rMax - r0;
      i2n = NIntegrate[(s - r0) gM[l, s], Evaluate[Join[{s}, pts]], WorkingPrecision -> 30, PrecisionGoal -> 20, MaxRecursion -> 30] + tl[[3]] + L tl[[2]];
      i3n = NIntegrate[(s - r0)^2/2 gM[l, s], Evaluate[Join[{s}, pts]], WorkingPrecision -> 30, PrecisionGoal -> 20, MaxRecursion -> 30] + tl[[4]] + L tl[[3]] + L^2/2 tl[[2]];
      Max[relErr[IMB[l, 2, r0], i2n], relErr[IMB[l, 3, r0], i3n]]]], cases];
  check["4c: I2, I3 panels vs NIntegrate of \[Integral](r'-r)g, (1/2)\[Integral](r'-r)^2 g (\[ScriptL] = 2, 3; r = r+ + 0.1, 8)", Max[res], 10^-15]];
(* (ii) the 2D equation T4[h_mbarmbar] = \[CapitalPsi]4 at off-grid points *)
Module[{pts = Tuples[{{rpN + 10^-3, 5/2, 7, 40, 300, 2500, 10^5}, {-3/5, 21/100, 83/100}}]},
  check["4c: T4[h_mbarmbar] = \[CapitalPsi]4 at 21 off-grid points (r+ + 10^-3 .. 10^5)", Max[pMap[Function[pt, relErr[T4fun[pt[[1]], pt[[2]], Sequence @@ hMBder[pt[[1]], pt[[2]]]], Psi4[pt[[1]], pt[[2]]]]], pts]], 10^-12]];
(* (iii) convergence: share of I_j(r+) from r > r+ + xMax, power-law tails *)
log["share of I_j(r+) from r > rMax (\[ScriptL] = 2): ", sci[Table[Abs[Sum[xMax^m/m! tailMB[2, rMax][[j - m + 1]], {m, 0, j - 1}]]/Abs[IMB[2, j, rpN]], {j, 1, 3}]]];

(* ==================================================================================================== *)
stage["11. h_mmbar from T_nn"];
\[Tau]of[fv_, rr_] := kapE 2 (fv[[2]]^2 + (\[Omega]H (rr + rpN)/(rr - rmN))^2 fv[[1]]^2);          (* source kapE T_nn / S^2 (G = 1) *)
\[Tau]ex[s_?NumericQ] := \[Tau]of[fEx[s], s];
\[Tau]sp[s_?NumericQ] := \[Tau]of[fSpec[s], s];
\[Tau]Nodes = Table[\[Tau]of[fP[[p, j]], rPan[[p, j]]], {p, nPan}, {j, nPn}];      (* fP: f-jets at the panel nodes (section 6) *)
\[Tau]C = chebCoef /@ \[Tau]Nodes;
tm["tails of the \[Tau] integrals beyond xMax (NIntegrate of the Leaver series; 3 moments x 8 sub-intervals, one per job)",
  Module[{edges = rMax + 375 scN Range[0, 8], res},
   res = pMap[Function[jk, NIntegrate[((s - rMax)^(jk[[1]] - 1)/(jk[[1]] - 1)!) \[Tau]ex[s], {s, jk[[2]], jk[[3]]}, WorkingPrecision -> 30, PrecisionGoal -> 10]],
     Flatten[Table[{j, edges[[i]], edges[[i + 1]]}, {j, 3}, {i, 8}], 1]];
   tailNN = Total /@ Partition[res, 8]]];
nnData = repInt3[\[Tau]C, tailNN];
KNN[j_, rr_, d_ : 0] := If[rr - rpN >= xMax, 0, panelEval[If[j == 0, \[Tau]C, nnData[[All, j]]], rr, d]];      (* beyond xMax: |h_mmbar| < e^{2 q xMax}, set to 0 *)
wD = Table[D[2 r/(r^2 + a^2 \[Chi]^2), {r, k}], {k, 0, 2}] /. a -> aN;
hMM[rr_?NumericQ, cc_?NumericQ] := -SExAt[cc][[1]]^2 (KNN[2, rr] + N[wD[[1]] /. {r -> rr, \[Chi] -> cc}, wp] KNN[3, rr]);
hMMder[rr_, cc_] := Module[{s2 = SExAt[cc][[1]]^2, w = N[wD /. {r -> rr, \[Chi] -> cc}, wp], k2 = Table[KNN[2, rr, d], {d, 0, 2}], k3 = Table[KNN[3, rr, d], {d, 0, 2}]},
   -s2 {k2[[1]] + w[[1]] k3[[1]], k2[[2]] + w[[2]] k3[[1]] + w[[1]] k3[[2]], k2[[3]] + w[[3]] k3[[1]] + 2 w[[2]] k3[[2]] + w[[1]] k3[[3]]}];
log["tail share K_j(r > rMax)/K_j(r+): ", sci[Table[Abs[Sum[xMax^m/m! tailNN[[j - m]], {m, 0, j - 1}]]/Abs[KNN[j, rpN]], {j, 1, 3}], 3]];
check["5: integrals converged: share of K1, K2, K3 from r > r+ + xMax", Max[Table[Abs[Sum[xMax^m/m! tailNN[[j - m]], {m, 0, j - 1}]]/Abs[KNN[j, rpN]], {j, 1, 3}]], 10^-40];
hMMdirect[r0_, c0_] := -SExAt[c0][[1]]^2 NIntegrate[(s - r0) (r0 s + aN^2 c0^2)/(r0^2 + aN^2 c0^2) \[Tau]ex[s], Evaluate[Join[{s, r0}, Select[Join[{3, 6, 20, 60, 150, 400}, farPts], r0 < # < rMax &], {rMax}]],
     WorkingPrecision -> 30, PrecisionGoal -> 20, MaxRecursion -> 30];
Module[{pts = {rpN + 1/10, 4, 30}},
  check["5: h_mmbar panels vs NIntegrate of the Green formula (r = r+ + 0.1, 4, 30; \[Chi] = 0.21)", Max[pMap[relErr[hMM[#, 21/100], hMMdirect[#, 21/100]] &, pts]], 10^-15]];
Module[{pts = Tuples[{{rpN + 10^-3, 5/2, 7, 40, 300, 1200}, {-3/5, 21/100, 83/100}}]},
  check["5: E_nn[h_mmbar] = T_nn at 18 off-grid points", Max[pMap[Function[pt, relErr[Ennfun[pt[[1]], pt[[2]], Sequence @@ hMMder[pt[[1]], pt[[2]]]], \[Tau]ex[pt[[1]]] SExAt[pt[[2]]][[1]]^2]], pts]], 10^-12]];

(* ==================================================================================================== *)
stage["12. Linearized Einstein operator in the traceful ORG"];
(* 7a. traceful-ORG metric perturbation and the linearized Einstein tensor in coordinates (M = 1) *)
hNames = {hLL, hLM, hLMb, hMM, hMbMb, hMMb};          (* h_ll, h_lm, h_lmbar, h_mm, h_mbarmbar, h_mmbar;  h_nb = 0 *)
hTet[fl_] := {{fl[[1]], 0, fl[[2]], fl[[3]]}, {0, 0, 0, 0}, {fl[[2]], 0, fl[[4]], fl[[6]]}, {fl[[3]], 0, fl[[6]], fl[[5]]}};   (* order l, n, m, mbar *)
gdd1 = gdd /. M -> 1; guu1 = guu /. M -> 1; \[CapitalGamma]udd1 = \[CapitalGamma]udd /. M -> 1; eDu1 = eDu /. M -> 1; eDd1 = eDd /. M -> 1;
eDual1 = Inverse[\[Eta]DD] . eDd1;                               (* \[Omega]^a_\[Mu] = \[Eta]^{ab} e_{b \[Mu]}: \[Omega]^a_\[Mu] e_b^\[Mu] = \[Delta]^a_b *)
hDDof[fl_] := Transpose[eDual1] . hTet[fl] . eDual1;        (* h_\[Mu]\[Nu] = \[CapitalSigma]_ab h_ab \[Omega]^a_\[Mu] \[Omega]^b_\[Nu] *)
linEinstein[hDD_] := Module[{dh, \[Delta]\[CapitalGamma], \[Delta]Ric, trR},
   dh = Table[D[hDD[[i1, j1]], x[[k1]]], {i1, 4}, {j1, 4}, {k1, 4}];                          (* \[PartialD]_k h_ij *)
   \[Delta]\[CapitalGamma] = Table[Sum[guu1[[\[Rho]1, \[Sigma]1]] (1/2 (dh[[\[Nu]1, \[Sigma]1, \[Mu]1]] + dh[[\[Mu]1, \[Sigma]1, \[Nu]1]] - dh[[\[Mu]1, \[Nu]1, \[Sigma]1]]) - Sum[\[CapitalGamma]udd1[[\[Lambda]1, \[Mu]1, \[Nu]1]] hDD[[\[Lambda]1, \[Sigma]1]], {\[Lambda]1, 4}]), {\[Sigma]1, 4}],
     {\[Rho]1, 4}, {\[Mu]1, 4}, {\[Nu]1, 4}];
   \[Delta]Ric = Table[Sum[D[\[Delta]\[CapitalGamma][[\[Rho]1, \[Mu]1, \[Nu]1]], x[[\[Rho]1]]] - D[\[Delta]\[CapitalGamma][[\[Rho]1, \[Rho]1, \[Mu]1]], x[[\[Nu]1]]], {\[Rho]1, 4}] +
      Sum[\[CapitalGamma]udd1[[\[Rho]1, \[Rho]1, \[Lambda]1]] \[Delta]\[CapitalGamma][[\[Lambda]1, \[Mu]1, \[Nu]1]] + \[CapitalGamma]udd1[[\[Lambda]1, \[Mu]1, \[Nu]1]] \[Delta]\[CapitalGamma][[\[Rho]1, \[Rho]1, \[Lambda]1]] - \[CapitalGamma]udd1[[\[Rho]1, \[Nu]1, \[Lambda]1]] \[Delta]\[CapitalGamma][[\[Lambda]1, \[Rho]1, \[Mu]1]] - \[CapitalGamma]udd1[[\[Lambda]1, \[Rho]1, \[Mu]1]] \[Delta]\[CapitalGamma][[\[Rho]1, \[Nu]1, \[Lambda]1]], {\[Rho]1, 4}, {\[Lambda]1, 4}],
     {\[Mu]1, 4}, {\[Nu]1, 4}];
   trR = Sum[guu1[[i1, j1]] \[Delta]Ric[[i1, j1]], {i1, 4}, {j1, 4}];
   \[Delta]Ric - 1/2 gdd1 trR];
projList = {"nn" -> {2, 2}, "nmb" -> {2, 4}, "ln" -> {1, 2}, "ll" -> {1, 1}, "lmb" -> {1, 4}, "mmb" -> {3, 4}, "mbmb" -> {4, 4}};
jetList = {{0, 0}, {1, 0}, {0, 1}, {2, 0}, {1, 1}, {0, 2}};      (* {i, j} = \[PartialD]_r^i \[PartialD]_\[Chi]^j *)
opsFile = FileNameJoin[{cacheDir, "ORG_Einstein_operators_M1.mx"}];
opsOld = If[FileExistsQ[opsFile], Quiet[Import[opsFile]], $Failed];
If[AssociationQ[opsOld] && opsOld["version"] === "ORG-1",
  opCoef = opsOld["opCoef"]; log["Einstein-operator coefficients loaded from ", opsFile],
  (* phase A: \[Delta]G_ab contracted with the tetrad for the kf-th ORG function (one function per job);
     phase B: the coefficients of its six jets, one (function, component) per job (42 jobs instead of 6) *)
  opEx[kf_] := Module[{fn = hNames[[kf]], fl, \[Delta]G, jr},
     fl = Table[If[k == kf, hNames[[k]][r, \[Chi]], 0], {k, 6}];
     \[Delta]G = linEinstein[hDDof[fl]];
     jr = {Derivative[i_, j_][fn][r, \[Chi]] :> jet[fn, i, j], fn[r, \[Chi]] -> jet[fn, 0, 0]};
     Table[(eDu1[[pr[[2, 1]]]] . \[Delta]G . eDu1[[pr[[2, 2]]]]) /. jr, {pr, projList}]];
  opCoefTask[{kf_, ip_, ex_}] := Module[{fn = hNames[[kf]], pr = projList[[ip]], loc = <||>, resid, t0 = AbsoluteTime[], warn = Null},
     Do[loc[{pr[[1]], fn, jt}] = Together[D[ex, jet[fn, Sequence @@ jt]]], {jt, jetList}];
     (* completeness: E_ab is linear in these six jets and contains nothing else *)
     resid = Abs[N[(ex - Sum[loc[{pr[[1]], fn, jt}] jet[fn, Sequence @@ jt], {jt, jetList}]) /. {jet[_, i_, j_] :> (3 + i + 2 j)/7, a -> 3/5, r -> 37/10, \[Chi] -> 3/10}, 30]];
     If[! (resid < 10^-20) || ! FreeQ[ex /. jet[__] -> 0, fn], warn = "WARNING: " <> pr[[1]] <> " / " <> ToString[fn] <> ": not a combination of the six jets, residual " <> ToString[resid]];
     {Normal[loc], warn, AbsoluteTime[] - t0}];
  If[useParallel, DistributeDefinitions[opEx, opCoefTask]];
  tm["Einstein operator: \[Delta]G_ab of the six ORG functions (one per job)", opExs = pMap[opEx, Range[6]]];
  tm["Einstein operator: coefficients of the six jets (one (function, component) per job)",
   opRes = pMap[opCoefTask, Flatten[Table[{kf, ip, opExs[[kf, ip]]}, {kf, 6}, {ip, Length[projList]}], 1]];
   opCoef = Association[Flatten[opRes[[All, 1]]]]; Scan[If[StringQ[#], log[#]] &, opRes[[All, 2]]];
   log["      longest (function, component) job: ", Round[Max[opRes[[All, 3]]], 0.1], " s"]];
  
  Export[opsFile, <|"version" -> "ORG-1", "opCoef" -> opCoef|>, "MX"];
  log["saved to ", opsFile]];
(* 7b. checks of the operator *)
numZero[e_] := Max[Abs[N[e /. {a -> 3/5, r -> 37/10, \[Chi] -> 3/10}, 30]], Abs[N[e /. {a -> 7/10, r -> 53/10, \[Chi] -> -2/5}, 30]]];
opApply[ab_, fn_, hf_] := Sum[opCoef[{ab, fn, jt}] D[hf[r, \[Chi]], {r, jt[[1]]}, {\[Chi], jt[[2]]}], {jt, jetList}];
log["E_nmbar also involves h_mm: ", ! TrueQ[Max[Table[numZero[opCoef[{"nmb", hMM, jt}]], {jt, jetList}]] < 10^-25]];
EF5h = -1/2 (\[Thorn]pExt[-1, 1, 0, 0][\[Thorn]pExt[0, 2, -2, 0][hs[r, \[Chi]]]] + 2 \[Rho]\[Rho]cp (\[Rho]\[Rho]p - \[Rho]\[Rho]cp) hs[r, \[Chi]]);         (* h_lmbar term of ER (F5), type {0,2} *)
EF3h = -1/2 (\[Rho]\[Rho]p \[Thorn]pExt[2, 2, -1, 0][hs[r, \[Chi]]] + \[Rho]\[Rho]cp \[Thorn]pExt[2, 2, 0, -1][hs[r, \[Chi]]]);                  (* h_ll term of ER (F3), type {2,2} *)
(* 7c. homogeneous solutions of E_nmbar^{lmbar} and integrating factor of E_ln^{ll} *)
Aop = opCoef[{"nmb", hLMb, {2, 0}}]; Bop = opCoef[{"nmb", hLMb, {1, 0}}]; Cop = opCoef[{"nmb", hLMb, {0, 0}}];
\[Rho]p1 = 1/(r - I a \[Chi]); \[Rho]pb1 = 1/(r + I a \[Chi]);
homRes[u_] := Aop D[u, {r, 2}] + Bop D[u, r] + Cop u;
(* Held-type ansatz: products of \[Rho]', \[Rho]bar' (ER Eq. (17): \[Rho]'(\[Rho]'+\[Rho]bar') and \[Rho]'(\[Rho]'-2\[Rho]bar')/\[Rho]bar'^3) times powers of \[Rho]'/\[Rho]bar' (the static Held scalars of this frame) *)
homCands = Flatten[Table[(\[Rho]p1/\[Rho]pb1)^s1 u, {s1, -2, 2}, {u, {\[Rho]p1 (\[Rho]p1 + \[Rho]pb1), \[Rho]p1 (\[Rho]p1 - 2 \[Rho]pb1)/\[Rho]pb1^3, \[Rho]pb1 (\[Rho]p1 + \[Rho]pb1), \[Rho]pb1 (\[Rho]pb1 - 2 \[Rho]p1)/\[Rho]p1^3, \[Rho]p1 \[Rho]pb1, \[Rho]p1^2, \[Rho]pb1^2, 1/\[Rho]p1 + 1/\[Rho]pb1, \[Rho]p1/\[Rho]pb1 + \[Rho]pb1/\[Rho]p1}}]];
homSol = Pick[homCands, pMap[numZero[homRes[#]] < 10^-25 &, homCands]];
If[Length[homSol] >= 2,
  uHom = {homSol[[1]], SelectFirst[Rest[homSol], numZero[Together[homSol[[1]] D[#, r] - D[homSol[[1]], r] #]] > 10^-10 &]},
  log["WARNING: ansatz gave ", Length[homSol], " solutions; using DSolve"];
  uHom = Module[{ds = DSolve[Aop y1''[r] + Bop y1'[r] + Cop y1[r] == 0, y1[r], r]}, {y1[r] /. ds[[1]] /. {C[1] -> 1, C[2] -> 0}, y1[r] /. ds[[1]] /. {C[1] -> 0, C[2] -> 1}}]];
uHom = Simplify[uHom];
Wr = Simplify[uHom[[1]] D[uHom[[2]], r] - D[uHom[[1]], r] uHom[[2]]];
log["homogeneous solutions of E_nmbar^{lmbar}:  u1 = ", uHom[[1]], ",   u2 = ", uHom[[2]], ";   A = ", Simplify[Aop], ",   Wronskian u1 u2' - u1' u2 = ", Wr];
aLL = opCoef[{"ln", hLL, {1, 0}}]; bLL = opCoef[{"ln", hLL, {0, 0}}];
ifac = SelectFirst[{1/(\[Rho]p1 + \[Rho]pb1), \[Rho]p1 + \[Rho]pb1, r/\[CapitalSigma]K, \[CapitalSigma]K, 1/\[CapitalSigma]K, r, 1/r}, numZero[aLL D[#, r] - bLL #] < 10^-25 &, Missing[]];
If[MissingQ[ifac], ifac = Simplify[Exp[Integrate[Together[bLL/aLL], r]]]; log["integrating factor from Integrate: ", ifac]];
log["E_ln^{ll}[h] = a h' + b h with a = ", Simplify[aLL], ", b = ", Simplify[bLL], ";  integrating factor \[Mu] = ", Simplify[ifac], "  ((\[Mu] h)' = \[Mu] (h' + (b/a) h))"];
(* numeric versions (a -> aN), vectorizable in \[Chi] *)
{lmbF, llF} = pMap[optFun[{r, \[Chi]}, #, N[{37/10, 3/10}, wp]] &, {N[{uHom[[1]], uHom[[2]], D[uHom[[1]], r], D[uHom[[2]], r], uHom[[1]]/(Aop Wr), uHom[[2]]/(Aop Wr), Aop, Bop, Cop} /. a -> aN, wp],
    N[{ifac, aLL, bLL} /. a -> aN, wp]}];          (* CSE-optimized *)
opNZ = Pick[Keys[opCoef], pMap[numZero[#] > 10^-25 &, Values[opCoef]]];
coefF = Association[Table[key -> Function[Evaluate[{r, \[Chi]}], Evaluate[N[opCoef[key] /. a -> aN, wp]]], {key, opNZ}]];
(* per (component, function): the six jet coefficients as ONE CSE-optimized function (shared subexpressions such as r^2 + a^2 \[Chi]^2 are evaluated once);
   used on the node grids (EJm); coefF (plain) is used at single points *)
coefGroups = DeleteDuplicates[opNZ[[All, 1 ;; 2]]];
tm["CSE-optimized E_ab coefficient functions (one (component, function) per job)",
  coefL = AssociationThread[coefGroups, pMap[optFun[{r, \[Chi]}, #, N[{37/10, 3/10}, wp]] &,
     Table[Table[If[MemberQ[opNZ, Join[g, {jt}]], N[opCoef[Join[g, {jt}]] /. a -> aN, wp], 0], {jt, jetList}], {g, coefGroups}]]]];
check["opt: CSE-optimized E_ab coefficients = plain ones on the \[Chi] grid at r = 3 (relative)",
  Max[Table[Module[{cv = chebNodes[n\[Chi]], a1, b1}, a1 = coefL[g][3, cv]; b1 = Table[If[KeyExistsQ[coefF, Join[g, {jt}]], coefF[Join[g, {jt}]][3, cv], 0 cv], {jt, jetList}];
     Max[Abs[Flatten[a1 - b1]]]/Max[Max[Abs[Flatten[b1]]], 10^-300]], {g, coefGroups}]], 10^-(wp - 20)];
EJ[ab_, fn_, r0_, cv_, jets_] := Sum[If[KeyExistsQ[coefF, {ab, fn, jetList[[k]]}], coefF[{ab, fn, jetList[[k]]}][r0, cv] jets[[k]], 0], {k, 6}];
log["non-zero operator coefficients: ", Length[opNZ], " of ", Length[opCoef]];

(* ==================================================================================================== *)
stage["13. Full stress-energy tensor and Klein-Gordon residual of the cloud"];
Kc = \[Omega]c (r^2 + a^2) - a mc; \[CapitalDelta]c = r^2 - 2 r + a^2;
gL = {-I \[Omega]c, Derivative[1][fs][r]/fs[r] + I Kc/\[CapitalDelta]c, Derivative[1][Ss][\[Chi]]/Ss[\[Chi]], I mc};
gLb = {I \[Omega]c, Derivative[1][fs][r]/fs[r] - I Kc/\[CapitalDelta]c, Derivative[1][Ss][\[Chi]]/Ss[\[Chi]], -I mc};
amp2 = fs[r]^2 Ss[\[Chi]]^2;
Tdd1 = amp2 (Outer[Times, gL, gLb] + Outer[Times, gLb, gL]) - gdd1 amp2 (gL . guu1 . gLb + \[Mu]c^2);
TabSym = kapE eDu1 . Tdd1 . Transpose[eDu1];          (* tetrad components of the SOURCE kapE T_ab (G = 1: delta G_ab = 8 Pi T_ab); Tdd1 is T_ab itself *)
tParRules = {a -> aN, \[Omega]c -> \[Omega]H, mc -> m1, \[Mu]c -> \[Mu]N};
fsRules = {Derivative[2][fs][r] -> fq2, Derivative[1][fs][r] -> fq1, fs[r] -> fq0, Derivative[2][Ss][\[Chi]] -> sq2, Derivative[1][Ss][\[Chi]] -> sq1, Ss[\[Chi]] -> sq0};
TabF = Association[Table[pr[[1]] -> Function[Evaluate[{r, \[Chi], fq0, fq1, sq0, sq1}], Evaluate[N[(TabSym[[pr[[2, 1]], pr[[2, 2]]]] /. tParRules) /. fsRules, wp]]], {pr, projList}]];
(* all seven projections (Einstein residuals) and the two entering the sources (nmbar, ln), each as ONE CSE-optimized function *)
{TabFL, TabNL} = pMap[optFun[{r, \[Chi], fq0, fq1, sq0, sq1}, #, N[{37/10, 3/10, 1/3, 1/5, 2/3, 1/4}, wp]] &,
   {Table[N[(TabSym[[pr[[2, 1]], pr[[2, 2]]]] /. tParRules) /. fsRules, wp], {pr, projList}], Table[N[(TabSym[[pr[[2, 1]], pr[[2, 2]]]] /. tParRules) /. fsRules, wp], {pr, projList[[2 ;; 3]]}]}];
TabAtF[ab_, r0_, c0_] := Module[{fv = fEx[r0], sv = SExAt[c0]}, TabF[ab][r0, c0, fv[[1]], fv[[2]], sv[[1]], sv[[2]]]];
(* Klein-Gordon residual of the cloud: \:25a1\[CapitalPhi]/\[CapitalPhi] - \[Mu]^2 = (1/\[CapitalSigma]) \[CapitalSigma]_ij [\[PartialD]_i(\[CapitalSigma] g^{ij} g_j) + \[CapitalSigma] g^{ij} g_i g_j] - \[Mu]^2 *)
KGsym = Sum[D[\[CapitalSigma]K guu1[[i1, j1]] gL[[j1]], x[[i1]]] + \[CapitalSigma]K guu1[[i1, j1]] gL[[i1]] gL[[j1]], {i1, 4}, {j1, 4}]/\[CapitalSigma]K - \[Mu]c^2;
KGF = Function[Evaluate[{r, \[Chi], fq0, fq1, fq2, sq0, sq1, sq2}], Evaluate[N[(KGsym /. tParRules) /. fsRules, wp]]];
printGrid[Grid[Prepend[Table[Module[{fv = fEx[r0], sv = SExAt[c0]}, {N[r0, 5], N[c0, 3], sci[Abs[KGF[r0, c0, fv[[1]], fv[[2]], fv[[3]], sv[[1]], sv[[2]], sv[[3]]]]/\[Mu]N^2, 3]}],
     {r0, {rpN + 1/100, 3, 10, 40, 200}}, {c0, {21/100, 7/10}}] ~ Flatten ~ 1, {"r", "\[Chi]", "|\:25a1\[CapitalPhi]/\[CapitalPhi] - \[Mu]^2|/\[Mu]^2"}], Frame -> All]];
Module[{pts = Tuples[{{rpN + 1/100, 3, 10, 40, 200, 1000}, {21/100, 7/10}}], kg},
  kg = Table[Module[{fv = fEx[pt[[1]]], sv = SExAt[pt[[2]]]}, Abs[KGF[pt[[1]], pt[[2]], fv[[1]], fv[[2]], fv[[3]], sv[[1]], sv[[2]], sv[[3]]]]/\[Mu]N^2], {pt, pts}];
  check["cloud: Klein-Gordon residual |\:25a1\[CapitalPhi]/\[CapitalPhi] - \[Mu]^2|/\[Mu]^2 at 12 points (the floor of the Einstein equations not solved directly)", maxB[kg], 10^-25];
  diag["KG"] = <|"points" -> pts, "relResidual" -> kg|>];
(* KG residual profile along r at two angles (diagnostics) *)
diag["KGprofile"] = Module[{rs = N[rpN + 10^(Range[-40, Floor[10 Log10[N[xMax]]]]/10), wp], cs = {21/100, 7/10}, vals},
   vals = pMap[Function[rc, Module[{fv = fEx[rc[[1]]], sv = SExAt[rc[[2]]]}, bndS[Abs[KGF[rc[[1]], rc[[2]], fv[[1]], fv[[2]], fv[[3]], sv[[1]], sv[[2]], sv[[3]]]]/\[Mu]N^2]]], Tuples[{rs, cs}]];
   <|"r" -> rs, "chi" -> cs, "relResidual" -> Partition[vals, Length[cs]]|>];

(* ==================================================================================================== *)
stage["14. h_lmbar from the nmbar Einstein equation (grids, node data, pipeline)"];
(* 9a. grids, differentiation matrices, node data that do not depend on the \[ScriptL]-list *)
\[Chi]N = chebNodes[n\[Chi]]; s\[Theta]N = Sqrt[1 - \[Chi]N^2]; s\[Theta]D = {s\[Theta]N, -\[Chi]N/s\[Theta]N, -1/s\[Theta]N - \[Chi]N^2/s\[Theta]N^3};      (* d^k sin\[Theta]/d\[Chi]^k at the nodes *)
(* values of T_k^(d) at the Chebyshev-Gauss nodes x_j = cos \[Theta]_j, \[Theta]_j = \[Pi] (j + 1/2)/nn (rows j, columns k), from the closed forms
     T_k = cos k\[Theta],   T_k' = k sin k\[Theta] / sin \[Theta],   T_k'' = (x T_k' - k^2 T_k)/(1 - x^2)      (Chebyshev ODE),
   evaluated with N at the EXACT angles. (v6 expanded T_k in monomials, whose coefficients ~2^(k-1) cancel ~28 of 40 digits for k ~ 80.) *)
TderVal[nn_, d_] := TderVal[nn, d] = N[Table[With[{th = Pi (j + 1/2)/nn},
      Switch[d, 0, Cos[k th], 1, k Sin[k th]/Sin[th], 2, (k Cos[th] Sin[k th]/Sin[th] - k^2 Cos[k th])/Sin[th]^2]], {j, 0, nn - 1}, {k, 0, nn - 1}], wp];
(* digits of an array relative to its largest entry (significance arithmetic) *)
digitsRel[m_] := Accuracy[m] + Log10[Max[Abs[Flatten[{m}]]]];
DM\[Chi] = {TderVal[n\[Chi], 1] . chebMat[n\[Chi]], TderVal[n\[Chi], 2] . chebMat[n\[Chi]]};          (* node values -> derivative values *)
DMt = TderVal[nPn, 1] . chebMat[nPn];                                            (* d/dt on a radial panel *)
TmatAt[nn_] := TmatAt[nn] = N[Table[ChebyshevT[k, t1], {t1, tP}, {k, 0, nn - 1}], wp];
chebEvalV[c_, z_] := ChebyshevT[Range[0, Length[c] - 1], z] . c;
rowTimes[m_, v_] := (# v) & /@ m; rowPlus[m_, v_] := (# + v) & /@ m;
(* test of the \[Chi] differentiation on the hardest analytic structure of the problem: the pole of \[Rho]' = 1/(r - i a \[Chi]) at \[Chi] = -i r/a, closest at r = r+.
   Chebyshev error ~ \[Rho]_B^-n with \[Rho]_B = r+/a + Sqrt[(r+/a)^2 + 1] \[TildeTilde] 3.65, times ~n^2 per derivative *)
dmTest[nn_] := Module[{cn = chebNodes[nn], D1, D2, fz, d1, d2},
   D1 = TderVal[nn, 1] . chebMat[nn]; D2 = TderVal[nn, 2] . chebMat[nn];
   fz = 1/(rpN - I aN cn)^3; d1 = 3 I aN/(rpN - I aN cn)^4; d2 = -12 aN^2/(rpN - I aN cn)^5;
   {Max[Abs[D1 . fz - d1]]/Max[Abs[d1]], Max[Abs[D2 . fz - d2]]/Max[Abs[d2]]}];
log["significant digits (relative to the largest entry): DM\[Chi] d/d\[Chi]: ", N[digitsRel[DM\[Chi][[1]]], 3], ",  d^2/d\[Chi]^2: ", N[digitsRel[DM\[Chi][[2]]], 3], ",  DMt: ", N[digitsRel[DMt], 3],
  ",  ChebyshevT row at a 40-digit point: ", N[digitsRel[ChebyshevT[Range[0, n\[Chi] - 1], N[37/100, wp]]], 3]];
\[Zeta]B = {0, 1/8, 1/4, 1/2, 1}; nOut = Length[\[Zeta]B] - 1;
\[Zeta]Mid[q1_] := (\[Zeta]B[[q1]] + \[Zeta]B[[q1 + 1]])/2; \[Zeta]H[q1_] := (\[Zeta]B[[q1 + 1]] - \[Zeta]B[[q1]])/2;
\[Zeta]Pan = Table[\[Zeta]Mid[q1] + \[Zeta]H[q1] tP, {q1, nOut}]; rOut = rMax/\[Zeta]Pan;
(* polynomial _{-2}Y_{\[ScriptL]0} (exact) and the symbolic jets of h_mbarmbar, h_mm, h_mmbar *)
yPoly[l_] := yPoly[l] = Module[{p2 = D[LegendreP[l, \[Chi]], {\[Chi], 2}], nrm, sg},
    nrm = Sqrt[2 Pi Integrate[((1 - \[Chi]^2) p2)^2, {\[Chi], -1, 1}]]; sg = Sign[N[Y2[l, 3137/10000]/(((1 - \[Chi]^2) p2) /. \[Chi] -> 3137/10000)]]; Expand[sg (1 - \[Chi]^2) p2/nrm]];
ivRules = {Derivative[n_][iv[k_, l_]][r] :> (-1)^n ivv[k - n, l], iv[k_, l_][r] :> ivv[k, l]};       (* I_k' = -I_{k-1}, I_0 = g *)
kvRules = {Derivative[n_][kv[k_]][r] :> (-1)^n kvv[k - n], kv[k_][r] :> kvv[k]};                    (* K_k' = -K_{k-1}, K_0 = \[Tau] *)
(* h_mbarmbar = \[CapitalSigma]_\[ScriptL] mk_\[ScriptL] \[Times] (one-mode expression): the jets of ONE generic mode (Y, Y', Y'' and {g, I1, I2, I3} as arguments) are compiled once;
   Y_\[ScriptL]0 and its \[Chi]-derivatives are evaluated EXACTLY at the nodes (the expanded degree-\[ScriptL] polynomial loses ~13 digits to cancellation at \[ScriptL] = 36).
   The mode jets at a node are shared by all \[ScriptL]-selections (masks): hmbJetsMasks costs one mode evaluation per node instead of one per mask. *)
modeSym = -2 (r + I a \[Chi])/(r - I a \[Chi])^2 yf[\[Chi]] (2 iv1[3][r] + (r + I a \[Chi]) iv1[2][r]);
modeJetGen = optFun[{r, \[Chi], yv0, yv1, yv2, v4}, (Table[D[modeSym, {r, jt[[1]]}, {\[Chi], jt[[2]]}], {jt, jetList}] /.
       {Derivative[n_][iv1[k_]][r] :> (-1)^n ivv1[k - n], iv1[k_][r] :> ivv1[k]} /. {Derivative[2][yf][\[Chi]] -> yv2, Derivative[1][yf][\[Chi]] -> yv1, yf[\[Chi]] -> yv0} /. a -> aN) /.
     {ivv1[k_] :> Indexed[v4, k + 1]}, N[{37/10, 3/10, 1/3, 1/5, 1/7, {1/2, 1/3, 1/4, 1/5}}, wp]];
yPolyD[l_] := yPolyD[l] = {yPoly[l], D[yPoly[l], \[Chi]], D[yPoly[l], {\[Chi], 2}]};
yAt[c0_] := yAt[c0] = With[{c = SetPrecision[c0, Infinity]}, N[Table[yPolyD[l] /. \[Chi] -> c, {l, lList}], wp]];          (* [[\[ScriptL], derivative]] *)
Scan[yPolyD, lList];
If[useParallel, DistributeDefinitions[yAt]];
tm["_{-2}Y_\[ScriptL]0, \[PartialD]_\[Chi], \[PartialD]_\[Chi]^2 at the \[Chi] nodes (exact evaluation, one node per job)", yNodes = Transpose[pMap[yAt, \[Chi]N], {3, 1, 2}]];          (* [[\[ScriptL], derivative, node]] *)
Do[yAt[\[Chi]N[[k]]] = yNodes[[All, All, k]], {k, n\[Chi]}];
hmbModes[r0_, cv_, vI_] := Module[{ys = If[VectorQ[cv], yNodes, yAt[cv]]}, Table[modeJetGen[r0, cv, ys[[i, 1]], ys[[i, 2]], ys[[i, 3]], vI[[All, i]]], {i, Length[lList]}]];   (* [[\[ScriptL], jet]] *)
hmbJetF[r0_, cv_, vI_, mkv_] := mkv . hmbModes[r0, cv, vI];
hmbJetsMasks[r0_, cv_, vI_, mkvs_] := With[{md = hmbModes[r0, cv, vI]}, (# . md) & /@ mkvs];
hmmSym = -(1 - \[Chi]^2)^m1 PpolyR^2 (kv[2][r] + 2 r/(r^2 + a^2 \[Chi]^2) kv[3][r]);
hmmJetF = optFun[{r, \[Chi], vK}, (Table[D[hmmSym, {r, jt[[1]]}, {\[Chi], jt[[2]]}], {jt, jetList}] /. kvRules /. a -> aN) /. {kvv[k_] :> Indexed[vK, k + 1]}, N[{37/10, 3/10, {1/2, 1/3, 1/4, 1/5}}, wp]];
modeVals[r0_] := Table[IMB[l, k, r0], {k, 0, 3}, {l, lList}];
kVals[r0_] := If[r0 - rpN >= xMax, {0, 0, 0, 0}, Table[KNN[k, r0], {k, 0, 3}]];
ones = ConstantArray[1, Length[lList]];
(* ---------- the reconstruction pass with the inner panels RESIDENT on the subkernels ----------
   Units u = 1..nPan are the inner radial panels, u = nPan + q the outer (\[Zeta]) panels. Unit u is owned by one subkernel (round robin) for the whole pass:
   its node data (mode values {g, I1, I2, I3}, {\[Tau], K1, K2, K3}, f, operator functions), sources, h_lmbar and h_ll stay in that subkernel's memory
   (BCres`kSt[u, ...], a context that is never distributed). Only panel totals of the radial integrals (vectors over \[Chi]), their carries and the outer panels
   travel between the master and the subkernels (each subkernel fetches only its own panels' input data); the full solution (and, for the \[ScriptL]_cut solutions, the test panels) are returned at the end. *)
nmPanel[gs_, mbs_] := Transpose[Table[{TmatAt[nPn] . gs[[i]], Sequence @@ Table[TmatAt[Length[mbs[[i, k]]]] . mbs[[i, k]], {k, 3}]}, {i, Length[gs]}], {3, 2, 1}];
nkPanel[tc_, nd_] := Transpose[{TmatAt[nPn] . tc, Sequence @@ Table[TmatAt[Length[nd[[k]]]] . nd[[k]], {k, 3}]}];
nmOutNode[rr_] := Transpose[Table[tailMB[l, rr], {l, lList}]];
outOps[rr_] := {lmbF[rr, \[Chi]N], llF[rr, \[Chi]N]};
If[useParallel, DistributeDefinitions[nmOutNode, outOps]];
tm["mode values on the outer nodes (closed form, one node per job)", nmOut = Partition[pMap[nmOutNode, Flatten[rOut]], nPn]];
tm["operator functions on the outer nodes (one node per job)", Module[{res = pMap[outOps, Flatten[rOut]]}, lmbOut = Partition[res[[All, 1]], nPn]; llOut = Partition[res[[All, 2]], nPn]]];
S\[Chi] = Transpose[Table[Take[SExAt[c], 2], {c, \[Chi]N}]];
(* \[Chi]-jets of a spin-weight-s field (s = -1: divide by sin\[Theta] first; s = 0: no factor) from node values h and \[PartialD]_r h; returns rows = radial nodes *)
chiJets[h_, hr_, hrr_, sw_] := Module[{q0, qr, d1, d2, dr1, out},
   If[sw == -1,
    q0 = rowTimes[h, 1/s\[Theta]N]; qr = rowTimes[hr, 1/s\[Theta]N];
    d1 = q0 . Transpose[DM\[Chi][[1]]]; d2 = q0 . Transpose[DM\[Chi][[2]]]; dr1 = qr . Transpose[DM\[Chi][[1]]];
    {h, hr, rowTimes[d1, s\[Theta]N] + rowTimes[q0, s\[Theta]D[[2]]], hrr, rowTimes[dr1, s\[Theta]N] + rowTimes[qr, s\[Theta]D[[2]]], rowTimes[d2, s\[Theta]N] + 2 rowTimes[d1, s\[Theta]D[[2]]] + rowTimes[q0, s\[Theta]D[[3]]]},
    {h, hr, h . Transpose[DM\[Chi][[1]]], hrr, hr . Transpose[DM\[Chi][[1]]], h . Transpose[DM\[Chi][[2]]]}]];
(* EJm: E_ab acting on one metric function for SEVERAL jet sets at once (one per \[ScriptL]-selection); the six coefficients come from one optimized function *)
EJm[ab_, fn_, r0_, cv_, jetsL_] := If[KeyExistsQ[coefL, {ab, fn}], With[{cs = coefL[{ab, fn}][r0, cv]}, Table[Total[cs js], {js, jetsL}]], Table[0 cv, {js, jetsL}]];
(* sources F_nmbar and the (T_ln - E_ln[h_mbarmbar, h_mm, h_mmbar]) part of F_ln at one radius, for every mode mask in mkvs.
   Everything is linear in the h_mbarmbar modes, which enter only through the 0/1 weights mkv; T_ab and h_mmbar enter every mask. *)
nodeSrcM[r0_, vI_, vK_, fv_, mkvs_] := Module[{jms = hmbJetsMasks[r0, \[Chi]N, vI, mkvs], jk = hmmJetF[r0, \[Chi]N, vK], tnm, tln, enm, eln, knm, kln},
   {tnm, tln} = If[fv === 0, {0, 0}, TabNL[r0, \[Chi]N, fv[[1]], fv[[2]], S\[Chi][[1]], S\[Chi][[2]]]];
   enm = EJm["nmb", hMbMb, r0, \[Chi]N, jms] + EJm["nmb", hMM, r0, \[Chi]N, Conjugate[jms]];
   eln = EJm["ln", hMbMb, r0, \[Chi]N, jms] + EJm["ln", hMM, r0, \[Chi]N, Conjugate[jms]];
   knm = First[EJm["nmb", hMMb, r0, \[Chi]N, {jk}]]; kln = First[EJm["ln", hMMb, r0, \[Chi]N, {jk}]];
   Table[{tnm - enm[[k]] - knm, tln - eln[[k]] - kln}, {k, Length[mkvs]}]];
(* inward cumulative integral J(r) = \[Integral]_r^\[Infinity] G dr', split: panelPiece = {\[Integral]_t^{right end} at the panel's nodes, \[Integral] over the whole panel} (on the owner);
   the master adds the carries: start[[p]] = \[Integral] from the right end of panel p to \[Infinity] = (outer integral) + \[CapitalSigma]_{p' > p} (panel totals) *)
panelPiece[G_, h_] := Module[{Fc = h chebInt[chebCoef[G]]}, {TmatAt[Length[Fc]] . Fc, chebEvalV[Fc, 1]}];
cumOuter[Gout_] := Module[{carry = 0 Gout[[1, 1]], Jout = ConstantArray[0, nOut], Fc},
   Do[Fc = \[Zeta]H[q1] chebInt[chebCoef[(rMax/\[Zeta]Pan[[q1]]^2) Gout[[q1]]]]; Jout[[q1]] = rowPlus[TmatAt[Length[Fc]] . Fc, carry]; carry = carry + chebEvalV[Fc, 1], {q1, 1, nOut}];
   {Jout, carry}];
startsFrom[carry_, tots_List] := Module[{st = carry, acc = ConstantArray[0, Length[tots]]}, Do[acc[[p]] = st; st = st + tots[[p]], {p, Length[tots], 1, -1}]; acc];
(* phase 1, inner panel: sources [[mask, node, 1|2]] and the J1, J2 panel pieces [[mask, 1|2]] = {matrix at the nodes, panel total} *)
srcInner[p_, mkvs_, nm_, nk_, fv_, lmb_] := Module[{s = Transpose[Table[nodeSrcM[rPan[[p, j]], nm[[j]], nk[[j]], fv[[j]], mkvs], {j, nPn}], {2, 1, 3, 4}]},
   {s, Table[{panelPiece[lmb[[All, 5]] s[[k, All, 1]], panH[p]], panelPiece[lmb[[All, 6]] s[[k, All, 1]], panH[p]]}, {k, Length[mkvs]}]}];
(* phase 1, outer panel: sources [[node, mask, 1|2]] *)
srcOuter[q_, mkvs_] := Table[nodeSrcM[rOut[[q, j]], nmOut[[q, j]], {0, 0, 0, 0}, 0, mkvs], {j, nPn}];
(* F_ln = (T_ln - E_ln[h_mbarmbar, h_mm, h_mmbar]) - E_ln[h_lmbar, h_lm] on the nodes rr, all masks; s2[[mask, node]], jets[[mask, jet, node]] *)
flnNodes[rr_, s2_, jets_] := Transpose[Table[Module[{jl = jets[[All, All, j]], a, b},
     a = EJm["ln", hLMb, rr[[j]], \[Chi]N, jl]; b = EJm["ln", hLM, rr[[j]], \[Chi]N, Conjugate[jl]];
     Table[s2[[k, j]] - a[[k]] - b[[k]], {k, Length[jl]}]], {j, Length[rr]}]];
(* phase 2, inner panel: per mask {h_lmbar, \[PartialD]_r h_lmbar, \[PartialD]_r^2 h_lmbar (from its ODE), J1, J2}, F_ln [[mask]], J_ll panel pieces [[mask]] *)
flnInner[p_, s_, pc_, st_, lmb_, ll_] := Module[{nM1 = Length[s], hs, Fln},
   hs = Table[Module[{J1 = rowPlus[-pc[[k, 1, 1]], st[[k, 1]] + pc[[k, 1, 2]]], J2 = rowPlus[-pc[[k, 2, 1]], st[[k, 2]] + pc[[k, 2, 2]]], hI, hrI},
      hI = -lmb[[All, 2]] J1 + lmb[[All, 1]] J2; hrI = -lmb[[All, 4]] J1 + lmb[[All, 3]] J2;
      {hI, hrI, (s[[k, All, 1]] - lmb[[All, 8]] hrI - lmb[[All, 9]] hI)/lmb[[All, 7]], J1, J2}], {k, nM1}];
   Fln = flnNodes[rPan[[p]], s[[All, All, 2]], Table[chiJets[h[[1]], h[[2]], h[[3]], -1], {h, hs}]];
   {hs, Fln, Table[panelPiece[ll[[All, 1]] Fln[[k]]/ll[[All, 2]], panH[p]], {k, nM1}]}];
(* phase 2, outer panel: F_ln [[mask, node]] from d = {s2[[mask, node]], {h, h_r, h_rr}[[mask]]} *)
flnOuter[q_, d_] := flnNodes[rOut[[q]], d[[1]], Table[chiJets[h[[1]], h[[2]], h[[3]], -1], {h, d[[2]]}]];
(* phase 3, inner panel: per mask {h_ll, \[PartialD]_r h_ll, J_ll} *)
hllInner[Fln_, pcL_, stL_, ll_] := Table[Module[{JL = rowPlus[-pcL[[k, 1]], stL[[k]] + pcL[[k, 2]]], hll},
     hll = -JL/ll[[All, 1]]; {hll, (Fln[[k]] - ll[[All, 3]] hll)/ll[[All, 2]], JL}], {k, Length[Fln]}];

(* the full solution and the solutions with \[ScriptL] <= each \[ScriptL]_cut (\[ScriptL]-convergence study of 11f), all in one pass *)
eePan = DeleteDuplicates[panelIndex /@ {10^-3, 3/10, 1, 2, 8, 40, 200, 1000}];          (* test panels of the Einstein residuals (11e) *)
hPtsR = {rpN + 1/1000, 2, 3, 6, 20, 150};                                                (* radii of the \[ScriptL]-convergence samples (11f (c)) *)
keepP = Union[eePan, panelIndex /@ (hPtsR - rpN), {1, nPan}];                             (* panels whose \[ScriptL]_cut solutions are returned to the master *)
lUses = Range[2, #] & /@ Prepend[lCuts, lmax];
mkvs = Table[Table[If[MemberQ[lUse, l], 1, 0], {l, lList}], {lUse, lUses}]; nM = Length[mkvs];
nU = nPan + nOut;
kIDs = If[useParallel, ParallelEvaluate[$KernelID], {0}];
If[useParallel,
  DistributeDefinitions[nmPanel, nkPanel, srcInner, srcOuter, flnInner, flnOuter, hllInner, lmbF, llF, nmOut, rOut, rPan, panH, nPan, nPn, nOut, lList, \[Chi]N, S\[Chi]];
  With[{ids = kIDs, nu = nU}, ParallelEvaluate[Clear[BCres`kSt]; BCres`myUnits = Range[First[FirstPosition[ids, $KernelID]], nu, Length[ids]]]];
  SetSharedFunction[BCres`getU],
  Clear[BCres`kSt]; BCres`myUnits = Range[nU]];
log["reconstruction: ", nPan, " inner + ", nOut, " outer panels (", nU nPn, " x ", n\[Chi], " nodes) on ", Length[kIDs], " kernel(s), at most ", Ceiling[nU/Length[kIDs]],
  " panels each; \[ScriptL]-selections \[ScriptL] <= ", Append[lCuts, lmax]];
(* phase 0: each subkernel fetches the panel series of its own panels only (g_\[ScriptL], I_1..3 of every \[ScriptL], \[Tau], K_1..3, f-jets) *)
BCres`getU[u_] := If[u <= nPan, {Table[gC[l][[u]], {l, lList}], Table[mbData[l][[u]], {l, lList}], \[Tau]C[[u]], nnData[[u]], fP[[u]]}, Null];
tm["node data on the owning subkernels: mode values, \[Tau], f, operator functions",
  rEval[Scan[Function[u, If[u <= nPan, With[{d = BCres`getU[u]},
      BCres`kSt[u, "nm"] = nmPanel[d[[1]], d[[2]]];
      BCres`kSt[u, "nk"] = nkPanel[d[[3]], d[[4]]]; BCres`kSt[u, "f"] = Map[Take[#, 2] &, d[[5]]];
      BCres`kSt[u, "lmb"] = Table[lmbF[rr, \[Chi]N], {rr, rPan[[u]]}]; BCres`kSt[u, "ll"] = Table[llF[rr, \[Chi]N], {rr, rPan[[u]]}]]]], BCres`myUnits]]];
tm["phase 1: sources F_nmbar, F_ln and the J1, J2 panel pieces (owning subkernels)",
  res1 = With[{m = mkvs}, Flatten[rEval[Table[If[u <= nPan,
        Module[{o = srcInner[u, m, BCres`kSt[u, "nm"], BCres`kSt[u, "nk"], BCres`kSt[u, "f"], BCres`kSt[u, "lmb"]]},
         BCres`kSt[u, "s"] = o[[1]]; BCres`kSt[u, "pc"] = o[[2]]; {u, o[[2, All, All, 2]]}],
        {u, srcOuter[u - nPan, m]}], {u, BCres`myUnits}]], 1]]];
tm["J1, J2: outer panels and carries (master; outer integrals one per job)",
  tot1 = Association[Cases[res1, {u_Integer, t_} /; u <= nPan :> (u -> t)]];          (* u -> [[mask, 1|2]] panel totals *)
  If[Sort[Keys[tot1]] =!= Range[nPan] || Sort[Cases[res1[[All, 1]], u_ /; u > nPan]] =!= Range[nPan + 1, nU], log["ERROR: phase 1 returned units ", Sort[res1[[All, 1]]]]; Exit[1]];
  sOutAll = Table[First[Cases[res1, {nPan + q, t_} :> t]], {q, nOut}];                (* [[q, node, mask, 1|2]] *)
  Fo = Table[sOutAll[[All, All, k, 1]], {k, nM}];
  oJ = pMap[cumOuter, Join[Table[lmbOut[[All, All, 5]] Fo[[k]], {k, nM}], Table[lmbOut[[All, All, 6]] Fo[[k]], {k, nM}]]];      (* {Jout, carry}: J1 masks, then J2 masks *)
  startJ = Table[startsFrom[{oJ[[k, 2]], oJ[[nM + k, 2]]}, Table[tot1[p][[k]], {p, nPan}]], {k, nM}];                            (* [[mask, p]] = {start J1, start J2} *)
  outH = Table[Module[{J1o = oJ[[k, 1]], J2o = oJ[[nM + k, 1]], hO, hrO},
     hO = -lmbOut[[All, All, 2]] J1o + lmbOut[[All, All, 1]] J2o; hrO = -lmbOut[[All, All, 4]] J1o + lmbOut[[All, All, 3]] J2o;
     {hO, hrO, (Fo[[k]] - lmbOut[[All, All, 8]] hrO - lmbOut[[All, All, 9]] hO)/lmbOut[[All, All, 7]]}], {k, nM}]];
(* data a subkernel fetches for its unit (shared function: evaluated on the master, only that unit's slice is transferred) *)
BCres`getU[u_] := If[u <= nPan, startJ[[All, u]], {Transpose[sOutAll[[u - nPan, All, All, 2]]], Table[outH[[k, All, u - nPan]], {k, nM}]}];
tm["phase 2: h_lmbar, its \[Chi]-jets, F_ln and the J_ll panel pieces (owning subkernels)",
  res2 = Flatten[rEval[Table[If[u <= nPan,
        Module[{o = flnInner[u, BCres`kSt[u, "s"], BCres`kSt[u, "pc"], BCres`getU[u], BCres`kSt[u, "lmb"], BCres`kSt[u, "ll"]]},
         BCres`kSt[u, "h"] = o[[1]]; BCres`kSt[u, "Fln"] = o[[2]]; BCres`kSt[u, "pcL"] = o[[3]]; BCres`kSt[u, "s"] =.; BCres`kSt[u, "pc"] =.; {u, o[[3, All, 2]]}],
        {u, flnOuter[u - nPan, BCres`getU[u]]}], {u, BCres`myUnits}]], 1]];
tm["J_ll: outer panels and carries (master; outer integrals one per job)",
  totL = Association[Cases[res2, {u_Integer, t_} /; u <= nPan :> (u -> t)]];          (* u -> [[mask]] panel totals *)
  If[Sort[Keys[totL]] =!= Range[nPan] || Sort[Cases[res2[[All, 1]], u_ /; u > nPan]] =!= Range[nPan + 1, nU], log["ERROR: phase 2 returned units ", Sort[res2[[All, 1]]]]; Exit[1]];
  FlnO = Table[First[Cases[res2, {nPan + q, t_} :> t]], {q, nOut}];                   (* [[q, mask, node]] *)
  oL = pMap[cumOuter, Table[llOut[[All, All, 1]] FlnO[[All, k]]/llOut[[All, All, 2]], {k, nM}]];
  startL = Table[startsFrom[oL[[k, 2]], Table[totL[p][[k]], {p, nPan}]], {k, nM}];
  outL = Table[Module[{hllO = -oL[[k, 1]]/llOut[[All, All, 1]]}, {hllO, (FlnO[[All, k]] - llOut[[All, All, 3]] hllO)/llOut[[All, All, 2]]}], {k, nM}]];
BCres`getU[u_] := startL[[All, u]];
tm["phase 3: J_ll, h_ll (owning subkernels); node values to the master",
  res3 = With[{kp = keepP, ep = eePan}, Flatten[rEval[Table[Module[{h = BCres`kSt[u, "h"], o},
        o = hllInner[BCres`kSt[u, "Fln"], BCres`kSt[u, "pcL"], BCres`getU[u], BCres`kSt[u, "ll"]];
        {u, h[[1, 1]], h[[1, 2]], o[[1, 1]], o[[1, 2]],
         If[MemberQ[kp, u], Table[{h[[k, 1]], o[[k, 1]]}, {k, Length[h]}], Null],
         If[u == 1 || u == nPan, {h[[1, 4]], h[[1, 5]], o[[1, 3]]}, Null],
         If[MemberQ[ep, u], {BCres`kSt[u, "nm"], BCres`kSt[u, "nk"], BCres`kSt[u, "f"]}, Null]}],
       {u, Select[BCres`myUnits, # <= nPan &]}]], 1]];
  res3 = SortBy[res3, First];
  If[res3[[All, 1]] =!= Range[nPan], log["ERROR: the subkernels returned panels ", res3[[All, 1]], " instead of 1..", nPan]; Exit[1]]];
rEval[Clear[BCres`kSt]];
(* solution k: the full solution (k = 1) has every panel; the \[ScriptL]_cut solutions keep the panels keepP (11e, 11f) *)
jInF[i_, k_] := If[k == 1, Table[If[p == 1 || p == nPan, res3[[p, 7, i]], Missing["not kept"]], {p, nPan}], Missing["not kept"]];
cutF[i_, k_] := Table[If[MemberQ[keepP, p], res3[[p, 6, k, i]], Missing["not kept"]], {p, nPan}];
reconAll = Table[<|"lUse" -> lUses[[k]], "mkv" -> mkvs[[k]],
    "hlmbIn" -> If[k == 1, res3[[All, 2]], cutF[1, k]], "hlmbrIn" -> If[k == 1, res3[[All, 3]], Missing["not kept"]],
    "hllIn" -> If[k == 1, res3[[All, 4]], cutF[2, k]], "hllrIn" -> If[k == 1, res3[[All, 5]], Missing["not kept"]],
    "hlmbOut" -> outH[[k, 1]], "hlmbrOut" -> outH[[k, 2]], "hllOut" -> outL[[k, 1]], "hllrOut" -> outL[[k, 2]],
    "FnmbIn" -> Missing["kept on the subkernels"], "FnmbOut" -> Fo[[k]], "FlnIn" -> Missing["kept on the subkernels"], "FlnOut" -> FlnO[[All, k]],
    "J1" -> {jInF[1, k], oJ[[k, 1]]}, "J2" -> {jInF[2, k], oJ[[nM + k, 1]]}, "JL" -> {jInF[3, k], oL[[k, 1]]}|>, {k, nM}];
eeNodeData = Association[Table[p -> res3[[p, 8]], {p, eePan}]];          (* {mode values, \[Tau] values, f} at the nodes of the test panels *)
recon = First[reconAll]; reconCut = AssociationThread[lCuts, Rest[reconAll]];

(* ==================================================================================================== *)
stage["15. h_ll interpolation and values"];
(* interpolation of the node values: 2D Chebyshev on a radial panel (inner: t; outer: \[Zeta]) x \[Chi]; spin weight -1 fields are interpolated as h/sin\[Theta] *)
interp2[V_, t0_, c0_, sw_] := Module[{Q = If[sw == -1, rowTimes[V, 1/s\[Theta]N], V], C2},
   C2 = chebMat[nPn] . Q . Transpose[chebMat[n\[Chi]]];
   (ChebyshevT[Range[0, nPn - 1], t0] . C2 . ChebyshevT[Range[0, n\[Chi] - 1], c0]) If[sw == -1, Sqrt[1 - c0^2], 1]];
hAt[res_, comp_, r0_, c0_] := Module[{xx = r0 - rpN, sw = If[comp === "hlmb", -1, 0], p, q1, \[Zeta]0},
   If[xx < xMax, p = panelIndex[xx]; interp2[res[comp <> "In"][[p]], (xx - panMid[p])/panH[p], c0, sw],
    \[Zeta]0 = rMax/r0; q1 = Min[nOut, Max[1, LengthWhile[\[Zeta]B, # <= \[Zeta]0 &]]]; interp2[res[comp <> "Out"][[q1]], (\[Zeta]0 - \[Zeta]Mid[q1])/\[Zeta]H[q1], c0, sw]]];
hLMbAt[r0_?NumericQ, c0_?NumericQ] := hAt[recon, "hlmb", r0, c0];
hLLAt[r0_?NumericQ, c0_?NumericQ] := hAt[recon, "hll", r0, c0];
printGrid[Grid[Prepend[Table[{N[r0, 6], N[hLMbAt[r0, 21/100], 12], N[hLLAt[r0, 21/100], 12]}, {r0, {rpN, rpN + 1/1000, 2, 4, 15, 100, 1000, 10^4}}], {"r (\[Chi] = 0.21)", "h_lmbar", "h_ll"}], Frame -> All]];

(* ==================================================================================================== *)
stage["16. Error monitoring for h_lmbar and h_ll; all ten Einstein equations"];
(* 11a. direct NIntegrate of the Green formula for h_lmbar at OFF-GRID points (r, \[Chi] = 0.21): independent of the panel/\[Zeta] integration and of the 2D interpolation *)
FnmPoint[r0_?NumericQ, c0_] := FnmPoint[r0, c0] = Module[{jm = hmbJetF[r0, c0, modeVals[r0], ones], jk = hmmJetF[r0, c0, kVals[r0]], tnm},
    tnm = If[r0 - rpN >= xMax, 0, TabAtF["nmb", r0, c0]];
    tnm - EJ["nmb", hMbMb, r0, c0, jm] - EJ["nmb", hMM, r0, c0, Conjugate[jm]] - EJ["nmb", hMMb, r0, c0, jk]];
(* the Green formula split into its sub-intervals: jobs (point, J1|J2, sub-interval) *)
hLMbSeg[{c0_, k_, lo_, hi_}] := NIntegrate[lmbF[s, c0][[4 + k]] FnmPoint[s, c0], {s, lo, hi}, WorkingPrecision -> 30, PrecisionGoal -> 18, MaxRecursion -> 30];
If[useParallel, DistributeDefinitions[hLMbSeg]];
Module[{pts = {rpN + 1/10, 5/2, 7, 40}, segs, vals, pos = 0, ii, dir},
  segs = Table[Append[Partition[Join[{r0}, Select[Join[{3, 6, 20, 100, 400}, farPts], r0 < # < rMax &], {Max[rMax, r0 + 1]}], 2, 1], {Max[rMax, r0 + 1], Infinity}], {r0, pts}];
  vals = pMap[hLMbSeg, Flatten[Table[{21/100, k, sg[[1]], sg[[2]]}, {i, Length[pts]}, {k, 1, 2}, {sg, segs[[i]]}], 2]];
  dir = Table[ii = Table[With[{n = Length[segs[[i]]]}, pos += n; Total[vals[[pos - n + 1 ;; pos]]]], {k, 1, 2}];
    Module[{uu = lmbF[pts[[i]], 21/100]}, -uu[[2]] ii[[1]] + uu[[1]] ii[[2]]], {i, Length[pts]}];
  Do[check["11: h_lmbar grid + interpolation vs direct NIntegrate of the Green formula at (r, \[Chi]) = (" <> numStr[N[pts[[k]], 5]] <> ", 0.21)", relErr[hLMbAt[pts[[k]], 21/100], dir[[k]]], 10^-14], {k, Length[pts]}]];
(* 11b. convergence of the improper integrals: local exponents of the integrands at large r (convergence needs < -1) and the share of J from r > r+ + xMax *)
Module[{k0 = First[Ordering[Abs[\[Chi]N - 21/100], 1]], gexp},
  gexp = Table[N[localExp[Function[rr, Abs[lmbF[rr, \[Chi]N[[k0]]][[4 + k]] FnmPoint[rr, \[Chi]N[[k0]]]]], rFar], 6], {k, 1, 2}];
  log["\[Chi] = ", N[\[Chi]N[[k0]], 4], ":  d ln|integrand of J1|/d ln r at r = ", rFar, ": ", gexp[[1]], ",  of J2: ", gexp[[2]]];
  check["11: J1, J2 integrands decay faster than 1/r at r = rFar = max(10^6, 100 rMax) (convergent at infinity)", Max[gexp] + 1, 0];
  log["share of J1, J2, J_ll(r+) coming from r > r+ + xMax: ", sci[{Abs[recon["J1"][[1, nPan, 1, k0]]/recon["J1"][[1, 1, nPn, k0]]], Abs[recon["J2"][[1, nPan, 1, k0]]/recon["J2"][[1, 1, nPn, k0]]], Abs[recon["JL"][[1, nPan, 1, k0]]/recon["JL"][[1, 1, nPn, k0]]]}, 3]];
  log["\[Zeta]-panel integrands near \[Zeta] = 0 (finite => integrable): ", sci[{Abs[(rMax/\[Zeta]Pan[[1, nPn]]^2) lmbOut[[1, nPn, 6, k0]] recon["FnmbOut"][[1, nPn, k0]]], Abs[(rMax/\[Zeta]Pan[[1, nPn]]^2) llOut[[1, nPn, 1, k0]] recon["FlnOut"][[1, nPn, k0]]/llOut[[1, nPn, 2, k0]]]}, 3]]];
(* 11c. resolution: Chebyshev tails in \[Chi] (of h_lmbar/sin\[Theta], h_ll) and in r (per panel) *)
Module[{c\[Chi], cr},
  c\[Chi] = Max[Flatten[Table[Module[{cc = chebMat[n\[Chi]] . (recon[comp <> "In"][[p, j]]/If[comp === "hlmb", s\[Theta]N, 1])}, Max[Abs[Take[cc, -2]]]/Max[Abs[cc]]], {comp, {"hlmb", "hll"}}, {p, {1, 30, 60, 100, nPan}}, {j, {1, 12}}]]];
  cr = Max[Flatten[Table[Module[{cc = chebMat[nPn] . recon[comp <> "In"][[p, All, k]]}, Abs[Last[cc]]/Max[Abs[cc]]], {comp, {"hlmb", "hll"}}, {p, Range[1, nPan, 10]}, {k, {1, 20}}]]];
  log["max |last 2 \[Chi]-Chebyshev coefficients|/max: ", sci[c\[Chi], 3], ";   max |last r-Chebyshev coefficient|/max (panels): ", sci[cr, 3]];
  check["11: \[Chi] resolution of h_lmbar/sin\[Theta] and h_ll", c\[Chi], 10^-15];
  check["11: radial panel resolution of h_lmbar and h_ll", cr, 10^-15]];
(* 11d. reality and equatorial reflection on the nodes: h_ll real, h_ll(-\[Chi]) = h_ll(\[Chi]), h_lmbar(-\[Chi]) = -conj h_lmbar(\[Chi]) *)
(* 11e. all ten Einstein equations on the nodes of selected panels (eePan, section 14), for several solutions at once.
   Jets: h_mbarmbar, h_mmbar analytic; h_lmbar, h_ll from spectral differentiation of their node values in r (panel) and \[Chi] (not from the ODEs, so nn, nmbar, ln are
   non-trivial tests). Relative residual = |\[Delta]G_ab[h] - T_ab| / (|T_ab| + \[CapitalSigma]_components |E_ab[h_c]|), per node, max over \[Chi].
   Jobs: (i) the jets of h_lmbar, h_ll per (panel, solution); (ii) the residuals per (panel, node), all components and solutions at once. *)
eeDMr[region_, idx_] := If[region === "in", DMt/panH[idx], (-\[Zeta]Pan[[idx]]^2/(rMax \[Zeta]H[idx])) DMt];      (* d/dr = -(\[Zeta]^2/rMax) d/d\[Zeta] on the outer panels *)
eePrep[{hl_, hll_, DMr_}] := Module[{hlr = DMr . hl, hllr = DMr . hll}, {chiJets[hl, hlr, DMr . hlr, -1], chiJets[hll, hllr, DMr . hllr, 0]}];
(* one node: r0, mode values vI, \[Tau] values vK, f-jets fv (0 beyond rMax), jets jl[[solution, jet]], jll[[solution, jet]], masks; result [[component, solution]] *)
eeNode[{r0_, vI_, vK_, fv_, jl_, jll_, mks_}] := Module[{jk = hmmJetF[r0, \[Chi]N, vK], md = hmbModes[r0, \[Chi]N, vI], tvAll, jetsL, nS = Length[mks]},
   jetsL = Table[Module[{jm = mks[[s1]] . md}, <|hLL -> jll[[s1]], hLM -> Conjugate[jl[[s1]]], hLMb -> jl[[s1]], hMM -> Conjugate[jm], hMbMb -> jm, hMMb -> jk|>], {s1, nS}];
   tvAll = If[fv === 0, ConstantArray[0 \[Chi]N, Length[projList]], TabFL[r0, \[Chi]N, fv[[1]], fv[[2]], S\[Chi][[1]], S\[Chi][[2]]]];
   Table[Module[{tv = tvAll[[iab]], terms},
     terms = Transpose[Table[EJm[projList[[iab, 1]], fn, r0, \[Chi]N, Table[jets[fn], {jets, jetsL}]], {fn, hNames}]];      (* [[solution, function]] *)
     Table[Max[Abs[Total[terms[[s1]]] - tv]/(Abs[tv] + Total[Abs[terms[[s1]]]] + 10^-300)], {s1, nS}]], {iab, Length[projList]}]];
If[useParallel, DistributeDefinitions[eePrep, eeNode]];
tm["Einstein residuals on the test panels (jets: one (panel, solution) per job; residuals: one node per job)",
  Module[{tests, prep, pos = 0, nodeJobs, nodeRes, perTest},
   (* tests: {region, panel, solutions}: the inner test panels with every solution, the outer panels 2 and nOut with the full solution *)
   tests = Join[Table[{"in", p, reconAll}, {p, eePan}], Table[{"out", q, {First[reconAll]}}, {q, {2, nOut}}]];
   prep = pMap[eePrep, Flatten[Table[Table[{res[If[t[[1]] === "in", "hlmbIn", "hlmbOut"]][[t[[2]]]], res[If[t[[1]] === "in", "hllIn", "hllOut"]][[t[[2]]]], eeDMr[t[[1]], t[[2]]]},
       {res, t[[3]]}], {t, tests}], 1]];
   prep = Table[With[{n = Length[t[[3]]]}, pos += n; prep[[pos - n + 1 ;; pos]]], {t, tests}];          (* [[test, solution]] = {jets of h_lmbar, jets of h_ll} *)
   nodeJobs = Flatten[Table[With[{t = tests[[it]], pr = prep[[it]]}, Table[
       If[t[[1]] === "in",
        {rPan[[t[[2]], j]], eeNodeData[t[[2]]][[1, j]], eeNodeData[t[[2]]][[2, j]], eeNodeData[t[[2]]][[3, j]]},
        {rOut[[t[[2]], j]], nmOut[[t[[2]], j]], {0, 0, 0, 0}, 0}] ~ Join ~ {pr[[All, 1, All, j]], pr[[All, 2, All, j]], #["mkv"] & /@ t[[3]]}, {j, nPn}]], {it, Length[tests]}], 1];
   nodeRes = pMap[eeNode, nodeJobs];                                                      (* [[test node, component, solution]] *)
   perTest = Table[With[{arr = nodeRes[[(it - 1) nPn + 1 ;; it nPn]]}, Table[Max[arr[[All, c, s1]]], {s1, Length[tests[[it, 3]]]}, {c, Length[projList]}]], {it, Length[tests]}];   (* [[test, solution, component]] *)
   eeTab = perTest[[1 ;; Length[eePan], 1]];
   eeCut = AssociationThread[lCuts, Table[perTest[[1 ;; Length[eePan], k + 1]], {k, Length[lCuts]}]];
   eeTabOut = perTest[[Length[eePan] + 1 ;;, 1]]]];
log["significant digits of the node values and jets (relative to the largest entry), first test panel: h_lmbar ", N[digitsRel[recon["hlmbIn"][[eePan[[1]]]]], 3],
  ", h_ll ", N[digitsRel[recon["hllIn"][[eePan[[1]]]]], 3], ", \[PartialD]_\[Chi]^2 h_lmbar ", N[digitsRel[chiJets[recon["hlmbIn"][[eePan[[1]]]], recon["hlmbIn"][[eePan[[1]]]], recon["hlmbIn"][[eePan[[1]]]], -1][[6]]], 3]];
check["11: residual table is finite (no Indeterminate / ComplexInfinity from precision loss)", Count[Flatten[eeTab], Indeterminate | ComplexInfinity | DirectedInfinity[_]], 1/2];
printGrid[Grid[Prepend[Join[Table[{"r - r+ in [" <> numStr[N[xB[[eePan[[i]]]], 3]] <> ", " <> numStr[N[xB[[eePan[[i]] + 1]], 3]] <> "]", Sequence @@ (sci[#, 2] & /@ eeTab[[i]])}, {i, Length[eePan]}],
     Table[{"\[Zeta]-panel " <> ToString[{2, nOut}[[i]]] <> " (r > rMax)", Sequence @@ (sci[#, 2] & /@ eeTabOut[[i]])}, {i, 2}]], Prepend[projList[[All, 1]], "region"]], Frame -> All]];
check["11: solved equations E_nn, E_nmbar, E_ln = T on all test panels (incl. r > rMax; value + significance-arithmetic uncertainty)", maxB[Join[eeTab, eeTabOut][[All, 1 ;; 3]]], 10^-12];
log["The remaining components (ll, lmbar, mmbar, mbarmbar) are not solved directly; they hold by the Wald and Bianchi identities up to (i) the \[ScriptL]-truncation of \[CapitalPsi]4 (O4 \[CapitalPsi]4 = S4T only up to the \[ScriptL] > lmax part, section G3 of the \[CapitalPsi]4 notebook) and (ii) the KG residual of the cloud (section 8)."];
(* 11f. \[ScriptL]-convergence: the solutions for \[ScriptL] <= \[ScriptL]_cut (\[ScriptL]_cut = lCuts, computed in the same pass as the full solution) compared with \[ScriptL]_cut = lmax.
   (a) Teukolsky: |O4 \[CapitalPsi]4(\[ScriptL] <= \[ScriptL]_cut) - S4T|/|S4T|, the pure \[ScriptL]-truncation error of \[CapitalPsi]4 (exact source; no remainder added);
   (b) Einstein: residuals of the four components not solved directly (ll, lmbar, mmbar, mbarmbar), max over the test panels with r < 4 and over all test panels;
   (c) the metric: |h(\[ScriptL]_cut) - h(lmax)|/|h(lmax)| for h_mbarmbar, h_lmbar, h_ll at sample points (h_mmbar does not depend on \[ScriptL]). *)
(* all numbers below are |value| + its significance-arithmetic uncertainty: a quantity that has reached the precision floor shows that floor, not 0 *)
bndF[x_] := Abs[x] + If[NumberQ[x] && ! MemberQ[{Infinity, MachinePrecision}, Precision[x]], 10^-Accuracy[x], 0];
If[doLConv,
  Module[{Ls = Append[lCuts, lmax], tabs, near, teukPts, o4cum, teuk, hPts, hval, hchg, comps = {"ll", "lmbar", "mmbar", "mbarmbar"}},
   (* (a) *)
   teukPts = {{2, 21/100}, {3, 21/100}, {6, 7/10}, {15, 21/100}};
   o4cum = Accumulate /@ Partition[pMap[Function[pl, O4fun[pl[[1, 1]], pl[[1, 2]], Sequence @@ RpDer[pl[[2]], pl[[1, 1]]], Sequence @@ N[Y2D[pl[[2]], pl[[1, 2]]], wp]]], Tuples[{teukPts, lList}]], Length[lList]];      (* one (point, \[ScriptL]) per job *)
   teuk = Table[bndF[relErr[o4cum[[i, L - 1]], S4Tex[Sequence @@ teukPts[[i]]]]], {L, Ls}, {i, Length[teukPts]}];
   log["(a) Teukolsky \[ScriptL]-truncation error |O4\[CapitalPsi]4(\[ScriptL] <= \[ScriptL]_cut) - S4T|/|S4T| at (r, \[Chi]) = ", teukPts];
   printGrid[Grid[Prepend[Table[{Ls[[k]], Sequence @@ (sci[#, 2] & /@ teuk[[k]])}, {k, Length[Ls]}], Prepend[ToString /@ teukPts[[All, 1]], "\[ScriptL]_cut \\ r"]]]];
   (* (b) *)
   tabs = Map[bndF, Append[Values[eeCut], eeTab], {3}];                    (* [[cut, panel, component]]; value + significance uncertainty *)
   near = Select[Range[Length[eePan]], rPan[[eePan[[#]], 1]] < 4 &];
   log["(b) Einstein residuals of the components not solved directly, max over the test panels with r < 4 | over all test panels:"];
   printGrid[Grid[Prepend[Table[{Ls[[k]], Sequence @@ Table[sci[Max[tabs[[k, near, c]]], 2] <> " | " <> sci[Max[tabs[[k, All, c]]], 2], {c, 4, 7}]}, {k, Length[Ls]}], Prepend[comps, "\[ScriptL]_cut"]]]];
   log["    E_mbarmbar residual per test panel (columns: \[ScriptL]_cut = ", Ls, "):"];
   printGrid[Grid[Table[{"r - r+ in [" <> numStr[N[xB[[eePan[[i]]]], 3]] <> ", " <> numStr[N[xB[[eePan[[i]] + 1]], 3]] <> "]", Sequence @@ Table[sci[tabs[[k, i, 7]], 2], {k, Length[Ls]}]}, {i, Length[eePan]}]]];
   check["11: E_mbarmbar residual non-increasing with \[ScriptL]_cut (test panels with r < 4; up to 1%, the KG floor of section 13 may be reached)",
     Max[Table[Max[tabs[[k + 1, near, 7]]/tabs[[k, near, 7]]], {k, Length[Ls] - 1}]], 101/100];
   (* (c) *)
   hPts = Transpose[{hPtsR, {21/100, 21/100, -1/2, 7/10, 21/100, 1/3}}];          (* radii hPtsR: their panels are kept for every \[ScriptL]_cut (section 14) *)
   hval[L_, pt_] := Module[{rc = If[L == lmax, recon, reconCut[L]]},
      {Sum[hMBmode[l, pt[[1]], pt[[2]]], {l, 2, L}], hAt[rc, "hlmb", pt[[1]], pt[[2]]], hAt[rc, "hll", pt[[1]], pt[[2]]]}];
   hchg = Module[{ref = Table[hval[lmax, pt], {pt, hPts}]}, Table[Table[bndF[relErr[hval[L, hPts[[i]]][[c]], ref[[i, c]]]], {c, 3}, {i, Length[hPts]}], {L, lCuts}]];   (* [[cut, comp, point]] *)
   log["(c) |h(\[ScriptL]_cut) - h(lmax)|/|h(lmax)| at (r, \[Chi]) = ", hPts];
   Do[log["    ", {"h_mbarmbar", "h_lmbar", "h_ll"}[[c]], ":"];
     printGrid[Grid[Prepend[Table[{lCuts[[k]], Sequence @@ (sci[#, 2] & /@ hchg[[k, c]])}, {k, Length[lCuts]}], Prepend[numStr[N[#[[1]], 4]] & /@ hPts, "\[ScriptL]_cut \\ r"]]]], {c, 3}];
   (* successive change |h(\[ScriptL]_cut,k) - h(\[ScriptL]_cut,k-1)| / |h(lmax)| (rows 2..; for the lmax row this is the change from the last cut, i.e. an estimate of the
      truncation error of the full solution; |h(\[ScriptL]_cut) - h(lmax)| is identically 0 on that row and is written NA) *)
   hstep = Module[{hv = Table[hval[L, pt], {L, Ls}, {pt, hPts}]},          (* [[cut, point, comp]] *)
     Table[If[k == 1, Missing["first cut"], Table[Table[bndF[(hv[[k, i, c]] - hv[[k - 1, i, c]])/hv[[-1, i, c]]], {i, Length[hPts]}], {c, 3}]], {k, Length[Ls]}]];   (* [[cut, comp, point]] *)
   log["(c') successive change |h(\[ScriptL]_cut) - h(previous \[ScriptL]_cut)|/|h(lmax)|, max over the points, (h_mbarmbar, h_lmbar, h_ll): ",
     Table[{Ls[[k]], If[k == 1, "-", sci[Max /@ hstep[[k]], 2]]}, {k, Length[Ls]}]];
   lConv = <|"lCut" -> Ls, "teukolskyPoints" -> teukPts, "teukolskyTruncation" -> teuk,
     "einsteinPanels" -> eePan, "einsteinComponents" -> projList[[All, 1]], "einsteinResiduals" -> tabs,
     "hPoints" -> hPts, "hComponents" -> {"hmbmb", "hlmb", "hll"}, "hChangeVsLmax" -> hchg, "hChangeStep" -> hstep|>;
   (* plain table for plotting: one row per \[ScriptL]_cut; numbers unquoted (machine reals, e-notation), NA where a column does not apply *)
   writeTSV[FileNameJoin[{outDir, "l_convergence.tsv"}], Prepend[Table[Join[{Ls[[k]]}, N[Abs[teuk[[k]]]], Table[N[Max[tabs[[k, near, c]]]], {c, 4, 7}],
        If[Ls[[k]] == lmax, ConstantArray["NA", 3], N[Max /@ hchg[[k]]]], If[k == 1, ConstantArray["NA", 3], N[Max /@ hstep[[k]]]]], {k, Length[Ls]}],
      Join[{"l_cut"}, ("teuk_r=" <> ToString[#[[1]]]) & /@ teukPts, ("EE_" <> # <> "_r<4") & /@ comps,
       {"dh_mbmb_vs_lmax", "dh_lmb_vs_lmax", "dh_ll_vs_lmax", "dh_mbmb_step", "dh_lmb_step", "dh_ll_step"}]]];
   log["written ", FileNameJoin[{outDir, "l_convergence.tsv"}]]]];
(* ---------- diagnostics: Einstein residuals of the full solution at every node of the panels diagPan and of all outer panels ----------
   per node and \[Chi]: |\[Delta]G_ab[h] - T_ab| and the scale |T_ab| + \[CapitalSigma]_c |E_ab[h_c]| (relative residual = ratio), all seven components *)
diagPan = Union[eePan, Range[1, nPan, diagStride]];
eeNodeV[{r0_, fv_, jl_, jll_}] := Module[{jk = hmmJetF[r0, \[Chi]N, kVals[r0]], jm = hmbJetF[r0, \[Chi]N, modeVals[r0], ones], jets, tvAll},
   jets = <|hLL -> jll, hLM -> Conjugate[jl], hLMb -> jl, hMM -> Conjugate[jm], hMbMb -> jm, hMMb -> jk|>;
   tvAll = If[fv === 0, ConstantArray[0 \[Chi]N, Length[projList]], TabFL[r0, \[Chi]N, fv[[1]], fv[[2]], S\[Chi][[1]], S\[Chi][[2]]]];
   Table[Module[{terms = Table[First[EJm[projList[[iab, 1]], fn, r0, \[Chi]N, {jets[fn]}]], {fn, hNames}]},
     {Abs[Total[terms] - tvAll[[iab]]], Abs[tvAll[[iab]]] + Total[Abs[terms]]}], {iab, Length[projList]}]];          (* [[component, {|residual|, scale}, \[Chi]]] *)
If[useParallel, DistributeDefinitions[eeNodeV]];
tm["diagnostics: Einstein residuals of the full solution at every node of " <> ToString[Length[diagPan]] <> " inner and " <> ToString[nOut] <> " outer panels (one node per job)",
  Module[{tests, prep, jobs, res},
   tests = Join[Table[{"in", p}, {p, diagPan}], Table[{"out", q}, {q, nOut}]];
   prep = pMap[eePrep, Table[{recon[If[t[[1]] === "in", "hlmbIn", "hlmbOut"]][[t[[2]]]], recon[If[t[[1]] === "in", "hllIn", "hllOut"]][[t[[2]]]], eeDMr[t[[1]], t[[2]]]}, {t, tests}]];
   jobs = Flatten[Table[With[{t = tests[[it]], pr = prep[[it]]}, Table[{If[t[[1]] === "in", rPan[[t[[2]], j]], rOut[[t[[2]], j]]],
        If[t[[1]] === "in", Take[fP[[t[[2]], j]], 2], 0], pr[[1, All, j]], pr[[2, All, j]]}, {j, nPn}]], {it, Length[tests]}], 1];
   res = Map[bndS, pMap[eeNodeV, jobs], {-1}];
   diag["einsteinNodes"] = <|"components" -> projList[[All, 1]], "units" -> tests, "r" -> jobs[[All, 1]], "chi" -> \[Chi]N,
     "absResidual" -> res[[All, All, 1]], "scale" -> res[[All, All, 2]]|>]];          (* arrays [[node, component, \[Chi]]]; nodes ordered unit by unit, nPn per unit *)
(* 11g. horizon values and power-law decay of h_lmbar, h_ll (printed only; ER Eq. (B13) requires h_lmbar = O(r^{-2-\[Epsilon]}), h_ll = O(r^{-1-\[Epsilon]})) *)
Do[Module[{fh = Function[rr, hAt[recon, comp, rr, 21/100]], dev, ex},
   dev = Function[xx, fh[rpN + xx] - fh[rpN]];
   ex = Table[N[localExp[Function[rr, fh[rr]], r0], 8], {r0, rFar {1/1000, 1/100, 1/10, 1}}];
   log[comp, ":  value on H+ (\[Chi] = 0.21) = ", N[fh[rpN], 12], ";  d ln|h|/d ln r at r = ", N[rFar {1/1000, 1/100, 1/10, 1}], ": ", ex, ";  r^n h at r = ", rFar, " with n = ", -Round[Last[ex]], ": ", N[rFar^(-Round[Last[ex]]) fh[rFar], 10]];
   ],
  {comp, {"hlmb", "hll"}}];

(* ==================================================================================================== *)
(* ==================================================================================================== *)
stage["16b. Completion: energy and angular momentum of the cloud, linearized Kerr perturbation (\[Delta]M, \[Delta]J)"];
(* h_ORG solves \[Delta]G_ab[h] = T_ab (all ten components, 11e) and every tetrad component falls off like r^-3 (11g): it carries no ADM mass or angular momentum,
   so by the linearized Gauss law the hole's own mass and spin in h_ORG are shifted by -E_cloud and -J_cloud. The completion adds the linearized Kerr
   perturbation with  \[Delta]M = E_cloud, \[Delta]J = J_cloud  (\[Delta]a = (\[Delta]J - a \[Delta]M)/M): the hole keeps its parameters (M, J) and the ADM mass and angular momentum of
   the spacetime become M + E_cloud and J + J_cloud. The completion is the zero-mode solution of the ER paper, Eq. (B1) with d\:00b0_mmbar = d\:00b0_mbarmbar = 0:
     h_lmbar = d\:00b0_lmbar \[Rho]'(\[Rho]'+\[Rho]bar'),   h_ll = d\:00b0_ll (\[Rho]'+\[Rho]bar') + [\[Rho]'^2 (2 \[Rho]bar' \[Tau]bar'\:00b0 d\:00b0_lmbar + \[Eth]~ d\:00b0_lmbar) + c.c.],
     d\:00b0_ll = -\[CapitalPsi]'\:00b0 \[Delta]M/M,   d\:00b0_lmbar = -(\[Tau]'\:00b0 \[CapitalPsi]'\:00b0/(2 \[Rho]bar\:00b0)) \[Delta]a/a   (ER paper, App. B.1, after Eq. (B1), corrected amplitudes),
   with the primed Held scalars of App. D: \[Tau]'\:00b0 = \[Tau]'/(\[Rho]' \[Rho]bar'), \[CapitalPsi]'\:00b0 = \[CapitalPsi]2/\[Rho]'^3, \[Rho]\:00b0 from Eq. (D1), and \[Eth]~ from Eq. (D8).
   The formula is checked here: Held scalars annihilated by \[Thorn]', \[Delta]G_ab = 0, and its linearized Komar charges (ADM mass and angular momentum) against \[Delta]M, \[Delta]J.
   The amplitudes of the two modes are then fixed by requiring Komar charges (E_cloud, J_cloud).
   Charges of the stationary, axisymmetric T_ab (\:03be = \[PartialD]_v, \[Psi] = \[PartialD]_\[Phi]) on the slices v = const (\[Sqrt]-g = \[CapitalSigma] in (v, r, \[Chi], \[Phi])); G = 1 (\[Delta]G_ab = 8\[Pi] T_ab), M = 1:
     E = \[Integral] d\[Phi] d\[Chi] dr \[CapitalSigma] (-T^v_v) = 2\[Pi] \[Integral] d\[Chi] dr \[CapitalSigma] (-T^v_v),    J = 2\[Pi] \[Integral] d\[Chi] dr \[CapitalSigma] T^v_\[Phi]   (Tdd1 = T_ab, no 8\[Pi]).
   Checks: the radial fluxes \[CapitalSigma] T^r_v, \[CapitalSigma] T^r_\[Phi] vanish (with the real radial function of the threshold mode, \[PartialD]^r \[CapitalPhi]/\[CapitalPhi] is real: no flux into H+); J/E = m/\[Omega] exactly (on shell E = \[Omega] N, J = m N
   with N the Noether charge, because \[Integral]_\[CapitalSigma] \[Sqrt]-g L reduces to a horizon term \[Proportional] (\[Omega] - m \[CapitalOmega]_H)); E from the panels agrees with NIntegrate. *)
Tmix = guu1 . Tdd1;          (* T^\[Mu]_\[Nu]: rows \[Mu] (upper), columns \[Nu] (lower), order (v, r, \[Chi], \[Phi]) *)
TmixF = optFun[{r, \[Chi], fq0, fq1, sq0, sq1}, N[(((r^2 + a^2 \[Chi]^2) {-Tmix[[1, 1]], Tmix[[1, 4]], -Tmix[[2, 1]], Tmix[[2, 4]]}) /. tParRules) /. fsRules, wp],
   N[{37/10, 3/10, 1/3, 1/5, 2/3, 1/4}, wp]];          (* \[CapitalSigma] {-T^v_v, T^v_\[Phi], -T^r_v, T^r_\[Phi]} *)
cloudDens[rr_, fv_] := Re[TmixF[rr, \[Chi]G, fv[[1]], fv[[2]], SGridT[[1]], SGridT[[2]]]] . wG;          (* \[Integral] d\[Chi] of the four densities at radius rr (Gauss-Legendre) *)
cloudPanel[p_] := Module[{vals = Transpose[Table[cloudDens[rPan[[p, j]], fP[[p, j]]], {j, nPn}]]}, panH[p] (chebEval[chebInt[chebCoef[#]], 1] & /@ vals)];
eDensN[s_?NumericQ] := cloudDens[s, fEx[s]][[1]];
If[useParallel, DistributeDefinitions[cloudPanel, eDensN]];
tm["cloud energy and angular momentum (Chebyshev panels in r, Gauss-Legendre in \[Chi]; one panel per job)",
  Module[{tot = Total[pMap[cloudPanel, Range[nPan]]]}, Ecloud = 2 Pi tot[[1]]; Jcloud = 2 Pi tot[[2]]]];          (* G = 1: E = 2 Pi Integral Sigma (-T^v_v) *)
log["cloud (per unit amplitude^2 A2 = amp2 of the Leaver normalization, Phi = Sqrt[A2] Phi_unit; units M = G = 1, delta G = 8 Pi T):  E = ", N[Ecloud, 20], ",  J = ", N[Jcloud, 20],
  ",  J/E = ", N[Jcloud/Ecloud, 20], "  (m/\[Omega] = ", N[1/\[Omega]H, 20], ")"];
check["completion: J_cloud/E_cloud = m/\[Omega] (single mode on shell; tests the threshold \[Omega] = m \[CapitalOmega]_H)", relErr[Jcloud/Ecloud, 1/\[Omega]H], 10^-(wp - 20)];
Module[{rs = {rpN + 1/1000, 3, 20, 200}, fl},
  fl = pMap[Function[rr, Module[{d = cloudDens[rr, fEx[rr]]}, Max[Abs[d[[3]]]/Abs[d[[1]]], Abs[d[[4]]]/Abs[d[[2]]]]]], rs];
  log["radial fluxes |\[Integral]d\[Chi] \[CapitalSigma] T^r_v| / |\[Integral]d\[Chi] \[CapitalSigma] T^v_v| (and the same for \[Phi]) at r = ", N[rs, 5], ": ", sci[fl, 2]];
  check["completion: no radial flux of energy and angular momentum (stationary, conserved, no flux into H+)", maxB[fl], 10^-(wp - 20)]];
Module[{segs = pMap[Function[ab, NIntegrate[eDensN[s], {s, ab[[1]], ab[[2]]}, WorkingPrecision -> 30, PrecisionGoal -> 22, MaxRecursion -> 30]],
     Partition[Join[{rpN, rpN + 1, 5, 20, 100, 400}, Select[farPts, # < rMax &], {rMax}], 2, 1]]},
  check["completion: E_cloud from the panels = NIntegrate over r+ .. rMax (independent quadrature)", relErr[Ecloud, 2 Pi Total[segs]], 10^-20]];
(* h_ORG has no ADM charges: every tetrad component falls off faster than r^-2 (h_mmbar = 0 beyond rMax) *)
Module[{ex = N[{localExp[Function[rr, Abs[hLLAt[rr, 21/100]]], rFar], localExp[Function[rr, Abs[hLMbAt[rr, 21/100]]], rFar], localExp[Function[rr, Abs[hMB[rr, 21/100]]], rFar]}]},
  log["d ln|h|/d ln r at r = ", rFar, " for h_ll, h_lmbar, h_mbarmbar of h_ORG: ", ex];
  check["completion: h_ORG carries no ADM mass or angular momentum (all tetrad components fall off faster than r^-2)", Max[ex] + 2, 0]];
(* ---- ER-paper zero modes (Eq. (B1)) and their checks ---- *)
numZeroM[e_] := numZero[e /. M -> 1];
(* Conjugation without Conjugate. The background quantities of section 1 that are complex conjugates (\[Rho]\[Rho]c, \[Rho]\[Rho]cp, \[Tau]\[Tau]cp, \[Beta]\[Beta]cp, \[Epsilon]\[Epsilon]cp, mbaru, ...) were made with
   FullSimplify[Conjugate[..]], which can leave Conjugate[..] / Abs[..] / Re / Im inside. Differentiating such a term symbolically gives Conjugate'[..], which never
   evaluates (this broke the \[Delta]a mode in runs 2 and 3). Here every input is first rewritten without them, using that r, \[Chi], a, M are real (|\[Chi]| < 1): the conjugate
   of an explicit expression is obtained by flipping every I. Each rewritten input is checked numerically against the original. *)
flipI[z_] := z /. Complex[x_, y_] :> Complex[x, -y];
(* Simplify can turn Sqrt[x^2]-type terms into Abs[x]; simp undoes that (Abs[x] -> Sqrt[x xbar]) so nothing non-differentiable is left *)
simp[e_] := Simplify[e] //. {Conjugate[z_ /; FreeQ[z, Conjugate | Abs]] :> flipI[z], Abs[z_ /; FreeQ[z, Conjugate | Abs]] :> Sqrt[z flipI[z]]};
deConj[e_] := (e //. {Conjugate[z_ /; FreeQ[z, Conjugate | Abs | Re | Im]] :> flipI[z],
      Abs[z_ /; FreeQ[z, Conjugate | Abs | Re | Im]] :> Sqrt[z flipI[z]], Re[z_ /; FreeQ[z, Conjugate | Abs | Re | Im]] :> (z + flipI[z])/2,
      Im[z_ /; FreeQ[z, Conjugate | Abs | Re | Im]] :> (z - flipI[z])/(2 I)});
cleanQ[e_] := FreeQ[e, Conjugate | Abs | Re | Im | Arg | Derivative] && FreeQ[e, _Symbol?(! MemberQ[{r, \[Chi], a, M, v, \[Phi]}, #] && Context[#] =!= "System`" &)];
cjH[e_] := simp[flipI[e]];          (* conjugate of a clean expression *)
tm["primed Held scalars of the background (ER App. D) and the ER zero modes (Eq. (B1))",
  Module[{orig = {\[Rho]\[Rho], \[Rho]\[Rho]c, \[Rho]\[Rho]p, \[Rho]\[Rho]cp, \[Tau]\[Tau]p, \[Tau]\[Tau]cp, \[Beta]\[Beta], \[Beta]\[Beta]cp, \[Epsilon]\[Epsilon]p, \[Epsilon]\[Epsilon]cp, \[CapitalPsi]2, eDual1}, cl},
   cl = pMap[deConj, orig];
   {\[Rho]\[Rho]D, \[Rho]\[Rho]cD, \[Rho]\[Rho]pD, \[Rho]\[Rho]cpD, \[Tau]\[Tau]pD, \[Tau]\[Tau]cpD, \[Beta]\[Beta]D, \[Beta]\[Beta]cpD, \[Epsilon]\[Epsilon]pD, \[Epsilon]\[Epsilon]cpD, \[CapitalPsi]2D, eDualC} = cl;
   log["completion inputs with Conjugate/Abs/Re/Im before the rewrite: ", Pick[{"\[Rho]", "\[Rho]bar", "\[Rho]'", "\[Rho]bar'", "\[Tau]'", "\[Tau]bar'", "\[Beta]", "\[Beta]bar'", "\[Epsilon]'", "\[Epsilon]bar'", "\[CapitalPsi]2", "coframe"}, ! FreeQ[#, Conjugate | Abs | Re | Im] & /@ orig]];
   check["completion: background inputs rewritten without Conjugate/Abs/Re/Im, equal to the originals (numerically, 2 points)",
    If[AllTrue[cl, cleanQ], Max[Table[numZeroM[cl[[k]] - orig[[k]]], {k, Length[orig] - 1}], numZeroM[eDualC - eDual1]], 1], 10^-25];
   check["completion: conjugate pairs are consistent after the rewrite (\[Rho]bar = flip(\[Rho]), \[Rho]bar' = flip(\[Rho]'), \[Tau]bar' = flip(\[Tau]'), \[CapitalPsi]2bar)",
    Max[numZeroM /@ {\[Rho]\[Rho]cD - cjH[\[Rho]\[Rho]D], \[Rho]\[Rho]cpD - cjH[\[Rho]\[Rho]pD], \[Tau]\[Tau]cpD - cjH[\[Tau]\[Tau]pD]}], 10^-25]];
  (* GHP operators on clean inputs (same definitions as \[Thorn]pExt, \[Eth]Ext of section 1, with r1 = s1 = 0) *)
  \[Thorn]pC[p_, q_][\[Eta]_] := simp[\[CapitalDelta]der[\[Eta]] + (p \[Epsilon]\[Epsilon]pD + q \[Epsilon]\[Epsilon]cpD) \[Eta]];
  \[Eth]C[p_, q_][\[Eta]_] := simp[\[Delta]der[\[Eta]] + (-p \[Beta]\[Beta]D + q \[Beta]\[Beta]cpD) \[Eta]];
  \[CapitalPsi]2c = cjH[\[CapitalPsi]2D];
  \[Tau]pH = simp[\[Tau]\[Tau]pD/(\[Rho]\[Rho]pD \[Rho]\[Rho]cpD)]; \[Tau]pHc = cjH[\[Tau]pH];          (* \[Tau]'\:00b0 and its conjugate (D3) *)
  \[CapitalPsi]pH = simp[\[CapitalPsi]2D/\[Rho]\[Rho]pD^3]; \[CapitalPsi]pHc = cjH[\[CapitalPsi]pH];                 (* \[CapitalPsi]'\:00b0 (D4) *)
  (* \[Rho]\:00b0 (D1): solved together with the conjugate equation (Solve in the Module body: an initializer would see the global u, uc) *)
  d1Eqs[u_, uc_] := {\[Rho]\[Rho]D - (1/2 (\[Rho]\[Rho]pD + \[Rho]\[Rho]cpD) u + 1/2 (\[Rho]\[Rho]pD - \[Rho]\[Rho]cpD) uc - 1/2 \[Rho]\[Rho]pD^2 \[CapitalPsi]pH - 1/2 \[Rho]\[Rho]pD \[Rho]\[Rho]cpD \[CapitalPsi]pHc - \[Rho]\[Rho]pD^2 \[Rho]\[Rho]cpD \[Tau]pH \[Tau]pHc),
     \[Rho]\[Rho]cD - (1/2 (\[Rho]\[Rho]cpD + \[Rho]\[Rho]pD) uc + 1/2 (\[Rho]\[Rho]cpD - \[Rho]\[Rho]pD) u - 1/2 \[Rho]\[Rho]cpD^2 \[CapitalPsi]pHc - 1/2 \[Rho]\[Rho]cpD \[Rho]\[Rho]pD \[CapitalPsi]pH - \[Rho]\[Rho]cpD^2 \[Rho]\[Rho]pD \[Tau]pHc \[Tau]pH)};
  {\[Rho]H, \[Rho]Hc} = Module[{u, uc, sol}, sol = Solve[Thread[d1Eqs[u, uc] == 0], {u, uc}];
     If[Length[sol] != 1, log["ERROR: Eq. (D1) for \[Rho]\:00b0 has ", Length[sol], " solutions"]; {u, uc}, simp[{u, uc} /. First[sol]]]];
  check["completion: \[Rho]\:00b0 solves Eq. (D1) (and its conjugate) and is a clean expression (no unsolved symbols)",
   If[cleanQ[{\[Rho]H, \[Rho]Hc}], Max[numZeroM /@ d1Eqs[\[Rho]H, \[Rho]Hc]], 1], 10^-25];
  log["Held scalars of this frame: \[Rho]\:00b0 = ", \[Rho]H, ",  \[CapitalPsi]'\:00b0 = ", \[CapitalPsi]pH, ",  \[Tau]'\:00b0 = ", \[Tau]pH];
  (* the Held scalars are annihilated by \[Thorn]' (types: \[Rho]\:00b0 {2,2}, \[CapitalPsi]'\:00b0 {3,3}, \[Tau]'\:00b0 {1,3}) *)
  check["completion: \[Rho]\:00b0, \[CapitalPsi]'\:00b0, \[Tau]'\:00b0 are Held scalars (\[Thorn]' annihilates them; \[Rho]\:00b0 from Eq. (D1))",
   Max[numZeroM /@ {\[Thorn]pC[2, 2][\[Rho]H], \[Thorn]pC[3, 3][\[CapitalPsi]pH], \[Thorn]pC[1, 3][\[Tau]pH]}], 10^-25];
  (* Eq. (D8): \[Eth] = \[Rho]' \[Eth]~ + p \[Rho]'^2 \[Tau]bar'\:00b0 on a quantity of type {p, q} *)
  \[Eth]Tilde[p_, q_][\[Eta]_] := simp[(\[Eth]C[p, q][\[Eta]] - p \[Rho]\[Rho]pD^2 \[Tau]pHc \[Eta])/\[Rho]\[Rho]pD];
  (* unit-amplitude modes: (\[Delta]M, \[Delta]a) = (1, 0) and (0, 1) *)
  erModes = Module[{dll = -\[CapitalPsi]pH/M, dlmb = -\[Tau]pH \[CapitalPsi]pH/(2 \[Rho]Hc a), hllM, hlmbJ, Tj, hllJ},
    hllM = simp[dll (\[Rho]\[Rho]pD + \[Rho]\[Rho]cpD)];
    hlmbJ = simp[dlmb \[Rho]\[Rho]pD (\[Rho]\[Rho]pD + \[Rho]\[Rho]cpD)];
    Tj = simp[\[Rho]\[Rho]pD^2 (2 \[Rho]\[Rho]cpD \[Tau]pHc dlmb + \[Eth]Tilde[2, 4][dlmb])];          (* d\:00b0_lmbar has type {2,4} (h_lmbar is {0,2}) *)
    hllJ = simp[Tj + cjH[Tj]];
    check["completion: d\:00b0_ll (type {3,3}) and d\:00b0_lmbar (type {2,4}) are Held scalars (\[Thorn]' annihilates them)", Max[numZeroM[\[Thorn]pC[3, 3][dll]], numZeroM[\[Thorn]pC[2, 4][dlmb]]], 10^-25];
    {{hllM, 0, 0}, {hllJ, cjH[hlmbJ], hlmbJ}}];          (* [[mode, {h_ll, h_lm, h_lmbar}]] *)
  log["ER zero modes (unit \[Delta]M): h_ll = ", erModes[[1, 1]]];
  log["ER zero modes (unit \[Delta]a): h_ll = ", erModes[[2, 1]], ",  h_lmbar = ", erModes[[2, 3]]];
  check["completion: the ER zero modes are clean explicit functions of (r, \[Chi]) (no Conjugate/Abs/Derivative, no unsolved symbols)", If[cleanQ[erModes], 0, 1], 1/2];
  (* closed forms in this tetrad (hand derivation, cross-checked numerically): h_ll(\[Delta]M) = 2r/\[CapitalSigma], h_lmbar(\[Delta]a) = i \[Sqrt]2 M r sin\[Theta]/(r - i a \[Chi])^3, h_ll(\[Delta]a) = -2 M a r (1+\[Chi]^2)/\[CapitalSigma]^2 *)
  check["completion: the ER zero modes equal their closed forms (2r/\[CapitalSigma]; i\[Sqrt]2 M r sin\[Theta]/(r - ia\[Chi])^3; -2Mar(1+\[Chi]^2)/\[CapitalSigma]^2)",
   Max[numZeroM /@ {erModes[[1, 1]] - 2 r/(r^2 + a^2 \[Chi]^2), erModes[[2, 3]] - I Sqrt[2] M r Sqrt[1 - \[Chi]^2]/(r - I a \[Chi])^3, erModes[[2, 1]] + 2 M a r (1 + \[Chi]^2)/(r^2 + a^2 \[Chi]^2)^2}], 10^-25];
  erDD = Table[simp[Transpose[eDualC] . hTet[Join[md, {0, 0, 0}] /. M -> 1] . eDualC], {md, erModes}];          (* coordinate components, M = 1 (= hDDof with the clean coframe) *)
  Module[{z = pMap[Function[hc, Max[numZero /@ Flatten[linEinstein[hc]]]], erDD]},
   log["max |\[Delta]G_ab| of the two ER zero modes at two test points: ", sci[N[z], 2]];
   check["completion: \[Delta]G_ab = 0 for the ER zero modes (vacuum, ORG by construction)", Max[z], 10^-25]]];
(* ---- linearized Komar integrals on the spheres v, r = const: K[\:03be] = \[Integral] d\[Chi] d\[Phi] \[Sqrt]-g (d\:03be)^{vr}, \[Sqrt]-g = \[CapitalSigma]; normalized on the background Kerr
   so that the Komar mass is M (\:03be = \[PartialD]_v) and the Komar angular momentum is J = a M (\:03be = \[PartialD]_\[Phi]); ADM = Komar at infinity for stationary spacetimes ---- *)
komarDens0[\:03beu_] := Module[{\:03bed = gdd1 . \:03beu, F}, F = Table[D[\:03bed[[n1]], x[[m1]]] - D[\:03bed[[m1]], x[[n1]]], {m1, 4}, {n1, 4}]; (r^2 + a^2 \[Chi]^2) (guu1 . F . guu1)[[1, 2]]];
komarDens1[hh_, \:03beu_] := Module[{\:03bed0 = gdd1 . \:03beu, \:03bed1 = hh . \:03beu, F0, F1, gi1 = -guu1 . hh . guu1, sg0 = r^2 + a^2 \[Chi]^2, sg1},
   sg1 = sg0/2 Tr[guu1 . hh];
   F0 = Table[D[\:03bed0[[n1]], x[[m1]]] - D[\:03bed0[[m1]], x[[n1]]], {m1, 4}, {n1, 4}]; F1 = Table[D[\:03bed1[[n1]], x[[m1]]] - D[\:03bed1[[m1]], x[[n1]]], {m1, 4}, {n1, 4}];
   sg1 (guu1 . F0 . guu1)[[1, 2]] + sg0 ((gi1 . F0 . guu1)[[1, 2]] + (guu1 . F0 . gi1)[[1, 2]] + (guu1 . F1 . guu1)[[1, 2]])];
komarQ[dens_, r0_] := 2 Pi NIntegrate[Evaluate[dens /. {r -> r0, a -> SetPrecision[aN, 40]}], {\[Chi], -1, 1}, WorkingPrecision -> 40, PrecisionGoal -> 25, MaxRecursion -> 20];
tm["linearized Komar charges of the Kerr derivatives and of the ER zero modes",
  Module[{\:03bet = {1, 0, 0, 0}, \:03bep = {0, 0, 0, 1}, cT, cP, chg, kerrD, kE, kD, sgn, rs = {5, 60}},
   cT = 1/komarQ[komarDens0[\:03bet], 7]; cP = aN/komarQ[komarDens0[\:03bep], 7];          (* M = 1, J = a *)
   chg[hh_, r0_] := {cT komarQ[komarDens1[hh, \:03bet], r0], cP komarQ[komarDens1[hh, \:03bep], r0]};          (* {\[Delta]M, \[Delta]J} *)
   kerrD = {D[gdd, M] /. M -> 1, D[gdd, a] /. M -> 1};          (* \[PartialD]_M g|_a and \[PartialD]_a g|_M: exact (\[Delta]M, \[Delta]J) = (1, a) and (0, 1) *)
   kD = Table[chg[hh, 7], {hh, kerrD}];
   log["Komar (\[Delta]M, \[Delta]J) of \[PartialD]_M g|_a: ", N[kD[[1]], 20], ",  of \[PartialD]_a g|_M: ", N[kD[[2]], 20], "  (expected (1, a), (0, 1); a = ", N[aN, 20], ")"];
   check["completion: Komar charges of the Kerr derivatives = (1, a) and (0, 1) (validates the Komar integral)", maxB[Abs[Flatten[kD - {{1, aN}, {0, 1}}]]], 10^-20];
   kE = Table[chg[hh, r0], {r0, rs}, {hh, erDD}];          (* [[radius, mode, {\[Delta]M, \[Delta]J}]] *)
   log["Komar (\[Delta]M, \[Delta]J) of the ER zero modes with the corrected amplitudes, unit \[Delta]M and unit \[Delta]a, at r = ", rs, ": ", N[kE, 20]];
   check["completion: Komar charges of the ER zero modes are independent of r (vacuum)", maxB[Abs[Flatten[kE[[1]] - kE[[2]]]]], 10^-20];
   (* the formula with the corrected amplitudes should give (\[Delta]M, \[Delta]J) = (1, a) for unit \[Delta]M and (0, M) for unit \[Delta]a (\[Delta]J = a \[Delta]M + M \[Delta]a) *)
   erKomar = kE[[1]];
   sgn = Round[erKomar[[1, 1]]];
   check["completion: ER zero modes carry the charges of linearized Kerr up to an overall sign s = \[PlusMinus]1: Komar = s {(1, a), (0, 1)}",
     maxB[Abs[Flatten[erKomar - sgn {{1, aN}, {0, 1}}]]], 10^-20];
   erSign = sgn;
   If[sgn == 1, log["ER zero-mode formula (corrected amplitudes): Komar charges = (\[Delta]M, \[Delta]J), s = +1"],
    log["WARNING: ER zero-mode formula gives Komar charges -(\[Delta]M, \[Delta]J) (s = ", sgn, "); the completion below uses the Komar-fixed amplitudes."]];
   check["completion: ER zero modes have the correct sign (s = +1): d\:00b0_ll = -\[CapitalPsi]'\:00b0 \[Delta]M/M, d\:00b0_lmbar = -(\[Tau]'\:00b0 \[CapitalPsi]'\:00b0/(2 \[Rho]bar\:00b0)) \[Delta]a/a", Abs[sgn - 1], 1/2]]];
(* completion amplitudes: Komar charges of h_comp = c1 h^ER(\[Delta]M=1) + c2 h^ER(\[Delta]a=1) equal (E_cloud, J_cloud) *)
{cM, cA} = LinearSolve[Transpose[erKomar], {Ecloud, Jcloud}];
\[Delta]Mcomp = Ecloud; \[Delta]acomp = Jcloud - aN Ecloud;          (* the linearized Kerr parameters, M = 1 *)
log["completion: (\[Delta]M, \[Delta]a) = (", N[\[Delta]Mcomp, 20], ", ", N[\[Delta]acomp, 20], "); coefficients of the ER modes with the corrected amplitudes (c_M, c_a) = (", N[cM, 20], ", ", N[cA, 20], ") = s (\[Delta]M, \[Delta]a)"];
check["completion: Komar-fixed coefficients = s (\[Delta]M, \[Delta]a)", relDiffL[{cM, cA}, erSign {\[Delta]Mcomp, \[Delta]acomp}], 10^-20];
compNames = {"ll", "lm", "lmb"};
compTetSym = erModes;          (* [[mode, {h_ll, h_lm, h_lmbar}]], with the corrected amplitudes in the ER paper (unit \[Delta]M, unit \[Delta]a) *)
hCompTetF = optFun[{r, \[Chi]}, N[Flatten[compTetSym] /. M -> 1 /. a -> aN, wp], N[{37/10, 3/10}, wp]];
hCompTet[r0_, c0_] := Module[{v = hCompTetF[r0, c0]}, AssociationThread[compNames, cM Take[v, 3] + cA Drop[v, 3]]];
log["completion h_comp = c_M h^ER(\[Delta]M=1) + c_a h^ER(\[Delta]a=1); tetrad components (only ll, lm, lmbar are nonzero), compared with h_ORG:"];
printGrid[Grid[Prepend[Table[Module[{hc = hCompTet[pt[[1]], pt[[2]]]}, {N[pt[[1]], 6], N[pt[[2]], 3], N[hc["ll"], 8], N[hc["lmb"], 8], N[hLLAt @@ pt, 8], N[hLMbAt @@ pt, 8]}],
     {pt, {{rpN + 1/1000, 21/100}, {3, -1/2}, {12, 7/10}, {150, 1/3}, {5000, 21/100}}}],
   {"r", "\[Chi]", "h_comp ll", "h_comp lmbar", "h_ORG ll", "h_ORG lmbar"}], Frame -> All]];
(* total (ADM) mass and angular momentum. Everything (T_ab, h_ORG, E_cloud, J_cloud) is per unit amplitude^2 of the Leaver normalization of \[CapitalPhi] (G = 1: \[CapitalPhi] = Sqrt[A2] \[CapitalPhi]_unit, \[Delta]G = 8\[Pi] T);
   for a cloud of amplitude^2 A2 (env BOSON_AMP2, default 1) the metric is g + A2 (h_ORG + h_comp) and the charges below scale the same way *)
(* the amplitude: BOSON_CLOUDMASS (cloud mass in units of the hole mass M, e.g. 1e-4) fixes A2 = M_cloud/E_cloud; otherwise BOSON_AMP2 (default 1).
   Numbers like 1e-4, 0.0001, 1*^-4 are read exactly (rationalized to 12 digits) *)
envExact[name_String] := With[{v = Environment[name]}, If[! StringQ[v] || StringTrim[v] === "", Missing[],
    With[{x = Quiet[ToExpression[StringReplace[StringTrim[v], {"e" -> "*^", "E" -> "*^"}]]]}, If[NumericQ[x] && x > 0, Rationalize[x, Abs[x] 10^-12], log["WARNING: ", name, " = ", v, " is not a positive number; ignored"]; Missing[]]]]];
cloudMassTarget = envExact["BOSON_CLOUDMASS"];
amp2 = Which[! MissingQ[cloudMassTarget], cloudMassTarget/Ecloud, ! MissingQ[envExact["BOSON_AMP2"]], envExact["BOSON_AMP2"], True, 1];
log["amplitude: ", If[MissingQ[cloudMassTarget], "A2 from BOSON_AMP2 (or default 1)", "cloud mass fixed to M_cloud/M = " <> ToString[N[cloudMassTarget, 10]] <> " (BOSON_CLOUDMASS)"],
  ";  A2 = ", N[amp2, 20], "  (G = 1, delta G = 8 Pi T; the scalar field is Sqrt[A2] Phi_unit (Leaver a_0 = 1); h_ORG, T_ab, E_cloud, J_cloud are stored per unit A2, the metric perturbation is A2 (h_ORG + h_comp))"];
If[! MissingQ[cloudMassTarget], check["completion: cloud mass A2 E_cloud = BOSON_CLOUDMASS", relErr[amp2 Ecloud, cloudMassTarget], 10^-(wp - 10)]];
massTot = 1 + amp2 Ecloud; angTot = aN + amp2 Jcloud;
log["ADM charges (M = 1, J = a for the hole; amplitude^2 A2 = ", N[amp2, 10], "):"];
printGrid[Grid[{{"", "hole", "cloud (shift)", "total (ADM)"},
    {"mass", 1, N[amp2 Ecloud, 20], N[massTot, 20]}, {"angular momentum", N[aN, 20], N[amp2 Jcloud, 20], N[angTot, 20]},
    {"spin parameter J/M^2", N[aN, 20], N[amp2 (Jcloud - 2 aN Ecloud), 20] (* \[Delta](J/M^2) = \[Delta]J - 2 a \[Delta]M, linear *), N[angTot/massTot^2, 20]}}, Frame -> All]];
With[{f25 = ToString[CForm[N[#, 25]]] &},          (* 25 digits, unquoted *)
  writeTSV[FileNameJoin[{outDir, "adm_charges.tsv"}], {{"quantity", "hole", "cloud_shift", "total_ADM"},
    {"mass", "1", f25[amp2 Ecloud], f25[massTot]},
    {"angular_momentum", f25[aN], f25[amp2 Jcloud], f25[angTot]},
    {"spin_parameter_J/M^2", f25[aN], f25[amp2 (Jcloud - 2 aN Ecloud)], f25[angTot/massTot^2]},
    {"amp2", f25[amp2], "NA", "NA"}}]];
completion = <|"amp2" -> amp2, "cloudMassTarget" -> cloudMassTarget, "holeMass" -> 1, "holeAngularMomentum" -> aN, "massShift" -> amp2 Ecloud, "angularMomentumShift" -> amp2 Jcloud, "totalMass" -> massTot, "totalAngularMomentum" -> angTot, "totalSpinParameter" -> angTot/massTot^2, "cloudEnergy" -> Ecloud, "cloudAngularMomentum" -> Jcloud, "deltaM" -> \[Delta]Mcomp, "deltaJ" -> Jcloud, "deltaa" -> \[Delta]acomp,
   "erSign" -> erSign, "coefficients" -> {cM, cA}, "komarOfERModes" -> erKomar,
   "heldScalars" -> <|"rho0" -> \[Rho]H, "Psip0" -> \[CapitalPsi]pH, "taup0" -> \[Tau]pH|>,
   "tetradComponentNames" -> compNames, "tetrad_ER_unit_dM" -> (erModes[[1]] /. M -> 1 /. a -> aN), "tetrad_ER_unit_da" -> (erModes[[2]] /. M -> 1 /. a -> aN),
   "coordinates" -> {v, r, \[Chi], \[Phi]}, "coord_ER_unit_dM" -> (erDD[[1]] /. a -> aN), "coord_ER_unit_da" -> (erDD[[2]] /. a -> aN),
   "note" -> "ORG gauge. h_total = h_ORG + cM hER_unit_dM + cA hER_unit_da, with hER the zero modes of the ER paper Eq. (B1) (d_mmbar = d_mbarmbar = 0, d_ll = -Psip0 dM/M, d_lmbar = -taup0 Psip0/(2 conj(rho0)) da/a) at unit dM and unit da. (cM, cA) fixed so that the linearized Komar (= ADM) charges of the completion are (E_cloud, J_cloud); (cM, cA) = erSign (deltaM, deltaa). The hole keeps (M, J). Per unit amplitude^2 (Leaver normalization; the scalar field is Sqrt[amp2] Phi_unit); totalMass = 1 + amp2 E_cloud, totalAngularMomentum = a + amp2 J_cloud (ADM). Coordinates ingoing Kerr (v, r, chi = cos theta, phi), M = 1, G = 1: delta G_ab = 8 pi T_ab, E_cloud = 2 pi Integral Sigma (-T^v_v) dr dchi."|>;

stage["17. Export h_ORG_cloud.mx and summary"];
(* ---------- diagnostics: h_mbarmbar and h_mmbar on the node grid; Chebyshev spectra of all components; export of h_diagnostics ---------- *)
hNodeVals[rs_] := Table[With[{mv = modeVals[r0]}, {hmbJetF[r0, \[Chi]N, mv, ones][[1]], hmmJetF[r0, \[Chi]N, kVals[r0]][[1]]}], {r0, rs}];
(* spectra of the node values V[[j, \[Chi]]] of one panel: radial = max over \[Chi] of |c_k| / max |c| (Chebyshev in t), angular = max over the radial nodes of
   |c_k| / max |c| of V/sin\[Theta]^s (Chebyshev in \[Chi]); |c| + its significance uncertainty, so the precision floor shows *)
specPanel[{V_, s_}] := Module[{cr = chebMat[nPn] . V, cc = (chebMat[n\[Chi]] . (#/s\[Theta]N^s)) & /@ V},
   {Map[bndS, Max /@ Abs[cr]]/Max[Max[Abs[cr]], 10^-300], Max /@ Transpose[Table[Map[bndS, c]/Max[Max[Abs[c]], 10^-300], {c, cc}]]}];
If[useParallel, DistributeDefinitions[hNodeVals, specPanel]];
tm["diagnostics: h_mbarmbar, h_mmbar at all nodes and Chebyshev spectra (one panel per job)",
  Module[{inn = pMap[hNodeVals, rPan], out = pMap[hNodeVals, rOut], flds, spec},
   flds = <|"hll" -> {recon["hllIn"], recon["hllOut"], 0}, "hlmb" -> {recon["hlmbIn"], recon["hlmbOut"], 1},
     "hmmb" -> {inn[[All, All, 2]], out[[All, All, 2]], 0}, "hmbmb" -> {inn[[All, All, 1]], out[[All, All, 1]], 2}|>;
   spec = AssociationThread[Keys[flds], Table[Module[{s = pMap[specPanel, Table[{V, fl[[3]]}, {V, fl[[1]]}]]},
       <|"radial" -> s[[All, 1]], "chi" -> s[[All, 2]], "sinPower" -> fl[[3]]|>], {fl, Values[flds]}]];
   diag["fields"] = Association[Table[k -> <|"inner" -> flds[k][[1]], "outer" -> flds[k][[2]], "spinWeightPower" -> flds[k][[3]]|>, {k, Keys[flds]}]];
   diag["spectra"] = spec]];
diag["params"] = par; diag["lmax"] = lmax; diag["lCuts"] = lCuts;
diag["grid"] = <|"xB" -> xB, "xMax" -> xMax, "nPn" -> nPn, "tNodes" -> tP, "zetaB" -> \[Zeta]B, "nchi" -> n\[Chi], "chiNodes" -> \[Chi]N, "rInner" -> rPan, "rOuter" -> rOut, "rMax" -> rMax, "rplus" -> rpN|>;
diag["einsteinTestPanels"] = <|"panels" -> eePan, "components" -> projList[[All, 1]], "full" -> Map[bndS, eeTab, {-1}], "outer" -> Map[bndS, eeTabOut, {-1}]|>;
diag["lConvergence"] = If[doLConv, lConv, Missing["no \[ScriptL]-convergence study"]];
diag["completion"] = KeyTake[completion, {"amp2", "cloudMassTarget", "holeMass", "holeAngularMomentum", "massShift", "angularMomentumShift", "totalMass", "totalAngularMomentum", "totalSpinParameter", "cloudEnergy", "cloudAngularMomentum", "deltaM", "deltaJ", "deltaa", "erSign"}];
diag["checks"] = {#[[1]], If[StringQ[#[[2]]], #[[2]], bndS[#[[2]]]], #[[3]], #[[4]]} & /@ checkLog;
diag["timing"] = <|"stages" -> stageLog, "steps" -> tmLog|>;
(* the diagnostics (machine precision; |x| + uncertainty for the error quantities) go into boson_cloud.wdx, key "diagnostics" *)
hFile = FileNameJoin[{outDir, "h_ORG_cloud.mx"}];
hRefPts = {{rpN + 1/1000, 21/100}, {3, -1/2}, {12, 7/10}, {150, 1/3}, {5000, 21/100}};
hExport = <|"params" -> par, "conventions" -> "traceful ORG (h_nb = 0), boosted Kinnersley tetrad of section 1 (n = -\[PartialD]_r), ingoing coordinates (v, r, \[Chi] = cos\[Theta], \[Phi]~), M = 1, G = 1, \[Delta]G_ab[h] = 8\[Pi] T_ab (T_ab of the field Sqrt[amp2] \[CapitalPhi]_unit; everything per unit amp2); particular solution (h -> 0 at infinity); its completion (zero modes of the ER paper Eq. (B1), amplitudes fixed by the Komar/ADM charges E_cloud, J_cloud) is in the key completion",
   "grid" -> <|"nchi" -> n\[Chi], "xB" -> xB, "xMax" -> xMax, "nPn" -> nPn, "tNodes" -> tP, "zetaB" -> \[Zeta]B, "chiNodes" -> \[Chi]N, "rInner" -> rPan, "rOuter" -> rOut|>,
   "hmbmb" -> <|"lList" -> lList, "I123" -> mbData, "g" -> gC, "Cup" -> AssociationMap[sol[#]["Cup"] &, lList]|>,
   "hmmb" -> <|"tau" -> \[Tau]C, "K123" -> nnData, "tails" -> tailNN, "PpolyR" -> PpolyR|>,
   "hlmb" -> <|"inner" -> recon["hlmbIn"], "outer" -> recon["hlmbOut"]|>,
   "hll" -> <|"inner" -> recon["hllIn"], "outer" -> recon["hllOut"]|>,
   "homogeneous" -> <|"u1" -> uHom[[1]], "u2" -> uHom[[2]], "A" -> Aop, "integratingFactor" -> ifac|>,
   "completion" -> completion,
   "reference" -> Table[<|"r" -> pt[[1]], "chi" -> pt[[2]], "hmbmb" -> hMB @@ pt, "hmmb" -> hMM @@ pt, "hlmb" -> hLMbAt @@ pt, "hll" -> hLLAt @@ pt|>, {pt, hRefPts}]|>;
(* ONE output file: the metric (hExport), the cloud and Psi4 (exportData), the diagnostics *)
allFile = FileNameJoin[{outDir, "boson_cloud.wdx"}];
tm["export boson_cloud.wdx (metric, scalar cloud, Psi4 modes, diagnostics)",
  Export[allFile, Join[<|"format" -> "boson_cloud.wdx v1 (Spin_Scan_G1/boson_cloud_pipeline_spinscan_lm_slim.wl)"|>, hExport,
     <|"scalar" -> KeyTake[exportData, {"cloud", "reference"}], "psi4" -> exportData["Psi4"], "diagnostics" -> toMach[diag]|>], "WDX"]];
log["written ", allFile, "  (", N[FileByteCount[allFile]/10^6, 3], " MB)"];
printGrid[Grid[Prepend[Table[{N[pt[[1]], 6], N[pt[[2]], 3], N[hMB @@ pt, 10], N[hMM @@ pt, 10], N[hLMbAt @@ pt, 10], N[hLLAt @@ pt, 10]}, {pt, hRefPts}], {"r", "\[Chi]", "h_mbarmbar", "h_mmbar", "h_lmbar", "h_ll"}], Frame -> All]];
stage["Summary"];
nFail = Count[checkLog[[All, 4]], False];
log["checks run: ", Length[checkLog], "    PASS: ", Count[checkLog[[All, 4]], True], "    FAIL: ", nFail];
If[nFail > 0, log["FAILED CHECKS:"]; Scan[log["   ", #[[1]], ":  err = ", If[StringQ[#[[2]]], #[[2]], sci[#[[2]]]], "  (tol ", sci[N[#[[3]]], 1], ")"] &, Select[checkLog, ! #[[4]] &]]];
(* spin scan: one summary line for this spin (collect_spin_scan.sh joins the runs) *)
With[{f16 = ToString[CForm[N[#, 16]]] &},
  writeTSV[FileNameJoin[{outDir, "spin_scan_point.tsv"}], {
    {"a", "mu", "omega", "omega_over_mu", "A_lm", "q", "alpha", "xMax", "panels", "series_terms", "nCF", "E_cloud", "J_cloud", "amp2", "M_total", "J_total",
     "chi_total", "checks_pass", "checks_fail", "minutes", "l", "m"},
    {f16[aN], f16[\[Mu]N], f16[\[Omega]H], f16[\[Omega]H/\[Mu]N], f16[Alm], f16[qN], f16[\[Alpha]N], f16[xMax], ToString[nPan], ToString[Length[cL]], ToString[nCF],
     f16[Ecloud], f16[Jcloud], f16[amp2], f16[massTot], f16[angTot], f16[angTot/massTot^2], ToString[Count[checkLog[[All, 4]], True]], ToString[nFail],
     ToString[Round[(AbsoluteTime[] - tRun0)/60., 0.1]], ToString[l1], ToString[m1]}}]];
log["written ", FileNameJoin[{outDir, "spin_scan_point.tsv"}]];
log["files: ", allFile, ", ", checkFile, ", ", FileNameJoin[{outDir, "timing.tsv"}], If[doLConv, ", " <> FileNameJoin[{outDir, "l_convergence.tsv"}], ""]];
timingReport[];
log["total run time: ", Round[(AbsoluteTime[] - tRun0)/60., 0.1], " min"];
saveChecks[];
If[useParallel, CloseKernels[]];
Exit[If[nFail > 0, 3, 0]];
