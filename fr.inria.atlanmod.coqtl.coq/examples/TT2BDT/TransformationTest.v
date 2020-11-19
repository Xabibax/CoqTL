Require Import String.
Require Import List.

Require Import core.CoqTL.
Require Import core.utils.tPrint.

Require Import examples.TT2BDT.TTMetamodel.
Require Import examples.TT2BDT.BDDMetamodel.
Require Import examples.TT2BDT.TT2BDD.
Require Import examples.TT2BDT.TTModel_1.

Time Compute (execute TT2BDD TTModel_1).

