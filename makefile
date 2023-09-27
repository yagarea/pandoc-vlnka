SHELL=/usr/bin/sh
MAKEFLAGS += --silent

.PHONY: build

build:
	mkdir -p build
	echo "Compiling..."
	ghc -dynamic ./src/vlnka.hs -o ./build/vlnka
	echo "Done."
	chmod +x ./build/vlnka

test:
	pandoc --filter ./tests/ast_dump.sh  --to=markdown -o /dev/null ./tests/test_text1.tex
	pandoc --filter ./build/vlnka ./tests/test_text1.tex -o ./tests/test_output.md
	diff ./tests/test_output.md ./tests/test_output_expected.md
