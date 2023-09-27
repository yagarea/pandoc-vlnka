SHELL=/usr/bin/sh
MAKEFLAGS += --silent

.PHONY: build

build:
	mkdir -p build
	echo "Compiling..."
	ghc -dynamic ./src/vlnka.hs -o ./build/vlnka
	echo "Done."
	chmod +x ./build/vlnka

