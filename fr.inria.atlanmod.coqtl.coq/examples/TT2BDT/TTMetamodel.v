
(********************************************************************
	@name Coq declarations for metamodel: <TruthTableModel>
	@date 2020/11/17 06:16:32
	@description Automatically generated by Ecore2Coq transformation.
 ********************************************************************)

(* Coq libraries *)
Require Import Bool.
Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.
Require Import Omega.
Require Import Coq.Logic.Eqdep_dec.

(* CoqTL libraries *)
Require Import core.utils.tTop.
Require Import core.Metamodel.
Require Import core.Model.


(* Base types *)
Inductive TruthTable : Set :=
  BuildTruthTable :
  (* id *) string ->
  (* name *) string ->
  TruthTable.
  
Inductive Row : Set :=
  BuildRow :
  (* id *) string ->
  Row.
  
Inductive Cell : Set :=
  BuildCell :
  (* id *) string ->
  (* value *) bool ->
  Cell.
  
Inductive Port : Set :=
  BuildPort :
  (* id *) string ->
  (* name *) string ->
  Port.
  
Inductive OutputPort : Set :=
  BuildOutputPort :
  (* super *) Port ->
  OutputPort.
  
Inductive InputPort : Set :=
  BuildInputPort :
  (* super *) Port ->
  InputPort.
  

Inductive TruthTablePorts : Set :=
   BuildTruthTablePorts :
   TruthTable ->
   list Port ->
   TruthTablePorts.
Inductive TruthTableRows : Set :=
   BuildTruthTableRows :
   TruthTable ->
   list Row ->
   TruthTableRows.

Inductive RowCells : Set :=
   BuildRowCells :
   Row ->
   list Cell ->
   RowCells.
Inductive RowOwner : Set :=
   BuildRowOwner :
   Row ->
   TruthTable ->
   RowOwner.

Inductive CellPort : Set :=
   BuildCellPort :
   Cell ->
   Port ->
   CellPort.
Inductive CellOwner : Set :=
   BuildCellOwner :
   Cell ->
   Row ->
   CellOwner.

Inductive PortOwner : Set :=
   BuildPortOwner :
   Port ->
   TruthTable ->
   PortOwner.
Inductive PortCells : Set :=
   BuildPortCells :
   Port ->
   list Cell ->
   PortCells.




(* Inheritence *)
Inductive OutputPortIsPort : Set :=
   BuildOutputPortIsPort :
   OutputPort ->
   Port ->
   OutputPortIsPort.

Inductive InputPortIsPort : Set :=
   BuildInputPortIsPort :
   InputPort ->
   Port ->
   InputPortIsPort.


Inductive TruthTableModelMetamodel_InheritReference : Set :=
| OutputPortIsPortInheritReference
| InputPortIsPortInheritReference
.

(* Accessors *)
(* Getters *)
(* Generated by coqtl generator *)
Definition getTruthTableId (t : TruthTable) : string :=
  match t with BuildTruthTable id name  => id end.
Definition getTruthTableName (t : TruthTable) : string :=
  match t with BuildTruthTable id name  => name end.
 
Definition getRowId (r : Row) : string :=
  match r with BuildRow id  => id end.
 
Definition getCellId (c : Cell) : string :=
  match c with BuildCell id value  => id end.
Definition getCellValue (c : Cell) : bool :=
  match c with BuildCell id value  => value end.
 
Definition getPortId (p : Port) : string :=
  match p with BuildPort id name  => id end.
Definition getPortName (p : Port) : string :=
  match p with BuildPort id name  => name end.
 
(* TODO *)
Definition getOutputPortId (p : OutputPort) : string :=
  match p with BuildOutputPort port  => getPortId(port) end.
  Definition getOutputPortName (p : OutputPort) : string :=
    match p with BuildOutputPort port  => getPortName(port) end.

Definition getInputPortId (p : InputPort) : string :=
  match p with BuildInputPort port  => getPortId(port) end.
Definition getInputPortName (p : InputPort) : string :=
  match p with BuildInputPort port  => getPortName(port) end.
(* /TODO *)
 
(* Setters *)
(* Made manually *)
Definition setTruthTableId (t : TruthTable) (s : string) : TruthTable :=
  BuildTruthTable s (getTruthTableName t).
Definition setTruthTableName (t : TruthTable) (s : string) : TruthTable :=
  BuildTruthTable (getTruthTableId t) s.

Definition setRowId (r : Row) (s : string) : Row :=
  BuildRow s.

Definition setCellId (c : Cell) (s : string) : Cell :=
  BuildCell s (getCellValue c) .
Definition setCellValue (c : Cell) (b : bool) : Cell :=
  BuildCell (getCellId c) b.

Definition setPortId (p : Port) (s : string) : Port :=
  BuildPort s (getPortName p).
Definition setPortName (p : Port) (s : string) : Port :=
  BuildPort (getPortId p) s.

(* TODO *)
Definition setOutputPortId (p : OutputPort) (s : string) : OutputPort  :=
  BuildOutputPort (BuildPort s (getOutputPortName p)).
Definition setOutputPortName (p : OutputPort) (s : string) : OutputPort  :=
  BuildOutputPort (BuildPort (getOutputPortId p) s).

Definition setInputPortId (p : InputPort) (s : string) : InputPort  :=
  BuildInputPort (BuildPort s (getInputPortName p)).
Definition setInputPortName (p : InputPort) (s : string) : InputPort :=
  BuildInputPort (BuildPort (getInputPortId p) s).
(* /TODO *)


 

(* Equality for Types *)
(**? We define eq for Eclass on their fist attribute **)
Definition beq_TruthTable (tr_arg1 : TruthTable) (tr_arg2 : TruthTable) : bool :=
  beq_string (getTruthTableId tr_arg1) (getTruthTableId tr_arg2).

Definition beq_Row (ro_arg1 : Row) (ro_arg2 : Row) : bool :=
  beq_string (getRowId ro_arg1) (getRowId ro_arg2).

Definition beq_Cell (ce_arg1 : Cell) (ce_arg2 : Cell) : bool :=
  beq_string (getCellId ce_arg1) (getCellId ce_arg2).

Definition beq_Port (po_arg1 : Port) (po_arg2 : Port) : bool :=
  beq_string (getPortId po_arg1) (getPortId po_arg2).



		
(* Meta-types *)
Inductive TruthTableModelMetamodel_EClass : Set :=
  | TruthTableEClass
  | RowEClass
  | CellEClass
  | PortEClass
  | OutputPortEClass
  | InputPortEClass
.

Definition TruthTableModelMetamodel_getTypeByEClass (trec_arg : TruthTableModelMetamodel_EClass) : Set :=
  match trec_arg with
    | TruthTableEClass => TruthTable
    | RowEClass => Row
    | CellEClass => Cell
    | PortEClass => Port
    | OutputPortEClass => OutputPort
    | InputPortEClass => InputPort
  end.

(**? confusing name convention **)
Definition TruthTableModelMetamodel_getEAttributeTypesByEClass (trec_arg : TruthTableModelMetamodel_EClass) : Set :=
  match trec_arg with
    | TruthTableEClass => (string * string)
    | RowEClass => (string)
    | CellEClass => (string * bool)
    | PortEClass => (string * string)
    | OutputPortEClass => (Port)
    | InputPortEClass => (Port)
  end.

Inductive TruthTableModelMetamodel_EReference : Set :=
| TruthTablePortsEReference
| TruthTableRowsEReference
| RowCellsEReference
| RowOwnerEReference
| CellPortEReference
| CellOwnerEReference
| PortOwnerEReference
| PortCellsEReference
.

Definition TruthTableModelMetamodel_getTypeByEReference (trer_arg : TruthTableModelMetamodel_EReference) : Set :=
  match trer_arg with
| TruthTablePortsEReference => TruthTablePorts
| TruthTableRowsEReference => TruthTableRows
| RowCellsEReference => RowCells
| RowOwnerEReference => RowOwner
| CellPortEReference => CellPort
| CellOwnerEReference => CellOwner
| PortOwnerEReference => PortOwner
| PortCellsEReference => PortCells
  end.

(**? confusing name convention **)
Definition TruthTableModelMetamodel_getERoleTypesByEReference (trer_arg : TruthTableModelMetamodel_EReference) : Set :=
  match trer_arg with
| TruthTablePortsEReference => (TruthTable * list Port)
| TruthTableRowsEReference => (TruthTable * list Row)
| RowCellsEReference => (Row * list Cell)
| RowOwnerEReference => (Row * TruthTable)
| CellPortEReference => (Cell * Port)
| CellOwnerEReference => (Cell * Row)
| PortOwnerEReference => (Port * TruthTable)
| PortCellsEReference => (Port * list Cell)
  end.

(* Generic types *)





(**? Changed Ctr name **)
Inductive TruthTableModelMetamodel_EObject : Set :=
 | Build_TruthTableModelMetamodel_EObject : 
    forall (trec_arg: TruthTableModelMetamodel_EClass), (TruthTableModelMetamodel_getTypeByEClass trec_arg) -> TruthTableModelMetamodel_EObject.

Inductive TruthTableModelMetamodel_ELink : Set :=
 | Build_TruthTableModelMetamodel_ELink : 
    forall (trer_arg:TruthTableModelMetamodel_EReference), (TruthTableModelMetamodel_getTypeByEReference trer_arg) -> TruthTableModelMetamodel_ELink.

(* Reflective functions *)

Lemma TruthTableModelMetamodel_eqEClass_dec : 
 forall (trec_arg1:TruthTableModelMetamodel_EClass) (trec_arg2:TruthTableModelMetamodel_EClass), { trec_arg1 = trec_arg2 } + { trec_arg1 <> trec_arg2 }.
Proof. repeat decide equality. Defined.

Lemma TruthTableModelMetamodel_eqEReference_dec : 
 forall (trer_arg1:TruthTableModelMetamodel_EReference) (trer_arg2:TruthTableModelMetamodel_EReference), { trer_arg1 = trer_arg2 } + { trer_arg1 <> trer_arg2 }.
Proof. repeat decide equality. Defined.

Definition TruthTableModelMetamodel_getEClass (treo_arg : TruthTableModelMetamodel_EObject) : TruthTableModelMetamodel_EClass :=
   match treo_arg with
  | (Build_TruthTableModelMetamodel_EObject treo_arg _) => treo_arg
   end.

Definition TruthTableModelMetamodel_getEReference (trel_arg : TruthTableModelMetamodel_ELink) : TruthTableModelMetamodel_EReference :=
   match trel_arg with
  | (Build_TruthTableModelMetamodel_ELink trel_arg _) => trel_arg
   end.

Definition TruthTableModelMetamodel_instanceOfEClass (trec_arg: TruthTableModelMetamodel_EClass) (treo_arg : TruthTableModelMetamodel_EObject): bool :=
  if TruthTableModelMetamodel_eqEClass_dec (TruthTableModelMetamodel_getEClass treo_arg) trec_arg then true else false.

Definition TruthTableModelMetamodel_instanceOfEReference (trer_arg: TruthTableModelMetamodel_EReference) (trel_arg : TruthTableModelMetamodel_ELink): bool :=
  if TruthTableModelMetamodel_eqEReference_dec (TruthTableModelMetamodel_getEReference trel_arg) trer_arg then true else false.

(** Helper of building EObject for model **)
Definition TruthTableModelMetamodel_getEObjectFromEAttributeValues (trec_arg : TruthTableModelMetamodel_EClass) : (TruthTableModelMetamodel_getEAttributeTypesByEClass trec_arg) -> TruthTableModelMetamodel_EObject :=
  match trec_arg with
    | TruthTableEClass => 
      (fun (p: (string * string)) => 
        (Build_TruthTableModelMetamodel_EObject TruthTableEClass (BuildTruthTable (fst p) (snd p))))
    | RowEClass => (fun (p: (string)) => (Build_TruthTableModelMetamodel_EObject RowEClass (BuildRow p)))
    | CellEClass => (fun (p: (string * bool)) => (Build_TruthTableModelMetamodel_EObject CellEClass (BuildCell (fst p) (snd p))))
    | PortEClass => (fun (p: (string * string)) => (Build_TruthTableModelMetamodel_EObject PortEClass (BuildPort (fst p) (snd p))))
    | OutputPortEClass => (fun (p: (Port)) => (Build_TruthTableModelMetamodel_EObject OutputPortEClass (BuildOutputPort)))
    | InputPortEClass => (fun (p: (Port)) => (Build_TruthTableModelMetamodel_EObject InputPortEClass (BuildInputPort)))
  end.

(** Helper of building ELink for model **)
Definition TruthTableModelMetamodel_getELinkFromERoleValues (trer_arg : TruthTableModelMetamodel_EReference) : (TruthTableModelMetamodel_getERoleTypesByEReference trer_arg) -> TruthTableModelMetamodel_ELink :=
  match trer_arg with
| TruthTablePortsEReference => (fun (p: (TruthTable * list Port)) => (Build_TruthTableModelMetamodel_ELink TruthTablePortsEReference (BuildTruthTablePorts (fst p) (snd p))))
| TruthTableRowsEReference => (fun (p: (TruthTable * list Row)) => (Build_TruthTableModelMetamodel_ELink TruthTableRowsEReference (BuildTruthTableRows (fst p) (snd p))))
| RowCellsEReference => (fun (p: (Row * list Cell)) => (Build_TruthTableModelMetamodel_ELink RowCellsEReference (BuildRowCells (fst p) (snd p))))
| RowOwnerEReference => (fun (p: (Row * TruthTable)) => (Build_TruthTableModelMetamodel_ELink RowOwnerEReference (BuildRowOwner (fst p) (snd p))))
| CellPortEReference => (fun (p: (Cell * Port)) => (Build_TruthTableModelMetamodel_ELink CellPortEReference (BuildCellPort (fst p) (snd p))))
| CellOwnerEReference => (fun (p: (Cell * Row)) => (Build_TruthTableModelMetamodel_ELink CellOwnerEReference (BuildCellOwner (fst p) (snd p))))
| PortOwnerEReference => (fun (p: (Port * TruthTable)) => (Build_TruthTableModelMetamodel_ELink PortOwnerEReference (BuildPortOwner (fst p) (snd p))))
| PortCellsEReference => (fun (p: (Port * list Cell)) => (Build_TruthTableModelMetamodel_ELink PortCellsEReference (BuildPortCells (fst p) (snd p))))
  end.

Definition TruthTableModelMetamodel_toEClass (trec_arg : TruthTableModelMetamodel_EClass) (treo_arg : TruthTableModelMetamodel_EObject) : option (TruthTableModelMetamodel_getTypeByEClass trec_arg).
Proof.
  destruct treo_arg as [arg1 arg2].
  destruct (TruthTableModelMetamodel_eqEClass_dec arg1 trec_arg) as [e|] eqn:dec_case.
  - rewrite e in arg2.
    exact (Some arg2).
  - exact None.
Defined.

Definition TruthTableModelMetamodel_toEReference (trer_arg : TruthTableModelMetamodel_EReference) (trel_arg : TruthTableModelMetamodel_ELink) : option (TruthTableModelMetamodel_getTypeByEReference trer_arg).
Proof.
  destruct trel_arg as [arg1 arg2].
  destruct (TruthTableModelMetamodel_eqEReference_dec arg1 trer_arg) as [e|] eqn:dec_case.
  - rewrite e in arg2.
  	exact (Some arg2).
  - exact None.
Defined.

(* Generic functions *)
Definition TruthTableModelMetamodel_toEObjectFromTruthTable (tr_arg :TruthTable) : TruthTableModelMetamodel_EObject :=
  (Build_TruthTableModelMetamodel_EObject TruthTableEClass tr_arg).
Coercion TruthTableModelMetamodel_toEObjectFromTruthTable : TruthTable >-> TruthTableModelMetamodel_EObject.

Definition TruthTableModelMetamodel_toEObjectFromRow (ro_arg :Row) : TruthTableModelMetamodel_EObject :=
  (Build_TruthTableModelMetamodel_EObject RowEClass ro_arg).
Coercion TruthTableModelMetamodel_toEObjectFromRow : Row >-> TruthTableModelMetamodel_EObject.

Definition TruthTableModelMetamodel_toEObjectFromCell (ce_arg :Cell) : TruthTableModelMetamodel_EObject :=
  (Build_TruthTableModelMetamodel_EObject CellEClass ce_arg).
Coercion TruthTableModelMetamodel_toEObjectFromCell : Cell >-> TruthTableModelMetamodel_EObject.

Definition TruthTableModelMetamodel_toEObjectFromPort (po_arg :Port) : TruthTableModelMetamodel_EObject :=
  (Build_TruthTableModelMetamodel_EObject PortEClass po_arg).
Coercion TruthTableModelMetamodel_toEObjectFromPort : Port >-> TruthTableModelMetamodel_EObject.

Definition TruthTableModelMetamodel_toEObjectFromOutputPort (ou_arg :OutputPort) : TruthTableModelMetamodel_EObject :=
  (Build_TruthTableModelMetamodel_EObject OutputPortEClass ou_arg).
Coercion TruthTableModelMetamodel_toEObjectFromOutputPort : OutputPort >-> TruthTableModelMetamodel_EObject.

Definition TruthTableModelMetamodel_toEObjectFromInputPort (in_arg :InputPort) : TruthTableModelMetamodel_EObject :=
  (Build_TruthTableModelMetamodel_EObject InputPortEClass in_arg).
Coercion TruthTableModelMetamodel_toEObjectFromInputPort : InputPort >-> TruthTableModelMetamodel_EObject.


(**? what are these for **)
Definition TruthTableModelMetamodel_toEObject (treo_arg : TruthTableModelMetamodel_EObject) : TruthTableModelMetamodel_EObject := treo_arg.
Definition TruthTableModelMetamodel_toELink (trel_arg : TruthTableModelMetamodel_ELink) : TruthTableModelMetamodel_ELink := trel_arg.
Definition TruthTableModelModel := Model TruthTableModelMetamodel_EObject TruthTableModelMetamodel_ELink.

Definition TruthTableModelMetamodel_toEObjectOfEClass (trec_arg: TruthTableModelMetamodel_EClass) (t: TruthTableModelMetamodel_getTypeByEClass trec_arg) : TruthTableModelMetamodel_EObject :=
  (Build_TruthTableModelMetamodel_EObject trec_arg t).

Definition TruthTableModelMetamodel_toELinkOfEReference (trer_arg: TruthTableModelMetamodel_EReference) (t: TruthTableModelMetamodel_getTypeByEReference trer_arg) : TruthTableModelMetamodel_ELink :=
		  (Build_TruthTableModelMetamodel_ELink trer_arg t).
		  
Fixpoint TruthTableModelMetamodel_getTruthTablePortsOnLinks (tr_arg : TruthTable) (l : list TruthTableModelMetamodel_ELink) : option (list Port) :=
match l with
| (Build_TruthTableModelMetamodel_ELink TruthTablePortsEReference (BuildTruthTablePorts TruthTable_ctr ports_ctr)) :: l' => 
	  if beq_TruthTable TruthTable_ctr tr_arg then Some ports_ctr else TruthTableModelMetamodel_getTruthTablePortsOnLinks tr_arg l'
| _ :: l' => TruthTableModelMetamodel_getTruthTablePortsOnLinks tr_arg l'
| nil => None
end.

Definition getTruthTablePorts (tr_arg : TruthTable) (m : TruthTableModelModel) : option (list Port) :=
  TruthTableModelMetamodel_getTruthTablePortsOnLinks tr_arg (@allModelLinks _ _ m).
Fixpoint TruthTableModelMetamodel_getTruthTableRowsOnLinks (tr_arg : TruthTable) (l : list TruthTableModelMetamodel_ELink) : option (list Row) :=
match l with
| (Build_TruthTableModelMetamodel_ELink TruthTableRowsEReference (BuildTruthTableRows TruthTable_ctr rows_ctr)) :: l' => 
	  if beq_TruthTable TruthTable_ctr tr_arg then Some rows_ctr else TruthTableModelMetamodel_getTruthTableRowsOnLinks tr_arg l'
| _ :: l' => TruthTableModelMetamodel_getTruthTableRowsOnLinks tr_arg l'
| nil => None
end.

Definition getTruthTableRows (tr_arg : TruthTable) (m : TruthTableModelModel) : option (list Row) :=
  TruthTableModelMetamodel_getTruthTableRowsOnLinks tr_arg (@allModelLinks _ _ m).

Fixpoint TruthTableModelMetamodel_getRowCellsOnLinks (ro_arg : Row) (l : list TruthTableModelMetamodel_ELink) : option (list Cell) :=
match l with
| (Build_TruthTableModelMetamodel_ELink RowCellsEReference (BuildRowCells Row_ctr cells_ctr)) :: l' => 
	  if beq_Row Row_ctr ro_arg then Some cells_ctr else TruthTableModelMetamodel_getRowCellsOnLinks ro_arg l'
| _ :: l' => TruthTableModelMetamodel_getRowCellsOnLinks ro_arg l'
| nil => None
end.

Definition getRowCells (ro_arg : Row) (m : TruthTableModelModel) : option (list Cell) :=
  TruthTableModelMetamodel_getRowCellsOnLinks ro_arg (@allModelLinks _ _ m).
Fixpoint TruthTableModelMetamodel_getRowOwnerOnLinks (ro_arg : Row) (l : list TruthTableModelMetamodel_ELink) : option (TruthTable) :=
match l with
| (Build_TruthTableModelMetamodel_ELink RowOwnerEReference (BuildRowOwner Row_ctr owner_ctr)) :: l' => 
	  if beq_Row Row_ctr ro_arg then Some owner_ctr else TruthTableModelMetamodel_getRowOwnerOnLinks ro_arg l'
| _ :: l' => TruthTableModelMetamodel_getRowOwnerOnLinks ro_arg l'
| nil => None
end.

Definition getRowOwner (ro_arg : Row) (m : TruthTableModelModel) : option (TruthTable) :=
  TruthTableModelMetamodel_getRowOwnerOnLinks ro_arg (@allModelLinks _ _ m).

Fixpoint TruthTableModelMetamodel_getCellPortOnLinks (ce_arg : Cell) (l : list TruthTableModelMetamodel_ELink) : option (Port) :=
match l with
| (Build_TruthTableModelMetamodel_ELink CellPortEReference (BuildCellPort Cell_ctr port_ctr)) :: l' => 
	  if beq_Cell Cell_ctr ce_arg then Some port_ctr else TruthTableModelMetamodel_getCellPortOnLinks ce_arg l'
| _ :: l' => TruthTableModelMetamodel_getCellPortOnLinks ce_arg l'
| nil => None
end.

Definition getCellPort (ce_arg : Cell) (m : TruthTableModelModel) : option (Port) :=
  TruthTableModelMetamodel_getCellPortOnLinks ce_arg (@allModelLinks _ _ m).
Fixpoint TruthTableModelMetamodel_getCellOwnerOnLinks (ce_arg : Cell) (l : list TruthTableModelMetamodel_ELink) : option (Row) :=
match l with
| (Build_TruthTableModelMetamodel_ELink CellOwnerEReference (BuildCellOwner Cell_ctr owner_ctr)) :: l' => 
	  if beq_Cell Cell_ctr ce_arg then Some owner_ctr else TruthTableModelMetamodel_getCellOwnerOnLinks ce_arg l'
| _ :: l' => TruthTableModelMetamodel_getCellOwnerOnLinks ce_arg l'
| nil => None
end.

Definition getCellOwner (ce_arg : Cell) (m : TruthTableModelModel) : option (Row) :=
  TruthTableModelMetamodel_getCellOwnerOnLinks ce_arg (@allModelLinks _ _ m).

Fixpoint TruthTableModelMetamodel_getPortOwnerOnLinks (po_arg : Port) (l : list TruthTableModelMetamodel_ELink) : option (TruthTable) :=
match l with
| (Build_TruthTableModelMetamodel_ELink PortOwnerEReference (BuildPortOwner Port_ctr owner_ctr)) :: l' => 
	  if beq_Port Port_ctr po_arg then Some owner_ctr else TruthTableModelMetamodel_getPortOwnerOnLinks po_arg l'
| _ :: l' => TruthTableModelMetamodel_getPortOwnerOnLinks po_arg l'
| nil => None
end.

Definition getPortOwner (po_arg : Port) (m : TruthTableModelModel) : option (TruthTable) :=
  TruthTableModelMetamodel_getPortOwnerOnLinks po_arg (@allModelLinks _ _ m).
Fixpoint TruthTableModelMetamodel_getPortCellsOnLinks (po_arg : Port) (l : list TruthTableModelMetamodel_ELink) : option (list Cell) :=
match l with
| (Build_TruthTableModelMetamodel_ELink PortCellsEReference (BuildPortCells Port_ctr cells_ctr)) :: l' => 
	  if beq_Port Port_ctr po_arg then Some cells_ctr else TruthTableModelMetamodel_getPortCellsOnLinks po_arg l'
| _ :: l' => TruthTableModelMetamodel_getPortCellsOnLinks po_arg l'
| nil => None
end.

Definition getPortCells (po_arg : Port) (m : TruthTableModelModel) : option (list Cell) :=
  TruthTableModelMetamodel_getPortCellsOnLinks po_arg (@allModelLinks _ _ m).




Definition TruthTableModelMetamodel_defaultInstanceOfEClass (trec_arg: TruthTableModelMetamodel_EClass) : (TruthTableModelMetamodel_getTypeByEClass trec_arg) :=
  match trec_arg with
  | TruthTableEClass => (BuildTruthTable "" "")
  | RowEClass => (BuildRow "")
  | CellEClass => (BuildCell "" true)
  | PortEClass => (BuildPort "" "")
  | OutputPortEClass => (BuildOutputPort (BuildPort "" ""))
  | InputPortEClass => (BuildInputPort (BuildPort "" ""))
  end.

(* TruthTableModelMetamodel accessors *)
(* Done manually *)
Definition TruthTableModelMetamodel_getId (a : TruthTableModelMetamodel_EObject) : string.
Proof.
  destruct a.
  destruct trec_arg.
  * simpl in t. exact (getTruthTableId t).
  * simpl in t. exact (getRowId t).
  * simpl in t. exact (getCellId t).
  * simpl in t. exact (getPortId t).
  * simpl in t. exact (getOutputPortId t).
  * simpl in t. exact (getInputPortId t).
Defined.
Definition TruthTableModelMetamodel_setId (a : TruthTableModelMetamodel_EObject) (s: string) : TruthTableModelMetamodel_EObject.
Proof.
  destruct a.
  destruct trec_arg.
  * simpl in t. exact (setTruthTableId t s).
  * simpl in t. exact (setRowId t s).
  * simpl in t. exact (setCellId t s).
  * simpl in t. exact (setPortId t s).
  * simpl in t. exact (setOutputPortId t s).
  * simpl in t. exact (setInputPortId t s).
Defined.

(* Typeclass Instance *)
Instance TruthTableModelMetamodel : Metamodel TruthTableModelMetamodel_EObject TruthTableModelMetamodel_ELink TruthTableModelMetamodel_EClass TruthTableModelMetamodel_EReference :=
  {
    denoteModelClass := TruthTableModelMetamodel_getTypeByEClass;
    denoteModelReference := TruthTableModelMetamodel_getTypeByEReference;
    toModelClass := TruthTableModelMetamodel_toEClass;
    toModelReference := TruthTableModelMetamodel_toEReference;
    toModelElement := TruthTableModelMetamodel_toEObjectOfEClass;
    toModelLink := TruthTableModelMetamodel_toELinkOfEReference;
    bottomModelClass := TruthTableModelMetamodel_defaultInstanceOfEClass;

    (* Theorems *)
    eqModelClass_dec := TruthTableModelMetamodel_eqEClass_dec;
    eqModelReference_dec := TruthTableModelMetamodel_eqEReference_dec;

    (* Constructors *)
    BuildModelElement := Build_TruthTableModelMetamodel_EObject;
    BuildModelLink := Build_TruthTableModelMetamodel_ELink;

    (* Done manually *)
    getId := TruthTableModelMetamodel_getId;
    setId := TruthTableModelMetamodel_setId;
  }.
  
(* Useful lemmas *)
Lemma TruthTableModel_invert : 
  forall (trec_arg: TruthTableModelMetamodel_EClass) (t1 t2: TruthTableModelMetamodel_getTypeByEClass trec_arg), Build_TruthTableModelMetamodel_EObject trec_arg t1 = Build_TruthTableModelMetamodel_EObject trec_arg t2 -> t1 = t2.
Proof.
  intros.
  inversion H.
  apply inj_pair2_eq_dec in H1.
  exact H1.
  apply TruthTableModelMetamodel_eqEClass_dec.
Qed.