import Data.Char



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


isThisStringNumber :: String -> Bool
isThisStringNumber testedString = (all isNumber testedString) && ((length testedString) /= 0)


isThisStringMark :: String -> Bool
isThisStringMark testedString = case testedString of
    "%" -> True
    "§" -> True
    "Kč" -> True
    "$" -> True
    _ -> False


isNumberWithMark :: String -> String -> Bool
isNumberWithMark potentialNumber potentialMark = and [(isThisStringNumber potentialNumber), (isThisStringMark potentialMark)]

ovlnkujPredlozky :: [String] -> [String]
ovlnkujPredlozky slova = concatMap (\slovo -> if (isJednoslabicnaPredlozka slovo) then [slovo, "~"] else [slovo]) slova

addSpaces :: [String] -> [String]
-- adds spaces between words as another element of the list
addSpaces words = concatMap (\word -> if (((length word) == 1) && (last word == '~')) then [word] else [word, " "]) words

addSpacesRec :: [String] -> [String]
addSpacesRec [] = []
addSpacesRec (x:xs) = if (((length x) == 1) && (last x == '~')) then x : addSpacesRec xs else x : " " : addSpacesRec xs
---------------------------------------------------------------------------------------

vlnka :: String -> String
vlnka text = foldr (++) "" (addSpaces (ovlnkujPredlozky (words text)))
