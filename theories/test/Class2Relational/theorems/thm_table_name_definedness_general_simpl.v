Require Import Coq.Logic.Eqdep_dec.
Require Import Coq.Arith.EqNat.
Require Import List.
From mathcomp Require Import ssreflect ssrfun ssrbool eqtype.  

Require Import coqtl.utils.tTop.
Require Import coqtl.transformation.Notations.
Require Import coqtl.transformation.CoqTL.
Require Import coqtl.transformation.Metamodel.
Require Import coqtl.transformation.Model.

Require Import coqtl.test.Class2Relational.Class2Relational.
Require Import coqtl.test.Class2Relational.ClassMetamodel.
Require Import coqtl.test.Class2Relational.RelationalMetamodel.




(* try cast x to type t, if succ and results x1, do e1, else do e2 *)
Notation "  x1 '<=' '[[' t ']]' x '|' 'SUCC' e1 'FAIL' e2 " :=
(match toModelClass t x with
| Some x1 => e1
| None => e2
end)
(right associativity, at level 70).

Theorem Table_name_definedness_by_surj :
  forall (cm : ClassModel) (rm : RelationalModel), 
    rm = execute Class2Relational cm (* transformation *) ->
    ((forall (c1 : Class), In (ClassMetamodel_toEObject c1) (@allModelElements _ _ cm) -> (negb (beq_string (getClassName c1) ""))) /\       (* precondition 1*)
     (forall (a1 : Attribute), In (ClassMetamodel_toEObject a1) (@allModelElements _ _ cm) -> (negb (beq_string (getAttributeName a1) "")))) (* precondition 2 *) ->
    ( forall (t1 : RelationalMetamodel_EObject),
        In t1 (@allModelElements _ _ rm) ->
          (table1 <= [[TableClass]] t1  | SUCC (negb (beq_string (getTableName table1) "")) FAIL true) /\    (* postcondition 1*)
          (column1 <= [[ColumnClass]] t1 | SUCC (negb (beq_string (getColumnName column1) "")) FAIL true)).   (* postcondition 2*)
Proof.
  (* general bookkeeping *)
  intros cm rm H Hpre t1 Hintm.
  remember H as tr.
  clear Heqtr.
  apply tr_surj_elements with (t1:=t1) in H.
  Focus 2. assumption.
  Focus 1.
  destruct H as [sp]. destruct H as [tp]. destruct H as [r].
  destruct H as [Hinsm]. destruct H as [Hintp]. destruct H as [Hexec']. destruct H as [Hinclsp]. destruct H as [incltp].
  assert (instantiatePattern Class2Relational cm sp = return tp).
  { apply tr_instantiate_pattern_derivable with (tm:=rm) (r:=r); assumption. }
  rename H0 into Hexec.
  rename H into Hmatch.
  destruct Hpre as [Hpre1 Hpre2].
  try destruct sp eqn:sp_ca; inversion Hmatch. (* try ... inversion Hmatch; elimin impossible case *)
  try destruct l eqn:l_ca; inversion Hmatch.   (* try ... inversion Hmatch; elimin impossible case *)
  (* post1 and post2 needs to be proved here*)
  destruct c eqn:c_ca. 
  destruct c0 eqn:c0_ca; simpl in Hmatch.
     (* c0 = ClassEClass, prove post1 *)
     *  unfold instantiatePattern in Hexec.           
        unfold instantiateRuleOnPattern in Hexec. 
        simpl in Hexec.
        inversion Hexec as [Htp].
        rewrite <- Htp in Hintp.
        simpl in Hintp.
        destruct Hintp.
        ** rewrite <- H.
            assert (In c ([ClassMetamodel_BuildEObject ClassEClass c1])). { simpl. left. symmetry. assumption. }
            apply Hinclsp in H2.
            rewrite c_ca in H2.
            apply Hpre1 in H2.
            split.
            simpl.
            - rewrite H2.
              done.
            - done.
        ** done.
      (* c0 = AttributeEClass, prove post2 *)  
      * unfold instantiatePattern in Hexec.           
        unfold instantiateRuleOnPattern in Hexec. 
        simpl in Hexec.
        destruct (getAttributeDerived c1) eqn:derived_ca; simpl in Hexec. 
        ** inversion Hexec.
        ** inversion Hexec as [Htp].
           rewrite <- Htp in Hintp.
           simpl in Hintp.
           destruct Hintp.
         ** rewrite <- H.
            assert (In c ([ClassMetamodel_BuildEObject AttributeEClass c1])). { simpl. left. symmetry. assumption. }
            apply Hinclsp in H2.
            rewrite c_ca in H2.
            apply Hpre2 in H2.
            done.
        ** done.
Qed.
