# Pandoc-vlnka library

## Czech language parsing functions
The code defines several functions used to find cases where should be non-breakable space:

- `isJednoslabicnaPredlozka :: String -> Bool`: Checks if a given word is a one-syllable preposition.
- `isThisStringNumber :: String -> Bool`: Determines if a string represents a number.
- `endsWithNumber :: String -> Bool`: Checks if a string ends with a number.
- `isThisStringUnit :: String -> Bool`: Identifies strings representing units (e.g., "%", "Kč"). If you want to add new unit, just add case to [this function](https://github.com/yagarea/pandoc-vlnka/blob/771262f159d4e319a73a381cd6424a3f65ac8dbb/src/vlnka.hs#L59)
- `isNumberWithUnit :: (String, String) -> Bool`: Combines number and unit checks to identify number-unit pairs.
- `isThisStringMark :: String -> Bool`: Identifies specific marks (e.g., "§", "#"). If you want to add new mark, you can easily add it into the [fuction itself](https://github.com/yagarea/pandoc-vlnka/blob/771262f159d4e319a73a381cd6424a3f65ac8dbb/src/vlnka.hs#L76)
- `isMarkWithNumber :: (String, String) -> Bool`: Combines mark and number checks to identify mark-number pairs.
- `isNumberWithAcronym :: (String, String) -> Bool`: Checks for number-acronym pairs.

The main logic for adding non-breakable spaces is implemented in the `vlnka_ast` function,
works directly on pandocs syntax tree by processing a list of inline elements and inserts
non-breakable spaces where appropriate based on the rules defined in the above functions.


## Main functions

After loading `vlnka.hs` to your project you will gain access to vlnka function:

- `vlnka_txt :: Text -> Text` : Add non breakable spaces to string of Czech text
- `vlnka_ast :: [inline] -> [inline]` : add non breakable space into pandocs ATS. This funtion is called when used as filter.
- `vlnka :: String -> String` : Add non breakable spaces to string of Czech text

