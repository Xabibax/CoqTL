Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.
Require Import Omega.

Require Import core.utils.tTop.
Require Import core.Notations.
Require Import core.Model.
Require Import core.CoqTL.

Require Import examples.ClassGraph2Tree.ClassMetamodel.
Require Import examples.ClassGraph2Tree.ClassMetamodelPattern.

Definition step (m: ClassModel) (c: Class) : option (list Class) :=
  attrs <- getClassAttributes c m;
  return
  concat
    (map
       (fun a => match getAttributeType a m with
              | Some cls => [ cls ]
              | None => nil
              end
       ) attrs).

Definition nextPaths (m: ClassModel) (p: list Class) : list (list Class) :=
  match p with
  | c :: p' =>
    match getClassAttributes c m with
    | Some attrs =>
      map
        (fun a =>
           match getAttributeType a m with
           | Some cls => cls :: p
           | None => nil
           end
        )
        attrs
    | None => nil
    end
  | nil => nil
  end.

Fixpoint allPathsFix (m: ClassModel) (l : nat) (p: list Class) :  list (list Class) :=
  match l with
  | S l' => p :: concat (map (allPathsFix m l') (nextPaths m p))
  | 0 => [ p ]
  end.

Definition rootClass (m : ClassModel) : Class :=
  hd (ClassMetamodel_defaultInstanceOfEClass ClassEClass)
     (ClassMetamodel_allInstances ClassEClass m).

Definition allPaths (m : ClassModel) (l : nat) : list (list Class) :=
  allPathsFix m l [ rootClass m ].

Definition allPathsTo (m : ClassModel) (l : nat) (o: Class) : list (list Class) :=
  filter (fun p =>
            match p with
            | h :: t => beq_Class h o
            | nil => false
            end
         ) (allPaths m l).

Open Scope coqtl.

Definition ClassGraph2Tree' :=
  transformation ClassGraph2Tree from ClassMetamodel to ClassMetamodel
    with m as ClassModel := [

      rule Class2Class
        from
          c!ClassEClass
        to [
          "at" : foreach p in (allPathsTo m 3 c)
            a'!AttributeEClass :=
              BuildAttribute newId false (getClassName c)
            with [
              !AttributeTypeEReference :=
                cls <- resolve ClassGraph2Tree m p ClassEClass [[ c ]] "cl" p;
                return BuildAttributeType a' cls
            ];
                                          
          "cl" : foreach p in (allPathsTo m 3 c)
            c'!ClassEClass :=
              BuildClass newId (getClassName c)
            with [
              !ClassAttributesEReference :=
                cls <- step m c;
                attrs <- resolveAll ClassGraph2Tree m p AttributeEClass
                  (map (fun c:Class => [[ c ]]) cls) (nextPaths m p) "at" p;
                return BuildClassAttributes c' attrs
            ]
        ]
].

Close Scope coqtl.

Definition ClassGraph2Tree := parseTransformation ClassGraph2Tree'.