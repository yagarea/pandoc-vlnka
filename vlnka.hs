import Data.Char
import Data.String

---------------------------------------------------------------------------------------
-- Jednoslabíčné předložky

isJednoslabicnaPredlozka :: String -> Bool
isJednoslabicnaPredlozka potentialPredlozka = case potentialPredlozka of
    "bez" -> True
    "dík" -> True
    "dle" -> True
    "do" -> True
    "k" -> True
    "ke" -> True
    "kol" -> True
    "ku" -> True
    "na" -> True
    "nad" -> True
    "o" -> True
    "ob" -> True
    "od" -> True
    "po" -> True
    "pod" -> True
    "přes" -> True
    "při" -> True
    "pro" -> True
    "s" -> True
    "se" -> True
    "skrz" -> True
    "stran" -> True
    "u" -> True
    "v" -> True
    "ve" -> True
    "vně" -> True
    "z" -> True
    "za" -> True
    "ze" -> True
    "zpod" -> True
    _ -> False


---------------------------------------------------------------------------------------
-- čísla s jednotkou

isThisStringNumber :: String -> Bool
isThisStringNumber testedString = (all isNumber testedString) && ((length testedString) /= 0)


isThisStringUnit :: String -> Bool
isThisStringUnit testedString = case testedString of
    "%" -> True
    "Kč" -> True
    "$" -> True
    "€" -> True
    "°C" -> True
    "°F" -> True
    "°K" -> True
    "°" -> True
    _ -> False

isNumberWithUnit :: (String, String) -> Bool
isNumberWithUnit (potentialNumber, potentialMark) = and [(isThisStringNumber potentialNumber), (isThisStringUnit potentialMark)]

---------------------------------------------------------------------------------------
-- značka s číslem

isThisStringMark :: String -> Bool
isThisStringMark potentialMark = case potentialMark of
    "§" -> True
    "§§" -> True
    "#" -> True
    "*" -> True
    "†" -> True
    _ -> False

isMarkWithNumber :: (String, String) -> Bool
isMarkWithNumber (potentialMark, potentialNumber) = and [(isThisStringNumber potentialNumber), (isThisStringUnit potentialMark)]

---------------------------------------------------------------------------------------
-- číslo a zkratka počíteného předmětu

isNumberWithAcronym :: (String, String) -> Bool
isNumberWithAcronym (potentialNumber, potentialAcronym) = and [(isThisStringNumber potentialNumber),
    (head ( reverse potentialAcronym) == '.')]

---------------------------------------------------------------------------------------
-- stringové funkce

strip :: String -> String
strip text = reverse (dropWhile isSpace (reverse (dropWhile isSpace text)))

getPairsOfListMemebers :: [String] -> [(String,String)]
getPairsOfListMemebers [] = []
getPairsOfListMemebers [a] = [(a, "")]
getPairsOfListMemebers list = concat [[(head (list), head (tail list))], getPairsOfListMemebers (tail list)]

addGlueToWord :: (String, String) -> String
addGlueToWord (word1, word2) = if shouldHaveVlnka (word1, word2) then concat [word1, "~"] else concat [word1, " "]

---------------------------------------------------------------------------------------
-- vlnka

shouldHaveVlnka :: (String, String) -> Bool
shouldHaveVlnka pairOfWords = foldr (||) False [
    isNumberWithUnit pairOfWords,
    isJednoslabicnaPredlozka (fst pairOfWords),
    isNumberWithAcronym pairOfWords,
    isMarkWithNumber pairOfWords]


vlnka :: String -> String
vlnka text = strip (foldr (++) "" (map addGlueToWord (getPairsOfListMemebers(words text))))

main = interact vlnka

