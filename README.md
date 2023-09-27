# Pandoc-vlnka

This is pandoc filter for adding nonbreakable spaces (`~`) to text in Czech language.
Everything is written in haskell.


## [Build instruction](https://github.com/yagarea/pandoc-vlnka/blob/master/docs/build.md) | [Vlnka library documnetation](https://github.com/yagarea/pandoc-vlnka/blob/master/docs/library-doc.md)

### Usage
After compilation you can use the executable file as a pandoc filter.

Example usage:

```sh
pandoc input-file --filter vlnka -o output file
```

### Tests
To test this program you have to:
1. Build it (`make build`)
2. Run tests (`make test`)

This will run vlnka as filter on example `.tex` file and check if it outputs expected output.

In case if it does not work it will print diff of expected output and actual output.

### License
This project is published under [GPLv3 license](https://github.com/yagarea/pandoc-vlnka/blob/master/LICENSE).

