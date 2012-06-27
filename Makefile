

.PHONY: entries test install all
entries:
	ocamlbuild -cflags -I,+camlp4 entries.cmo

test:
	camlp4rf _build/entries.cmo test.ml

install:
	cp _build/entries.cmo ../lib/

all:  entries