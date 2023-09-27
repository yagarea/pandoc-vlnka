SHELL=/usr/bin/sh
MAKEFLAGS += --silent

.PHONY: build

build:
	echo "Compiling..."
	ghc -dynamic vlnka.hs -o vlnka
	echo "Done."
