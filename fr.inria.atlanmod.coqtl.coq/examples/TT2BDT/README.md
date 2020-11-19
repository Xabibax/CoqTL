# TT2BDT

## Prepare the working environment

Go to the root of the project  
```bash
$ pwd
/home/xabi/fr.inria.atlanmod.coqtl.coq
```

Then generate coq files :

```bash
make clean && \
coq_makefile -f _CoqProject -o Makefile && \
make
```

Then you can edit the *.v files and use the proof mode.

## Execution

Open the TransformationTest.v and start the proof mode

You can change the model to test by replacing the input model

```coq
Require Import String.
Require Import List.

Require Import core.CoqTL.
Require Import core.utils.tPrint.

Require Import examples.TT2BDT.TTMetamodel.
Require Import examples.TT2BDT.BDDMetamodel.
Require Import examples.TT2BDT.TT2BDD.
Require Import examples.TT2BDT.*InputModel*.

Time Compute (execute TT2BDD *InputModel*).
```

## Create a model

Name a *.v file and make a Definition called InputModel and write your model :

```coq
Definition InputModel : Model TruthTableMetamodel_EObject TruthTableMetamodel_ELink :=
 (* TODO*)
 .
```


