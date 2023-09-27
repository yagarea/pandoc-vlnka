SHELL=/usr/bin/sh
MAKEFLAGS += --silent

.PHONY: build

build:
	echo "Compiling..."
	ghc -dynamic ./src/vlnka.hs -o vlnka
	echo "Done."
