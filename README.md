# Pandoc-vlnka

This is pandoc filter for adding nonbreakable spaces (`~`) to text in Czech language.
Everything is written in haskell.


## [Build instruction](https://github.com/yagarea/pandoc-vlnka/blob/master/docs/build.md) | [Vlnka library documnetation](https://github.com/yagarea/pandoc-vlnka/blob/master/docs/library-doc.md)

### As filter
After compilation you can use the executable file as a pandoc filter.

Example usage:

```sh
pandoc input-file --filter vlnka -o output file
```

## License
This project is published under GPLv3 license.
