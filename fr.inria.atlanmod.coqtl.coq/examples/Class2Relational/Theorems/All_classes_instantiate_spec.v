Require Import String.

Require Import core.utils.TopUtils.
Require Import core.Syntax.
Require Import core.Semantics.
Require Import core.Certification.
Require Import core.Metamodel.
Require Import core.Model.

Require Import examples.Class2Relational.Class2Relational.
Require Import examples.Class2Relational.ClassMetamodel.
Require Import examples.Class2Relational.RelationalMetamodel.

Require Import core.utils.CpdtTactics.

Theorem All_classes_instantiate_spec:
  forall (cm : ClassModel) (c: Class),
  exists (t: RelationalMetamodel_Object) tp,
    instantiatePattern Class2Relational cm [ClassMetamodel_toObject c] = tp /\
    In t tp.
Proof.
  intros.
  eexists. eexists.
  split. split.
  left. reflexivity.
Qed.
