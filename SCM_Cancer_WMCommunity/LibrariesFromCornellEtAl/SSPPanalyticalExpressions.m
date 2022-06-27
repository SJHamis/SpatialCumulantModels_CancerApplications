(* ::Package:: *)

(************************************************************************)
(* Model Constructor toolbox for Spatial Stochastic Point Processes.    *)
(* Model Constructor toolbox is a part of the article ``A unified       *)
(* framework for analysis of individual-based models in ecology and     *)
(* beyond'' written by Stephen J. Cornell, Yevhen F. Suprunenko,        *)
(* Dmitri Finkelshtein, Panu Somervuo, and Otso Ovaskainen.             *)
(*                                                                      *)
(* Copyright (C) 2019 Yevhen F. Suprunenko                              *)
(* Version 1.00                                                         *)
(*                                                                      *)
(* This program is free software; you can redistribute it and/or        *)
(* modify it under the terms of the GNU General Public License          *)
(* as published by the Free Software Foundation version 2               *)
(* of the License.                                                      *)
(*                                                                      *)
(* This program is distributed in the hope that it will be useful,      *)
(* but WITHOUT ANY WARRANTY; without even the implied warranty of       *)
(* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        *)
(* GNU General Public License for more details.                         *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(************************************************************************)



BeginPackage["SSPPanalyticalExpressions`",{"SSPPlibraryOfProcesses`"}]


speciesSSPP::usage="speciesSSPP[processes] gives a list of species in the system. The sequence of expressions in results for the mean field and its corrections corresponds to the sequence of species in this function.

Arguments:
processes -- is a list of elementary processes which describe the system.
";


HQf::usage="HQf[qpgVariables,processes,Npr,speciesN] shows a function Hq for species `speciesN' involved in an elementary process with the order number Npr in the list `processes'.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
Npr -- the order number of the elementary process in the list `processes'.
speciesN -- the number denoting the species.";


HPf::usage="HPf[qpgVariables,processes,Npr,speciesN,variableOfIntegrationFT,dim]  shows a function Hp for species `speciesN' involved in an elementary process with the order number Npr in the list `processes'.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
Npr -- the order number of the elementary process in the list `processes'.
speciesN -- the number denoting the species.
variableOfIntegrationFT -- the symbol denoting the variable of integration in the expression for Hp.
dim -- dimensionality of the space where the dynamics is considered. dim can be equal to 1,2, or 3.";


HGf::usage="HGf[qpgVariables,processes,Npr,speciesN,speciesM,kVariable] shows a function Hg(kVariable) for species `speciesN' and `speciesM' involved in an elementary process with the order number Npr in the list `processes'.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
Npr -- the order number of the elementary process in the list `processes'.
speciesM, speciesN -- numbers denoting the species.
kVariable -- the symbol denoting the modular component of wave vector in Fourier space.
";


HQfALL::usage="HQfALL[qpgVariables,processes,speciesN] shows a function Hq for species `speciesN' involved in all elementary process from the list `processes'.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
speciesN -- the number denoting the species.";


HPfALL::usage="HPfALL[qpgVariables,processes,speciesN,variableOfIntegrationFT,dim]  shows a function Hp for species `speciesN' involved in all elementary process from the list `processes'.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
speciesN -- the number denoting the species.
variableOfIntegrationFT -- the symbol denoting the variable of integration in the expression for Hp.
dim -- dimensionality of the space where the dynamics is considered. dim can be equal to 1,2, or 3.";


HGfALL::usage="HGfALL[qpgVariables,processes,speciesN,speciesM,kVariable] shows a function Hg(kVariable) for species `speciesN' and `speciesM' involved in all elementary process from the list `processes'.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
speciesM, speciesN -- numbers denoting the species.
kVariable -- the symbol denoting the modular component of wave vector in Fourier space.";


qSolutionsALL::usage="qSolutionsALL[qpgVariables,processes] shows a list of expressions for analytical solutions for the mean field in all possible equilibria for a given system.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
";


qSolution::usage="qSolution[qpgVariables,processes,solutionNumber] shows a list of expressions for analytical solutions for the mean field in the equilibrium chosen by value of `solutionNumber' for a given system.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
solutionNumber -- is the order number of the equilibrium in the list of all equilibria given by function ``qNumericalSolutionsALL''.
";


gAllSolutionsAtGeneralQ::usage="gAllSolutionsAtGeneralQ[qpgVariables,processes,kVariable] shows a list of analytical expressions for all correlation functions g calculated at some equilibrium for a given system.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
kVariable -- the symbol denoting the modular component of wave vector in Fourier space.
";


gSolutionAtGeneralQ::usage="gSolutionAtGeneralQ[speciesM,speciesN,qpgVariables,processes,kVariable] shows an analytical expression for specific correlation functions g[speciesM,speciesN](kVariable) calculated at some equilibrium for a given system.

Arguments:
speciesM, speciesN -- numbers denoting the species.
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
kVariable -- the symbol denoting the modular component of wave vector in Fourier space.
";


gAllSolutionsAtSolvedQ::usage="gAllSolutionsAtSolvedQ[qpgVariables,processes,kVariable,solutionNumber] shows a list of analytical expressions for all correlation functions g calculated at the equilibrium chosen by the value of the last argument `solutionNumber'.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
kVariable -- the symbol denoting the modular component of wave vector in Fourier space.
solutionNumber -- is the order number of the equilibrium in the list of all equilibria given by function ``qNumericalSolutionsALL''.
";


gSolutionAtSolvedQ::usage="gSolutionAtSolvedQ[speciesM,speciesN,qpgVariables_,processes_,kVariable_,solutionNumber_] shows an analytical expression for a specific correlation functions g[speciesM,speciesN](kVariable) calculated at the equilibrium chosen by the value of the last argument `solutionNumber'.

Arguments:
speciesM, speciesN -- numbers denoting the species.
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
kVariable -- the symbol denoting the modular component of wave vector in Fourier space.
solutionNumber -- is the order number of the equilibrium in the list of all equilibria given by function ``qNumericalSolutionsALL''.
";


pAllSolutionsAtGeneralQ::usage="pAllSolutionsAtGeneralQ[qpgVariables,processes,variableOfIntegrationFT,dim] shows a list of analytical expressions for a correction to the mean field calculated at some equilibrium for a given system.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
variableOfIntegrationFT -- the symbol denoting the variable of integration in the expression for Hp.
dim -- dimensionality of the space where the dynamics is considered. dim can be equal to 1,2, or 3.
";


pAllSolutionsAtSolvedQG::usage="pAllSolutionsAtSolvedQG[qpgVariables,processes,variableOfIntegrationFT,dim,solutionNumber] shows a list of analytical expressions for a correction to the mean field calculated at the equilibrium chosen by the value of the last argument `solutionNumber'.

Arguments:
qpgVariables -- should be given as a list of symbols used to denote q, p and g quantities from the main text. As a default, use qpgVariables={q,p,g}. Notice, these symbols should be clear and not used by other codes in Mathematica.
processes -- is a list of elementary processes which describe the system.
variableOfIntegrationFT -- the symbol denoting the variable of integration in the expression for Hp.
dim -- dimensionality of the space where the dynamics is considered. dim can be equal to 1,2, or 3.
solutionNumber -- is the order number of the equilibrium in the list of all equilibria given by function ``qNumericalSolutionsALL''.
";


Begin["`Private`"]


(*Clear[ProdQinRCexcept,coordi,C2f,Gf,Intf,IntfHP2,HQf,HPf,HGf]
ClearAll[q,p,gf,x,k]*)


(*ProdQinRCexcept generates a product of variables q with indices from group of Reactants and Catalysts except two indices beta1 and beta2 *)ProdQinRCexcept[qpgVariables_,beta1_,beta2_,listAll_]:=Module[{q},q=qpgVariables[[1]];Product[(q[listAll[[2]][[$elem,1]]])^(If[({2,$elem}==beta1)||({2,$elem}==beta2),0,1]),{$elem,1,Length[listAll[[2]]]}] Product[(q[listAll[[3]][[$elem,1]]])^(If[({3,$elem}==beta1)||({3,$elem}==beta2),0,1]),{$elem,1,Length[listAll[[3]]]}]];


(*coordi gives a coordinate x of species in group LN (LN=1 means Product, LN=2 means Reactant, LN=3 means Catalyst) on position n *)coordiF[{LN_,n_},listAll_]:=If[LN>0&&n>0,listAll[[LN,n,2]],{{}}]; 


(*C2f is the Fourier transform of the function C2, i.e.  C2[Npr,beta1,beta2,x1,x2] \[Rule] C2f[Npr,beta1,beta2,K]. C2f is used in HQ (as C2f[0]) and in HG.*)C2f[processes_,Npr_,{LN_,n_},{LM_,m_},kVariable_]:=Module[{listAll,Interactions,Xall,removeCoord,Coordlist,Coordlist2,IntFunctions,test,test1,el,C2fun},listAll=Evaluate[processes[[Npr]][[1]]];Interactions=Evaluate[processes[[Npr]][[3]]];If[Length[Interactions]==0,C2fun[kVariable]=Interactions,If[Length[Interactions]>0,(*Xall is an ordered list of all coordinates*)
Xall=Evaluate[Sort[DeleteDuplicates[Flatten[Interactions[[All,3;;4]]]]]];
(* removeCoord gives an order numbers of coordinates to be removed in Xall, e.g. removeCoord={{1},{4}};*)
removeCoord=Evaluate[Flatten[{Position[Xall,coordiF[{LN,n},listAll]],Position[Xall,coordiF[{LM,m},listAll]]},1]];
(*The n-th element of Coordlist corresponds to the n-th coordinate in Xall, and shows order numbers of kernels where this n-th coordinate is present.*)Coordlist=Table[Position[Interactions,Xall[[$i]]][[All,1]],{$i,Length[Xall]}];
(*Coordlist2 is Coordlist after removal of coordinates*)
Coordlist2=Evaluate[Delete[Coordlist,removeCoord]];
(*IntFunctions: The output is shown as a list "IntFunctions", where IntFunctions[[1]]=an order number of a function which is absent in Coordlist2 and which therefore appears as a function; IntFunctions[[2]]= the list of order numbers of functions which appear as integral over whole space;IntFunctions[[3]]= the list of order numbers of functions which appear in the convolution.*)IntFunctions={0,{},{}};
(*
calculating IntFunctions[[1]]
*)
test=0;Do[If[FreeQ[Coordlist2,$i],IntFunctions[[1]]=$i;test++],{$i,Length[Interactions]}];If[test>1,Print["Mistake!"]];
(*
calculating IntFunctions[[2]], if IntFunctions[[1]]=0
*)
If[IntFunctions[[1]]==0&&test==0,Do[(*step1: If there is an element with the length=1, find it*)test1=0;Do[el=Evaluate[Coordlist2[[$i]]];If[Length[el]==1,(*step2: Append the order number of this function to IntFunctions[[2]], as this function should appear as a constant*)AppendTo[IntFunctions[[2]],el[[1]]];(*step3: Remove the order number of this function from Coordlist2*)Coordlist2=Delete[DeleteCases[Coordlist2,el[[1]],2],$i];test1=1;Break[]],{$i,Length[Coordlist2]}];(*step4: Repeat and find the next element with the length=1*)If[test1==0,Break[]],{$j,Evaluate[Length[Coordlist2]]}];
(*
calculating IntFunctions[[3]], if IntFunctions[[1]]=0, and if Length[Coordlist2]>0
*)
If[Length[Coordlist2]>0,IntFunctions[[3]]=Sort[DeleteDuplicates[Flatten[Coordlist2]]]]];
(*The final result*)
(*In the case when there is the function denoted by IntFunctions[[1]] the result is given by a product of this function dependent on k, and the rest of kernels integrated over the whole space separately*)
If[IntFunctions[[1]]>0, C2fun[kVariable]=Interactions[[IntFunctions[[1]],2]][kVariable] Product[Interactions[[$i,2]][0],{$i,Delete[Table[i,{i,Length[Interactions]}],IntFunctions[[1]]]}],
(*Otherwise,the result is given by a product of integrals of functions in IntFunctions[[2]] and a product of Fourier transformed functions in IntFunctions[[3]]*)
C2fun[kVariable]=If[IntFunctions[[1]]==0,Product[Interactions[[IntFunctions[[2,$k2]],2]][0],{$k2,1,Length[IntFunctions[[2]]]}] Product[Interactions[[IntFunctions[[3,$j]],2]][kVariable],{$j,1,Length[IntFunctions[[3]]]}]]]]];C2fun[kVariable]];


(*Gf changes gf[2,1] into gf[1,2] using the fact that they are equal to each other in translationally invariant case *)
Gf[qpgVariables_,m_,n_,kVariable_]:=Module[{g},g=qpgVariables[[3]];g[Min[m,n],Max[m,n],kVariable]];


(*Intf is a product of gf and C2f functions.*)
Intf[paramG_,paramC_]:=Gf@@paramG C2f@@paramC;


(*Auxiliary functions for HP, taking into account dimensionality: *)
I0[dim_]:=If[dim==2,2\[Pi],If[dim==1,1,If[dim==3,4\[Pi]]]];
Ik[dim_,k_]:=If[dim==2,k,If[dim==1,1,If[dim==3,k^2]]];
IntfHP2[paramG_,paramC_,variableOfIntegrationFT_,dim_]:=I0[dim] Integrate[Ik[dim,variableOfIntegrationFT] Gf@@paramG C2f@@paramC,{variableOfIntegrationFT,0,\[Infinity]}];


HQf[qpgVariables_,processes_,Npr_,m_]:=Module[{listP,listR,listC},{listP,listR,listC}=processes[[Npr]][[1]];ProdQinRCexcept[qpgVariables,{0,0},{0,0},{listP,listR,listC}](Sum[If[m==listP[[$i,1]],C2f[processes,Npr,{1,$i},{0,0},0],0],{$i,1,Length[listP]}]-Sum[If[m==listR[[$j,1]],C2f[processes,Npr,{2,$j},{0,0},0],0],{$j,1,Length[listR]}])];


HPf[qpgVariables_,processes_,Npr_,m_,variableOfIntegrationFT_,dim_]:=Module[{listP,listR,listC,listAll,listBeta,p},p=qpgVariables[[2]];listAll={listP,listR,listC}=processes[[Npr]][[1]];listBeta=Flatten[Table[Table[{TypeOfList,elem},{elem,Length[listAll[[TypeOfList,All]]]}],{TypeOfList(*i.e. R and C*),2,3}],1];(*First term in the equation*)Sum[p@listAll[[Sequence@@listBeta[[$n1]]]][[1]] ProdQinRCexcept[qpgVariables,listBeta[[$n1]],{0,0},listAll],{$n1,1,Length[listBeta]}] (Sum[If[m==listP[[$i,1]],C2f[processes,Npr,{1,$i},{0,0},0],0],{$i,1,Length[listP]}]-Sum[If[m==listR[[$j,1]],C2f[processes,Npr,{2,$j},{0,0},0],0],{$j,1,Length[listR]}])+(*Second term in the equation*)Sum[Sum[ProdQinRCexcept[qpgVariables,listBeta[[$n1]],listBeta[[$n2]],listAll](Sum[If[m==listP[[$i,1]],IntfHP2[{qpgVariables,listAll[[Sequence@@listBeta[[$n1]]]][[1]],listAll[[Sequence@@listBeta[[$n2]]]][[1]],variableOfIntegrationFT},{processes,Npr,listBeta[[$n1]],listBeta[[$n2]],variableOfIntegrationFT},variableOfIntegrationFT,dim],0],{$i,1,Length[listP]}]-(*Term with Int and delta_mj *)Sum[If[m==listR[[$j,1]],IntfHP2[{qpgVariables,listAll[[Sequence@@listBeta[[$n1]]]][[1]],listAll[[Sequence@@listBeta[[$n2]]]][[1]],variableOfIntegrationFT},{processes,Npr,listBeta[[$n1]],listBeta[[$n2]],variableOfIntegrationFT},variableOfIntegrationFT,dim],0],{$j,1,Length[listR]}]),{$n2,$n1+1,Length[listBeta]}],{$n1,1,Length[listBeta]}]];


HGf[qpgVariables_,processes_,Npr_,m_,n_,kVariable_]:=Module[{listP,listR,listC,listAll,listBeta},listAll={listP,listR,listC}=processes[[Npr]][[1]];listBeta=Flatten[Table[Table[{TypeOfList,elem},{elem,Length[listAll[[TypeOfList,All]]]}],{TypeOfList(*i.e. R and C*),2,3}],1];ProdQinRCexcept[qpgVariables,{0,0},{0,0},listAll] ((*PP*)Sum[Sum[If[Boole[m==listP[[$i,1]]&&n==listP[[$i2,1]]]+Boole[m==listP[[$i2,1]]&&n==listP[[$i,1]]]>0,(Boole[m==listP[[$i,1]]&&n==listP[[$i2,1]]]+Boole[m==listP[[$i2,1]]&&n==listP[[$i,1]]])C2f[processes,Npr,{1,$i},{1,$i2},kVariable],0],{$i2,$i+1,Length[listP]}],{$i,1,Length[listP]}]-(*RR*)Sum[Sum[If[Boole[m==listR[[$j,1]]&&n==listR[[$j2,1]]]+Boole[m==listR[[$j2,1]]&&n==listR[[$j,1]]]>0,(Boole[m==listR[[$j,1]]&&n==listR[[$j2,1]]]+Boole[m==listR[[$j2,1]]&&n==listR[[$j,1]]]) C2f[processes,Npr,{2,$j},{2,$j2},kVariable],0],{$j2,$j+1,Length[listR]}],{$j,1,Length[listR]}]+(*CP*)Sum[Sum[If[Boole[m==listC[[$kk,1]]&&n==listP[[$i,1]]]+Boole[m==listP[[$i,1]]&&n==listC[[$kk,1]]]>0,(Boole[m==listC[[$kk,1]]&&n==listP[[$i,1]]]+Boole[m==listP[[$i,1]]&&n==listC[[$kk,1]]]) C2f[processes,Npr,{3,$kk},{1,$i},kVariable],0],{$kk,1,Length[listC]}],{$i,1,Length[listP]}]-(*CR*)Sum[Sum[If[Boole[m==listC[[$kk,1]]&&n==listR[[$j,1]]]+Boole[m==listR[[$j,1]]&&n==listC[[$kk,1]]]>0,(Boole[m==listC[[$kk,1]]&&n==listR[[$j,1]]]+Boole[m==listR[[$j,1]]&&n==listC[[$kk,1]]]) C2f[processes,Npr,{3,$kk},{2,$j},kVariable],0],{$kk,1,Length[listC]}],{$j,1,Length[listR]}])+(*P and RC*)Sum[Sum[ProdQinRCexcept[qpgVariables,listBeta[[$n1]],{0,0},listAll] ((*delta_mi and C*G *)If[(m==listP[[$i,1]])&&(ToString[coordiF[{1,$i},listAll]]==ToString[coordiF[listBeta[[$n1]],listAll]]),Gf[qpgVariables,listAll[[Sequence@@listBeta[[$n1]]]][[1]],n,kVariable] C2f[processes,Npr,{1,$i},{0,0},0],0]+(*delta_mi with Int*)If[(m==listP[[$i,1]])&&(ToString[coordiF[{1,$i},listAll]]!=ToString[coordiF[listBeta[[$n1]],listAll]]),Intf[{qpgVariables,listAll[[Sequence@@listBeta[[$n1]]]][[1]],n,kVariable},{processes,Npr,{1,$i},listBeta[[$n1]],kVariable}],0]+(*delta_ni and C*G *)If[(n==listP[[$i,1]])&&(ToString[coordiF[{1,$i},listAll]]==ToString[coordiF[listBeta[[$n1]],listAll]]),Gf[qpgVariables,m,listAll[[Sequence@@listBeta[[$n1]]]][[1]],kVariable] C2f[processes,Npr,{1,$i},{0,0},0],0]+(*delta_ni with Int*)If[(n==listP[[$i,1]])&&(ToString[coordiF[{1,$i},listAll]]!=ToString[coordiF[listBeta[[$n1]],listAll]]),Intf[{qpgVariables,m,listAll[[Sequence@@listBeta[[$n1]]]][[1]],kVariable},{processes,Npr,{1,$i},listBeta[[$n1]],kVariable}],0]),{$n1,1,Length[listBeta]}],{$i,1,Length[listP]}]-(*R and RC*)Sum[Sum[ProdQinRCexcept[qpgVariables,listBeta[[$n1]],{0,0},listAll] ((*delta_mj with Int*)If[(m==listR[[$j,1]])&&(ToString[coordiF[{2,$j},listAll]]!=ToString[coordiF[listBeta[[$n1]],listAll]]),Intf[{qpgVariables,listAll[[Sequence@@listBeta[[$n1]]]][[1]],n,kVariable},{processes,Npr,{2,$j},listBeta[[$n1]],kVariable}],0]+(*delta_mj and C*G *)If[(m==listR[[$j,1]])&&(ToString[coordiF[{2,$j},listAll]]==ToString[coordiF[listBeta[[$n1]],listAll]]),Gf[qpgVariables,listAll[[Sequence@@listBeta[[$n1]]]][[1]],n,kVariable] C2f[processes,Npr,{2,$j},{0,0},0],0]+(*delta_nj and C*G *)If[(n==listR[[$j,1]])&&(ToString[coordiF[{2,$j},listAll]]==ToString[coordiF[listBeta[[$n1]],listAll]]),Gf[qpgVariables,m,listAll[[Sequence@@listBeta[[$n1]]]][[1]],kVariable] C2f[processes,Npr,{2,$j},{0,0},0],0]+(*delta_nj with Int*)If[(n==listR[[$j,1]])&&(ToString[coordiF[{2,$j},listAll]]!=ToString[coordiF[listBeta[[$n1]],listAll]]),Intf[{qpgVariables,m,listAll[[Sequence@@listBeta[[$n1]]]][[1]],kVariable},{processes,Npr,{2,$j},listBeta[[$n1]],kVariable}],0]),{$n1,1,Length[listBeta]}],{$j,1,Length[listR]}]];


HQfALL[qpgVariables_,processes_,nN_]:=Sum[If[TrueQ[processes[[$Npr,5]]==0],0,processes[[$Npr,5]] HQf[qpgVariables,processes,$Npr,nN],0],{$Npr,1,Length[processes]}];


HPfALL[qpgVariables_,processes_,nN_,variableOfIntegrationFT_,dim_]:=Sum[If[TrueQ[processes[[$Npr,5]]==0],0,processes[[$Npr,5]] HPf[qpgVariables,processes,$Npr,nN,variableOfIntegrationFT,dim],0],{$Npr,1,Length[processes]}];


HGfALL[qpgVariables_,processes_,nN_,mM_,kVariable_]:=Sum[If[TrueQ[processes[[$Npr,5]]==0],0,processes[[$Npr,5]] HGf[qpgVariables,processes,$Npr,nN,mM,kVariable],0],{$Npr,1,Length[processes]}];


(*For analytical calculations none of kernels should be defined as functions! *)


(*A list "species" provides a list of all species whose variables q and g will be studied. Therefore, if there are species which are only Catalysts, i.e. which are externally given, then these species should be manually deleted from the list "species". Species,which are only Catalysts,should not be taken into account.The dynamics of such species should be given beforehand.*)
(*species=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];*)


speciesSSPP[processes_]:=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];


qSolutionsALL[qpgVariables0_,processes_]:=Module[{species,q,Qvars,result,qpgVariables},qpgVariables={q,qpgVariables0[[2]],qpgVariables0[[3]]};species=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];
(*Finding values of q variables in all stationary states (all equilibria, stable and not stable)*)
Qvars=Table[q[species[[$i]]],{$i,Length[species]}];
(*"solutions" give all values of q at all equilibria *)
result=Evaluate[Qvars/.Solve[Table[Sum[If[TrueQ[processes[[$Npr,5]]==0],0,processes[[$Npr,5]] HQf[qpgVariables,processes,$Npr,species[[$iI]]]],{$Npr,1,Length[processes]}]==0,{$iI,Length[species]}],Qvars]];result];


qSolution[qpgVariables_,processes_,solutionNumber_]:=If[solutionNumber<=Length[qSolutionsALL[qpgVariables,processes]]&&solutionNumber>0,qSolutionsALL[qpgVariables,processes][[solutionNumber]],Print["Error! Problem with the third argument of the function ``qSolution''."]];


(*This function shows Gsol - collection of all g[n,m,k] functions *)
gAllSolutionsAtGeneralQ[qpgVariables0_,processes_,kVariable_]:=Module[{g,species,Gvars,HGfEqs,M,b,iM,qpgVariables},qpgVariables={qpgVariables0[[1]],qpgVariables0[[2]],g};
species=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];(*Create a vector Gvars of all gf[m,n,k] functions, and a vector HGfEqs of corresponding right hand side of equations*)
Gvars={};
HGfEqs={};
Do[
Do[
AppendTo[Gvars,g[species[[$mM]],species[[$nN]],kVariable]];
AppendTo[HGfEqs,Sum[If[TrueQ[processes[[$Npr,5]]==0],0,processes[[$Npr,5]] HGf[qpgVariables,processes,$Npr,species[[$mM]],species[[$nN]],kVariable]],{$Npr,1,Length[processes]}]]
,{$nN,$mM,Length[species]}],
{$mM,Length[species]}];
(*Create the system of equations for g:*)
M=Table[Table[Coefficient[HGfEqs[[$i]],Gvars[[$j]]],{$j,Length[Gvars]}],{$i,Length[Gvars]}];
b=-Table[HGfEqs[[$i]]/.Table[Gvars[[$j]]->0,{$j,Length[Gvars]}],{$i,Length[Gvars]}];
(*Solve the system of equations for g:*)
iM=Inverse[M];
Simplify[iM.b]
]


gSolutionAtGeneralQ[speciesM_,speciesN_,qpgVariables_,processes_,kVariable_]:=Module[{species,$j,gIndexRow,gIndexColumn},
species=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];
If[MemberQ[species,speciesM]&&MemberQ[species,speciesN],
gIndexRow=Position[species,speciesM][[1,1]];gIndexColumn=Position[species,speciesN][[1,1]];
$j=(gIndexRow-1)(Length[species]-gIndexRow/2)+gIndexColumn;
If[gIndexRow<=gIndexColumn,
gAllSolutionsAtGeneralQ[qpgVariables,processes,kVariable][[$j]],If[gIndexRow>gIndexColumn,
$j=(gIndexColumn-1)(Length[species]-gIndexColumn/2)+gIndexRow;gAllSolutionsAtGeneralQ[qpgVariables,processes,kVariable][[$j]]]],Print["Error! Problem with the first and/or second argument of the function ``gSolutionAtGeneralQ''."]]]


gAllSolutionsAtSolvedQ[qpgVariables0_,processes_,kVariable_,solutionNumber_]:=
Module[{q,species,qpgVariables},qpgVariables={q,qpgVariables0[[2]],qpgVariables0[[3]]};species=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];
If[solutionNumber<=Length[qSolutionsALL[qpgVariables,processes]]&&solutionNumber>0,
Simplify[gAllSolutionsAtGeneralQ[qpgVariables,processes,kVariable]/.Table[q[$i]->qSolution[qpgVariables,processes,solutionNumber][[$i]],{$i,Length[species]}]],Print["Error! Problem with the fourth argument of the function ``gAllSolutionsAtSolvedQ''."]]];


gSolutionAtSolvedQ[speciesM_,speciesN_,qpgVariables_,processes_,kVariable_,solutionNumber_]:=Module[{species,$j,gIndexRow,gIndexColumn},species=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];
If[MemberQ[species,speciesM]&&MemberQ[species,speciesN],
gIndexRow=Position[species,speciesM][[1,1]];gIndexColumn=Position[species,speciesN][[1,1]];
If[gIndexRow<=gIndexColumn,$j=(gIndexRow-1)(Length[species]-gIndexRow/2)+gIndexColumn;
gAllSolutionsAtSolvedQ[qpgVariables,processes,kVariable,solutionNumber][[$j]],If[gIndexRow>gIndexColumn,
$j=(gIndexColumn-1)(Length[species]-gIndexColumn/2)+gIndexRow;gAllSolutionsAtSolvedQ[qpgVariables,processes,kVariable,solutionNumber][[$j]]]],Print["Error! Problem with the first and/or second argument of the function ``gSolutionAtSolvedQ''."]]]


pAllSolutionsAtGeneralQ[qpgVariables0_,processes_,variableOfIntegrationFT_,dim_]:=Module[{p,species,Pvars,result,qpgVariables},qpgVariables={qpgVariables0[[1]],p,qpgVariables0[[3]]};species=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];
Pvars=Table[p[species[[$i]]],{$i,Length[species]}];
result=Evaluate[Pvars/.Solve[Table[Sum[If[TrueQ[processes[[$Npr,5]]==0],0,processes[[$Npr,5]] HPf[qpgVariables,processes,$Npr,species[[$iI]],variableOfIntegrationFT,dim]],{$Npr,1,Length[processes]}]==0,{$iI,Length[species]}],Pvars]];Flatten[result,1]]


pAllSolutionsAtSolvedQG[qpgVariables0_,processes_,variableOfIntegrationFT_,dim_,solutionNumber_]:=
Module[{q,g,species,$lengthSpecies,qpgVariables},
qpgVariables={q,qpgVariables0[[2]],g};species=Sort[DeleteDuplicates[Flatten[processes[[All,1]],2][[All,1]]]];
$lengthSpecies=Length[species];
Simplify[Flatten[pAllSolutionsAtGeneralQ[qpgVariables,processes,variableOfIntegrationFT,dim]/.Join[Table[q[$i]->qSolution[qpgVariables,processes,solutionNumber][[$i]],{$i,$lengthSpecies}],Flatten[Table[g[species[[$mM]],species[[$nN]],variableOfIntegrationFT]->gAllSolutionsAtSolvedQ[qpgVariables,processes,variableOfIntegrationFT,solutionNumber][[($mM-1)($lengthSpecies-$mM/2)+$nN]],{$mM,$lengthSpecies},{$nN,$mM,$lengthSpecies}],1]],1]]];


End[]


EndPackage[]
