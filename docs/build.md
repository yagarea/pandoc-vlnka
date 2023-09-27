# build instruction

## Dependencies
Make shure you have these libraries installed:
- [pandoc-types](https://github.com/jgm/pandoc-types)

## Build
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

add executable flag to new binary:

```sh
chmod +x vlnka
```

