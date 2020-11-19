Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.
Require Import Omega.

Require Import core.utils.tTop.
Require Import core.Notations.
Require Import core.CoqTL.

Require Import examples.TT2BDT.TTMetamodel.
Require Import examples.TT2BDT.BDDMetamodel.

Open Scope coqtl.

Definition TT2BDDConcrete :=
  transformation TT2TT from TTMetamodel to BDDMetamodel
    with m as TTModel := [

      rule TT2BDD
        from
          t class TruthTableEClass
        to [
  
        ];
  ].

Close Scope coqtl.

Unset Printing Notations.
Print TT2BDDConcrete.

Definition TT2BDD := parseTransformation TT2BDDConcrete.
