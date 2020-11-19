# Sensibilisation à la recherche

## Introduction

This project is a fork from [CoqTL Library](https://github.com/atlanmod/CoqTL).  
The latest version of this project can be found [here](https://github.com/Xabibax/CoqTL/tree/xabi_branch/fr.inria.atlanmod.coqtl.coq).  
This project goal is to produce a Binary Decision Tree from a Truth Table with the CoqTL.

In this project we tried to use the CoqTL Library to transform Ecore models and ATL Transformation into Coq valid operations.

## Requirement

* [Coq 8.12](https://coq.inria.fr/opam-using.html)  
* [MathComp](https://github.com/math-comp/math-comp/tree/mathcomp-1.6.4)  

### Quick install (ubuntu)

```bash
### Install OPAM 2.X
sudo apt-get install opam
opam --version # should print 2.x.y

### Initialize OPAM
opam init -n --comp=ocaml-base-compiler.4.05.0
eval $(opam config env)

### Install Coq and MatComp
opam repo add coq-released https://coq.inria.fr/opam/released
opam pin add -n coq -k version 8.12.0
opam install coq -j3
opam install coq-mathcomp-ssreflect -j3
```

## Prepare the working environment

Go to the root of the project  

```bash
$ pwd
/home/xabi/fr.inria.atlanmod.coqtl.coq
```

Then generate coq files ($ ./clean.sh && ./compile.sh):

```bash
make clean && \
coq_makefile -f _CoqProject -o Makefile && \
make
```

Then you can edit the *.v files and use the proof mode.

## Execution

The TruthTable to BinaryDecisionDiagram solution can be found n : fr.inria.atlanmod.coqtl.coq/coq/examples/TT2BDT

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
Require Import examples.TT2BDT.<InputModel>.

Time Compute (execute TT2BDD <InputModel>).
```

## Algorithm

The solution is based on the The TTC 2019 TT2BDD Case contest solution presented by Antonio [García-Domínguez](https://www.cs.aston.ac.uk/~garcia-a/)

A visualization of the algorithm can be found [here](https://docs.google.com/presentation/d/1rq_Q0wgN0IKiFUgEF11RKP6j1lDEobrQiKc8ky9uXt0/edit?usp=sharing)
