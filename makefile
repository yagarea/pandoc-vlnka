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
	rm -f ./tests/test*_output.tex
	pandoc --filter ./tests/ast_dump.sh  --to=markdown -o /dev/null ./tests/test2.tex
	cat /tmp/vlnka-ast-dump.json | jq
	# Test 1
	pandoc --filter ./build/vlnka ./tests/test1.tex -o ./tests/test1_output.tex
	diff ./tests/test1_output.tex ./tests/test1_output_expected.tex
	# Test 2
	pandoc --filter ./build/vlnka ./tests/test2.tex -o ./tests/test2_output.tex
	diff ./tests/test2_output.tex ./tests/test2_output_expected.tex
	# Test 3
	pandoc --filter ./build/vlnka ./tests/test3.tex -o ./tests/test3_output.tex
	diff ./tests/test3_output.tex ./tests/test3_output_expected.tex

clean:
	rm -rf build/*
