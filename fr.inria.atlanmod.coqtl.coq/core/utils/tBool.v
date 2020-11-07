Require Import String List Omega.
Require Import core.utils.CpdtTactics.
Require Import Coq.Bool.Bool.

Definition beq_bool (b1 : bool) (b2 : bool) : bool :=
  if bool_dec b1 b2
  then true
  else false.

Lemma  lem_beq_bool_id:
  forall (b : bool),
    beq_bool b b = true.
Proof.
  intros.
  unfold beq_bool.
  destruct (bool_dec b b).
  -auto.
  -congruence.
Qed.

Lemma lem_beq_bool_eq2:
  forall (b1 b2 : bool),
   beq_bool b1 b2 = true -> b1 = b2.
Proof.
intros.
unfold beq_bool.
destruct (bool_dec b1 b2) eqn: ca.
- auto.
- unfold beq_bool in H.
  rewrite ca in H.
  congruence.
Qed. 
