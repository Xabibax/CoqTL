Require Import List.

Lemma concat_map_incl:
  forall (T1 T2: Type) (a: T1) (l: list T1) (f: T1-> (list T2)),
    (In a l) -> incl (f a) (concat (map f l)).
Proof.
  intros.
  induction l.
  - inversion H.
  - destruct H.
    + simpl.
      rewrite H.
      apply incl_appl.
      apply incl_refl.
    + simpl.
      apply IHl in H.
      apply incl_appr.
      exact H.
Qed.

Lemma concat_exists :
    forall (T : Type) (a : T) (l : list (list T)),
      In a (concat l) -> (exists (la : list T), In la l /\ In a la).
Proof.
    intros.
    induction l.
    - inversion H.
    - simpl in H. apply in_app_or in H. destruct H.
      + exists a0. split. apply in_eq. apply H.
      + apply IHl in H. destruct H. exists x. destruct H. split.
        -- apply in_cons. apply H.
        -- apply H0.
Qed.

Lemma concat_map_exists :
    forall (T1 T2: Type) (b : T2) (l : list T1) (f : T1 -> list T2),
      In b (concat (map f l)) -> (exists (a : T1), In a l /\ In b (f a)).
Proof.
    intros.
    apply concat_exists in H.
    destruct H. destruct H.
    induction l.
    - inversion H.
    - simpl in H. destruct H.
      -- exists a. rewrite H. split. simpl. left. reflexivity. apply H0.
      -- apply IHl in H. destruct H. exists x0. destruct H. split. simpl. right. apply H. apply H1.
Qed.
