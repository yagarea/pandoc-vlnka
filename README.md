# pandoc-vlnka

This is pandoc filter for adding nonbreakable spaces (`~`) to text in Czech language.
Everything is written in haskell.

## Compilation
To compile this you have to first clone this repository to your machine.

```sh
git clone https://github.com/yagarea/pandoc-vlnka
```

Then Open the directory with source code

```sh
cd pandoc-vlnka
```

and as a last step compile source code with `ghc`

```sh
ghc -dynamic vlnka.hs
```

## Usage

### As filter
After compilation you can use the executable file as a pandoc filter.

Example usage:

```sh
pandoc --filter vlnka --to=html
```

### As haskell library
After loading `vlnka.hs` to your project you will gain access to vlnka function:

```
vlnka :: String -> String
```

This function takes czech text as an input and outputs the same text with nonbreakable spaces.

## License
This project is published under GPLv3 license.
