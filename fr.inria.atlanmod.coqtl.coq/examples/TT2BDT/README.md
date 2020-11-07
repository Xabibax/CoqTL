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

Then you can edit the *.v files.
