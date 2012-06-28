

.PHONY: entries test install all
entries:
	ocamlbuild -cflags -I,+camlp4 pa_entries.cmo

test:
	camlp4rf _build/pa_entries.cmo test.ml

install:
	cp _build/entries.cmo ../lib/

all:  entries