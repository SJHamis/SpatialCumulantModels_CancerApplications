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

(************************************************************************)
(*                                                                      *)
(* Customised model components have been added to the Cancer ecology    *)
(* application.                                                         *)
(* Search for the string "Custom" to find all application-specific      *)
(* additions that have been included in this file.                      *)
(*                                                                      *)
(************************************************************************)

BeginPackage["SSPPlibraryOfProcesses`"]


listOfElementaryProcesses::usage="listOfElementaryProcesses provides a list of all basic processes presented in the library.";


TestTheCorrectnessOfProcesses::usage="TestTheCorrectnessOfProcesses[processes] checks the correctness of coordinates and species in all components of the list `processes'. However, it does not check the correctness of interactions. One should make sure that interactions are correct.";


Immigration ::usage="Immigration[s1,r,Coeffic] -- species s1 immigrates with rate r*Coeffic, where Coeffic is the overall prefactor to this process.";


Birth::usage="Birth[s1,a,Af,Coeffic] -- species s1 produces species s1(itself) with the kernel a in real space, Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


BirthToAnotherType::usage="BirthToAnotherType[s1,s2,a,Af,Coeffic] -- s2 gives birth to s1 with the kernel a in the real space, Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


BirthByFacilitation::usage="BirthByFacilitation[s1,s3,a,Af,b,Bf,Coeffic] -- species s1 produces species s1(itself) with the kernel b, this is facilitated by species s3 with the kernel a, both kernels are in real space. Af and Bf are Fourier transforms of kernels a and b respectively, Coeffic is the overall prefactor to this process.";


BirthToAnotherTypeByFacilitation::usage="BirthToAnotherTypeByFacilitation[s1,s2,s3,a,Af,b,Bf,Coeffic] -- species s2 produces species s1 with the kernel b, this is facilitated with by species s3 with the kernel a, both kernels are in real space. Af and Bf are Fourier transforms of kernels a and b respectively, Coeffic is the overall prefactor to this process.";


DensityIndependentDeath::usage="DensityIndependentDeath[s1,r,Coeffic] -- Species s1 dies with rate r*Coeffic, where Coeffic is the overall prefactor to this process.";


DeathByCompetition::usage="DeathByCompetition[s1,a,Af,Coeffic] -- Species s1 eliminates species s1(itself) with the kernel a, Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


DeathByExternalFactor::usage="DeathByExternalFactor[s1,s2,a,Af,Coeffic] -- species s2 kills s1 with the kernel a. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


ChangeInType::usage="ChangeInType[s1,s2,r,Coeffic] -- s2 changes into s1 with rate r*Coeffic, where Coeffic is the overall prefactor to this process.";


JumpAndChangeInType::usage="JumpAndChangeInType[s1,s2,a,Af,Coeffic] -- s2 jumps with the kernel a, and s2 changes into s1. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


Jump::usage="Jump[s1,a,Af,Coeffic] -- s1 jumps with the kernel a. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


Infection::usage="Infection[s1,s2,a,Af,Coeffic] -- s1 infects s2 with the kernel a, s2 becomes infected and turns into s1. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


ChangeInTypeByConsumption::usage="ChangeInTypeByConsumption[s1,s2,s3,a,Af,Coeffic] -- s2 eats s3 with the kernel a, s2 turns into s1. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


BirthByConsumption::usage="BirthByConsumption[s1,s2,a,Af,b,Bf,Coeffic] -- species s1 eats s2 with the kernel a, s1 gives birth to s1 with the kernel b. Af and Bf are Fourier transforms of kernels a and b respectively, Coeffic is the overall prefactor to this process.";


BirthToAnotherTypeByConsumption::usage="BirthToAnotherTypeByConsumption[s1,s2,s3,a,Af,b,Bf,Coeffic] -- type s2 individuals disappear when type s3 (s3\[NotEqual]s2) individuals are around with the kernel a, and simultaneously type s1 individuals appear near type s3 individuals with kernel b. Af and Bf are Fourier transforms of kernels a and b respectively, Coeffic is the overall prefactor to this process.";


(* Custom Model Process added below:*)
ChangeInTypeByFacilitation::usage="ChangeInTypeByFacilitation[s1,s2,s3,a,Af,Coeffic] -- s1 facilitates a change in type from s2 to s3 with kernel a, s2 turns into s3. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


BirthToAnotherTypeAndChangeInType::usage="BirthToAnotherTypeAndChangeInType[s1,s2,a,Af,Coeffic] -- s1 produces s2 and changes to s2. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.";


Begin["`Private`"]


TestTheCorrectnessOfProcesses[processes_]:=Module[{NumberOfErrors=0,
WarningMessage="List of errors:"},(* Consider each component separately *)NcomponentTotal = Length[processes];
Do[(* In each component identify P,R,C *)listP=processes[[Ncomponent,1,1]];listR=processes[[Ncomponent,1,2]];listC=processes[[Ncomponent,1,3]];(* ==========================================
Test 1) Any location cannot appear in any single group more than once, as no two species can
occupy the same location. However,the same location can appear in different groups.
*)If[DuplicateFreeQ[listP[[All,2]]],Null(*Print["OK - no same coordinates in P"]*),NumberOfErrors++;WarningMessage=ToString[WarningMessage<>"\n Error "<>ToString[NumberOfErrors]<>" -- In the component "<>ToString[Ncomponent]<>": same coordinates in P."];];If[DuplicateFreeQ[listR[[All,2]]],Null(*Print["OK - no same coordinates in R"]*),NumberOfErrors++;WarningMessage=ToString[WarningMessage<>"\n Error "<>ToString[NumberOfErrors]<>" -- In the component "<>ToString[Ncomponent]<>": same coordinates in R."];];If[DuplicateFreeQ[listC[[All,2]]],Null(*Print["OK - no same coordinates in C"]*),NumberOfErrors++;WarningMessage=ToString[WarningMessage<>"\n Error "<>ToString[NumberOfErrors]<>" -- In the component "<>ToString[Ncomponent]<>": same coordinates in C."];];(* ==========================================
Test 2) All locations in the group ``Catalysts'' should be unique and cannot appear in groups ``Products'' and ``Reactants''. 
*)If[DuplicateFreeQ[Join[DeleteDuplicates[listC[[All,2]]],DeleteDuplicates[listP[[All,2]]]]],Null(*Print["OK - no same coordinates in C and P"]*),NumberOfErrors++;WarningMessage=ToString[WarningMessage<>"\n Error "<>ToString[NumberOfErrors]<>" -- In the component "<>ToString[Ncomponent]<>": same coordinates in C and P."];];If[DuplicateFreeQ[Join[DeleteDuplicates[listC[[All,2]]],DeleteDuplicates[listR[[All,2]]]]],Null(*Print["OK - no same coordinates in C and R"]*),NumberOfErrors++;WarningMessage=ToString[WarningMessage<>"\n Error "<>ToString[NumberOfErrors]<>" -- In the component "<>ToString[Ncomponent]<>": same coordinates in C and R."];];(* ==========================================
Test 3) Groups ``Products'' and ``Reactants'' should not have identical pairs {species, location}. 
*)If[DuplicateFreeQ[Join[DeleteDuplicates[listP],DeleteDuplicates[listR]]],Null(*Print["OK - no completely similar pairs in P and R"]*),NumberOfErrors++;WarningMessage=ToString[WarningMessage<>"\n Error "<>ToString[NumberOfErrors]<>" -- In the component "<>ToString[Ncomponent]<>": completely similar pairs in P and R."];],{Ncomponent,1,NcomponentTotal}];(* ==========================================
Summary
*)If[NumberOfErrors==0,Print["No errors in species or coordinates were found. The correctness of interactions was not tested. Make sure that interactions are correct."],If[NumberOfErrors==1,Print[ToString["Warning! "<>ToString[NumberOfErrors]<>" error was found! \n "<>WarningMessage]],If[NumberOfErrors>1,Print[ToString["Warning! "<>ToString[NumberOfErrors]<>" errors were found! \n "<>WarningMessage]]]]]];


(* Custom Model Process has been added on the last row in the list below: *)
listOfElementaryProcesses=Module[{},{
"Immigration",
"DensityIndependentBirth", 
"BirthToAnotherType", 
"BirthByFacilitation", 
"BirthToAnotherTypeByFacilitation", 
"DensityIndependentDeath", 
"DeathByCompetition", 
"DeathByExternalFactor", 
"ChangeInType", 
"JumpAndChangeInType",
"Jump", 
"Infection", 
"ChangeInTypeByConsumption", 
"BirthByConsumption",
"BirthToAnotherTypeByConsumption",
"ChangeInTypeByFacilitation",
"BirthToAnotherTypeAndChangeInType"
}];


(* Custom Model Process has been added at the end of the Clear[] below: *)
Clear[Immigration,DensityIndependentBirth,BirthToAnotherType,BirthByFacilitation,BirthToAnotherTypeByFacilitation,DensityIndependentDeath,DeathByCompetition,DeathByExternalFactor,ChangeInType,Jump,Infection,ChangeInTypeByConsumption,BirthByConsumption,ChangeInTypeByFacilitation,BirthToAnotherTypeAndChangeInType]


(* species s1 immigrates with rate r*Coeffic, where Coeffic is the overall prefactor to this process. *)
Immigration[s1_,r_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={},
Catalysts={},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_]:=r;
Interactions=r;name="Immigration";{listAll,function,Interactions,name,Coeffic}]


(* species s1 produces species s1(itself) with the kernel a in real space, Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.*)
Birth[s1_,a_,Af_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={},
Catalysts={{s1,x2}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_]:=a[x1-x2];Interactions={{a,Af,x1,x2}};name="DensityIndependentBirth";{listAll,function,Interactions,name,Coeffic}];


(* s2 gives birth to s1 with the kernel a in real space, Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.*)
BirthToAnotherType[s1_,s2_,a_,Af_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={},
Catalysts={{s2,x2}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_]:=a[x1-x2];Interactions={{a,Af,x1,x2}};name="BirthToAnotherType";{listAll,function,Interactions,name,Coeffic}];


(* species s1 produces species s1(itself) with the kernel b, this is facilitated by species s3 with the kernel a, both kernels are in real space. Af and Bf are Fourier transforms of kernels a and b respectively, Coeffic is the overall prefactor to this process. *)
BirthByFacilitation[s1_,s3_,a_,Af_,b_,Bf_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={},
Catalysts={{s1,x2},{s3,x3}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_,x3_]:=a[x3-x2] b[x2-x1];Interactions={{a,Af,x3,x2},{b,Bf,x2,x1}};name="BirthByFacilitation";{listAll,function,Interactions,name,Coeffic}];


(* species s2 produces species s1 with the kernel b, this is facilitated with by species s3 with the kernel a, both kernels are in real space. Af and Bf are Fourier transforms of kernels a and b respectively, Coeffic is the overall prefactor to this process. *)
BirthToAnotherTypeByFacilitation[s1_,s2_,s3_,a_,Af_,b_,Bf_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={},
Catalysts={{s2,x2},{s3,x3}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_,x3_]:=a[x3-x2]b[x2-x1];Interactions={{a,Af,x3,x2},{b,Bf,x2,x1}};name="BirthToAnotherTypeByFacilitation";{listAll,function,Interactions,name,Coeffic}];


(*Species s1 dies with rate r*Coeffic, where Coeffic is the overall prefactor to this process. *)
DensityIndependentDeath[s1_,r_,Coeffic_]:=Module[{Products={},Reactants={{s1,x1}},
Catalysts={},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_]:=r;Interactions=r;name="DensityIndependentDeath";{listAll,function,Interactions,name,Coeffic}];


(*Species s1 eliminates species s1(itself) with the kernel a, Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.*)
DeathByCompetition[s1_,a_,Af_,Coeffic_]:=Module[{Products={},Reactants={{s1,x1}},
Catalysts={{s1,x2}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_]:=a[x1-x2];Interactions={{a,Af,x1,x2}};name="DeathByCompetition";{listAll,function,Interactions,name,Coeffic}];


(* species s2 kills s1 with the kernel a. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process. *)
DeathByExternalFactor[s1_,s2_,a_,Af_,Coeffic_]:=Module[{Products={},Reactants={{s1,x1}},
Catalysts={{s2,x2}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_]:=a[x1-x2];Interactions={{a,Af,x1,x2}};name="DeathByExternalFactor";{listAll,function,Interactions,name,Coeffic}];


(* s2 changes into s1 with rate r*Coeffic, where Coeffic is the overall prefactor to this process. *)
ChangeInType[s1_,s2_,r_,Coeffic_]:=Module[{Products={{s1,x2}},Reactants={{s2,x2}},
Catalysts={},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x2_]:=r;Interactions=r;name="ChangeInType";{listAll,function,Interactions,name,Coeffic}];


(*s2 jumps with the kernel a, and s2 changes into s1. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.*)
JumpAndChangeInType[s1_,s2_,a_,Af_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={{s2,x2}},
Catalysts={},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_]:=a[x1-x2];Interactions={{a,Af,x1,x2}};name="JumpAndChangeInType";{listAll,function,Interactions,name,Coeffic}];


(*s1 jumps with the kernel a. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process.*)
Jump[s1_,a_,Af_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={{s1,x2}},
Catalysts={},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_]:=a[x1-x2];Interactions={{a,Af,x1,x2}};name="Jump";{listAll,function,Interactions,name,Coeffic}];


(* s1 infects s2 with the kernel a, s2 becomes infected and turns into s1. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process. *)
Infection[s1_,s2_,a_,Af_,Coeffic_]:=Module[{Products={{s1,x2}},Reactants={{s2,x2}},
Catalysts={{s1,x3}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x2_,x3_]:=a[x2-x3];Interactions={{a,Af,x2,x3}};name="Infection";{listAll,function,Interactions,name,Coeffic}];


(* s2 eats s3 with the kernel a, s2 turns into s1. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process. *)
ChangeInTypeByConsumption[s1_,s2_,s3_,a_,Af_,Coeffic_]:=Module[{Products={{s1,x2}},Reactants={{s2,x2},{s3,x3}},
Catalysts={},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x2_,x3_]:=a[x2-x3];Interactions={{a,Af,x2,x3}};name="ChangeInTypeByConsumption";{listAll,function,Interactions,name,Coeffic}];


(* species s1 eats s2 with the kernel a, s1 gives birth to s1 with the kernel b. Af and Bf are Fourier transforms of kernels a and b respectively, Coeffic is the overall prefactor to this process. *)
BirthByConsumption[s1_,s2_,a_,Af_,b_,Bf_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={{s2,x2}},
Catalysts={{s1,x3}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_,x3_]:=a[x2-x3]b[x1-x3];Interactions={{a,Af,x2,x3},{b,Bf,x1,x3}};name="BirthByConsumption";{listAll,function,Interactions,name,Coeffic}];


(* species s3 eats s2 with the kernel a, s3 gives birth to s1 with the kernel b. Af and Bf are Fourier transforms of kernels a and b respectively, Coeffic is the overall prefactor to this process. *)
BirthToAnotherTypeByConsumption[s1_,s2_,s3_,a_,Af_,b_,Bf_,Coeffic_]:=Module[{Products={{s1,x1}},Reactants={{s2,x2}},
Catalysts={{s3,x3}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_,x3_]:=a[x2-x3]b[x1-x3];Interactions={{a,Af,x2,x3},{b,Bf,x1,x3}};name="BirthToAnotherTypeByConsumption";{listAll,function,Interactions,name,Coeffic}];


(* Custom Model Process added below:*)
(* s1 facilitates a change in type from s2 to s3 with kernel a, s2 turns into s3. Af is a Fourier transform of the kernel a, Coeffic is the overall prefactor to this process. *)
ChangeInTypeByFacilitation[s1_,s2_,s3_,a_,Af_,Coeffic_]:=Module[{Products={{s3,x2}},Reactants={{s2,x2}},
Catalysts={{s1,x3}},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x2_,x3_]:=a[x2-x3];Interactions={{a,Af,x2,x3}};name="ChangeInTypeByFacilitation";{listAll,function,Interactions,name,Coeffic}];


BirthToAnotherTypeAndChangeInType[s1_,s2_,a_,Af_,Coeffic_]:=Module[{Products={{s2,x1},{s2,x2}},Reactants={{s1,x1}},
Catalysts={},listAll,function,Interactions,name},listAll={Products,Reactants,Catalysts};function[x1_,x2_]:=a[x1-x2];Interactions={{a,Af,x1,x2}};name="BirthToAnotherTypeAndChangeInType";{listAll,function,Interactions,name,Coeffic}];



End[]


EndPackage[]
