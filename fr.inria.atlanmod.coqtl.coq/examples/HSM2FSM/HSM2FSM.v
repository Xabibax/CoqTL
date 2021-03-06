Require Import Bool.
Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.
Require Import Omega.

Require Import core.utils.tTop.
Require Import core.Notations.
Require Import core.CoqTL.

Require Import HSM.


Set Implicit Arguments.




Definition isNone (A: Type) (e : option A) : bool :=
 match e with
  | None => true
  | Some a => false
 end.

Definition AbstractState_instanceOfEClass_optional (hsec_arg: AbstractState_EClass) (hseo_arg : option AbstractState): bool :=
 match hseo_arg with
  | None => false
  | Some e => AbstractState_instanceOfEClass hsec_arg e
 end.

Definition beq_AbstractState_option (tr_arg1 : option AbstractState) (tr_arg2 : option AbstractState) : bool :=
 match tr_arg1, tr_arg2 with
  | Some a1, Some a2 => beq_AbstractState a1 a2
  | _, _ => false
 end.

Definition beq_CompositeState_option (tr_arg1 : option CompositeState) (tr_arg2 : option CompositeState) : bool :=
 match tr_arg1, tr_arg2 with
  | Some a1, Some a2 => beq_CompositeState a1 a2
  | _, _ => false
 end.


Open Scope coqtl.


Definition HSM2FSMConcrete :=
  transformation HSM2FSM from HSMMetamodel to HSMMetamodel
    with m as HSMModel := [

       rule SM2SM
         from
           sm1 class StateMachineEClass
         to
          [
           "sm2" :
             sm2 class StateMachineEClass :=
               BuildStateMachine (StateMachine_getName sm1) (StateMachine_getStateMachineID sm1)
             with
               [
                 ref StateMachineStatesEReference :=
                   states <- StateMachine_getStates sm1 m;
                   new_states <- resolveAll HSM2FSM m "as2" AbstractStateEClass
                      (map (fun s: AbstractState => [(HSMMetamodel_toEObject s)] ) states);
                   return BuildStateMachineStates sm2 new_states
               ]
          ]
      ;

      rule RS2RS
         from
           rs1 class AbstractStateEClass
             when (AbstractState_instanceOfEClass RegularStateEClass rs1)
         to
          [
           "as2":
             as2 class AbstractStateEClass :=
               BuildAbstractState RegularStateEClass (BuildRegularState (AbstractState_getName rs1) (AbstractState_getAbstractStateID rs1))
             with
               [
                 ref AbstractStateStateMachineEReference :=
                   hsm_sm <- (AbstractState_getStateMachine rs1 m);
                   fsm_sm <- resolve HSM2FSM m "sm2" StateMachineEClass [HSMMetamodel_toEObject hsm_sm];
                   return BuildAbstractStateStateMachine as2 fsm_sm 
               ]
          ]
      ;

      rule IS2IS
         from
            is1 class AbstractStateEClass 
             when andb (AbstractState_instanceOfEClass InitialStateEClass is1)
                       (isNone (AbstractState_getCompositeState is1 m))
         to
          [
            "as2" :
              as2 class AbstractStateEClass  :=
               BuildAbstractState InitialStateEClass (BuildInitialState (AbstractState_getName is1) (AbstractState_getAbstractStateID is1))
             with
               [
                 ref AbstractStateStateMachineEReference  :=
                   hsm_sm <- (AbstractState_getStateMachine is1 m);
                   fsm_sm <- resolve HSM2FSM m "sm2" StateMachineEClass [HSMMetamodel_toEObject hsm_sm];
                   return BuildAbstractStateStateMachine as2 fsm_sm 
               ]
          ]
      ;

      rule IS2RS
         from
            is1 class AbstractStateEClass 
             when andb (AbstractState_instanceOfEClass InitialStateEClass is1)
                       (negb (isNone (AbstractState_getCompositeState is1 m)))
         to
          [
            "as2":
              as2 class AbstractStateEClass  :=
               BuildAbstractState RegularStateEClass (BuildRegularState (AbstractState_getName is1) (AbstractState_getAbstractStateID is1))
             with
               [
                 ref AbstractStateStateMachineEReference  :=
                   hsm_sm <- (AbstractState_getStateMachine is1 m);
                   fsm_sm <- resolve HSM2FSM m "sm2" StateMachineEClass [HSMMetamodel_toEObject hsm_sm];
                   return BuildAbstractStateStateMachine as2 fsm_sm 
               ]
          ]
       ;

       rule T2TA
         from
            t1 class TransitionEClass 
             when  andb (negb (AbstractState_instanceOfEClass_optional CompositeStateEClass (Transition_getSource t1 m)))
                        (negb (AbstractState_instanceOfEClass_optional CompositeStateEClass (Transition_getTarget t1 m)))
         to
          [
            "t2":
              t2 class TransitionEClass :=
               BuildTransition (Transition_getLabel t1) (Transition_getTransitionID t1)
             with
               [
                 ref TransitionStateMachineEReference  :=
                   hsm_sm <- (Transition_getStateMachine t1 m);
                   fsm_sm <- resolve HSM2FSM m "sm2" StateMachineEClass [HSMMetamodel_toEObject hsm_sm];
                   return BuildTransitionStateMachine t2 fsm_sm;

                 ref TransitionSourceEReference  :=
                   hsm_tr_source <- (Transition_getSource t1 m);
                   fsm_tr_source <- resolve HSM2FSM m "as2" AbstractStateEClass [HSMMetamodel_toEObject hsm_tr_source];
                   return BuildTransitionSource t2 fsm_tr_source ;

                 ref TransitionTargetEReference  :=
                   hsm_tr_target <- (Transition_getTarget t1 m);
                   fsm_tr_target <- resolve HSM2FSM m "as2" AbstractStateEClass [HSMMetamodel_toEObject hsm_tr_target];
                   return BuildTransitionTarget t2 fsm_tr_target
               ]
          ]
       ;

       rule T2TB
         from
            t1 class TransitionEClass,
            src class AbstractStateEClass,
            trg class AbstractStateEClass,
            c class AbstractStateEClass 
             when   (AbstractState_instanceOfEClass CompositeStateEClass src) &&
                    (negb (AbstractState_instanceOfEClass CompositeStateEClass trg)) &&
                    (negb (beq_AbstractState c src)) &&
                     beq_AbstractState_option (Transition_getSource t1 m) (Some src) && 
                     beq_AbstractState_option (Transition_getTarget t1 m) (Some trg) &&
                     beq_CompositeState_option (AbstractState_getCompositeState c m) (HSMMetamodel_AbstractState_downcast CompositeStateEClass src)
         to
          [
            "t2":
              t2 class TransitionEClass :=
               BuildTransition ((Transition_getLabel t1) ++ "_from_" ++ (AbstractState_getName c) ++ "_to_" ++ (AbstractState_getName trg)) (Transition_getTransitionID t1)
             with
               [
                 ref TransitionStateMachineEReference  :=
                   hsm_sm <- (Transition_getStateMachine t1 m);
                   fsm_sm <- resolve HSM2FSM m "sm2" StateMachineEClass [HSMMetamodel_toEObject hsm_sm];
                   return BuildTransitionStateMachine t2 fsm_sm ;

                 ref TransitionSourceEReference  :=
                   fsm_tr_source <- resolve HSM2FSM m "as2" AbstractStateEClass [HSMMetamodel_toEObject c];
                   return BuildTransitionSource t2 fsm_tr_source ;

                 ref TransitionTargetEReference  :=
                   fsm_tr_target <- resolve HSM2FSM m "as2" AbstractStateEClass [HSMMetamodel_toEObject trg];
                   return BuildTransitionTarget t2 fsm_tr_target
               ]
          ]
       ;

       rule T2TC
         from
            t1 class TransitionEClass,
            src class AbstractStateEClass,
            trg class AbstractStateEClass,
            c class AbstractStateEClass 
             when   (AbstractState_instanceOfEClass CompositeStateEClass trg) &&
                    (AbstractState_instanceOfEClass InitialStateEClass c) &&
                    (negb (AbstractState_instanceOfEClass CompositeStateEClass src)) &&
                     beq_AbstractState_option (Transition_getSource t1 m) (Some src) && 
                     beq_AbstractState_option (Transition_getTarget t1 m) (Some trg) && 
                     beq_CompositeState_option (AbstractState_getCompositeState c m) (HSMMetamodel_AbstractState_downcast CompositeStateEClass trg)
         to
          [
            "t2":
              t2 class TransitionEClass :=
               BuildTransition ((Transition_getLabel t1) ++ "_from_" ++ (AbstractState_getName src) ++ "_to_" ++ (AbstractState_getName c)) (Transition_getTransitionID t1)
             with
               [
                 ref TransitionStateMachineEReference  :=
                   hsm_sm <- (Transition_getStateMachine t1 m);
                   fsm_sm <- resolve HSM2FSM m "sm2" StateMachineEClass [HSMMetamodel_toEObject hsm_sm];
                   return BuildTransitionStateMachine t2 fsm_sm ;

                 ref TransitionSourceEReference  :=
                   fsm_tr_source <- resolve HSM2FSM m "as2" AbstractStateEClass [HSMMetamodel_toEObject src];
                   return BuildTransitionSource t2 fsm_tr_source ;

                 ref TransitionTargetEReference  :=
                   hsm_c_abstract <- Some c;
                   fsm_tr_target <- resolve HSM2FSM m "as2" AbstractStateEClass [HSMMetamodel_toEObject hsm_c_abstract];
                   return BuildTransitionTarget t2 fsm_tr_target
               ]
          ]
  ]. 


Close Scope coqtl.



Unset Printing Notations.
Print HSM2FSMConcrete.
(* Compute maxArity (parseTransformation HSM2FSMConcrete). *)

Definition HSM2FSM := parseTransformation HSM2FSMConcrete.


