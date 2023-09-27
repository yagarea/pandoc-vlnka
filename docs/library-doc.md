# Pandoc-vlnka library

The code defines several functions to determine which pairs of words should have non-breakable spaces:

- `isJednoslabicnaPredlozka :: String -> Bool`: Checks if a given word is a one-syllable preposition.
- `isThisStringNumber`: Determines if a string represents a number.
- `endsWithNumber`: Checks if a string ends with a number.
- `isThisStringUnit`: Identifies strings representing units (e.g., "%", "Kč").
- `isNumberWithUnit`: Combines number and unit checks to identify number-unit pairs.
- `isThisStringMark`: Identifies specific marks (e.g., "§", "#").
- `isMarkWithNumber`: Combines mark and number checks to identify mark-number pairs.
- `isNumberWithAcronym`: Checks for number-acronym pairs.

The main logic for adding non-breakable spaces is implemented in the `vlnka_ast` function, which processes a list of inline elements and inserts non-breakable spaces where appropriate based on the rules defined in the above functions.
Other Functions

    strip: Removes leading and trailing whitespace from a string.
    getPairsOfListMembers: Converts a list of words into a list of word pairs.
    addGlueToWord: Adds a non-breakable space ("~") or regular space between word pairs.
    shouldHaveVlnka: Determines whether a pair of words should have a non-breakable space based on the defined rules.



After loading `vlnka.hs` to your project you will gain access to vlnka function:

```hs
vlnka :: String -> String
```

This function takes czech text as an input and outputs the same text with nonbreakable spaces.

