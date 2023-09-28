import Data.Char
import Data.String
import Text.Pandoc.JSON
import qualified Data.Text as T
import Numeric

---------------------------------------------------------------------------------------
-- Jednoslabíčné předložky

isJednoslabicnaPredlozka :: String -> Bool
isJednoslabicnaPredlozka potentialPredlozka = case map toLower potentialPredlozka of
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
isThisStringNumber testedString =
    case (readFloat testedString) of
        [(num, "")] -> True
        _ -> False

endsWithNumber :: String -> Bool
endsWithNumber "" = False
endsWithNumber testedString = isThisStringNumber (last (words testedString))

isThisStringUnit :: String -> Bool
isThisStringUnit testedString = case testedString of
    "%" -> True
    "Kč" -> True
    "$" -> True
    "€" -> True
    "°C" -> True
    "C" -> True
    "°F" -> True
    "F" -> True
    "°K" -> True
    "K" -> True
    "°" -> True
    "m" -> True
    "cm" -> True
    "mm" -> True
    "km" -> True
    "kg" -> True
    "g" -> True
    "mg" -> True
    "l" -> True
    "ml" -> True
    _ -> False

isNumberWithUnit :: (String, String) -> Bool
isNumberWithUnit (potentialNumber, potentialMark) = and [(endsWithNumber potentialNumber), (isThisStringUnit potentialMark)]

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
isNumberWithAcronym (potentialNumber, potentialAcronym) = potentialAcronym /= "" && (isThisStringNumber potentialNumber) && (head ( reverse potentialAcronym) == '.')

---------------------------------------------------------------------------------------
-- stringové funkce

strip :: String -> String
strip text = reverse (dropWhile isSpace (reverse (dropWhile isSpace text)))

getPairsOfListMemebers :: [String] -> [(String,String)]
getPairsOfListMemebers [] = []
getPairsOfListMemebers [a] = [(a, "")]
getPairsOfListMemebers list = concat [[(head (list), head (tail list))], getPairsOfListMemebers (tail list)]

addGlueToWord :: (String, String) -> String
addGlueToWord (word1, word2) = if (shouldHaveVlnka "" word1 word2) then concat [word1, "~"] else concat [word1, " "]

---------------------------------------------------------------------------------------
-- vlnka

shouldHaveVlnka :: String -> String -> String -> Bool
shouldHaveVlnka pre a b = (not (isNumberWithUnit (pre, a))) && (foldr (||) False [
    isNumberWithUnit (a, b),
    isJednoslabicnaPredlozka a,
    isNumberWithAcronym (a, b),
    isMarkWithNumber (a, b)])

safe_head :: [String] -> String
safe_head [] = ""
safe_head list = head list

vlnka_ast :: String -> [Inline] -> [Inline]
vlnka_ast _ [] = []
vlnka_ast _ [a] = [a]
vlnka_ast _ [a,b] = [a,b]
vlnka_ast prev (a : Text.Pandoc.JSON.Space : b : rest)
    | shouldHaveVlnka_Inline prev a b =
        a : (Str (T.pack "\160") : (vlnka_ast (safe_head (unwrap_inline a)) (b : rest)))
vlnka_ast _ (a : rest) = a : vlnka_ast (safe_head (unwrap_inline a)) rest


shouldHaveVlnka_Inline :: String -> Inline -> Inline -> Bool
shouldHaveVlnka_Inline prev a b = case ( unwrap_inline a , unwrap_inline b ) of
    ([], _) -> False
    (_, []) -> False
    (x,y) -> shouldHaveVlnka prev (last x) (head y)


vlnka_txt :: T.Text -> T.Text
vlnka_txt text = T.pack (vlnka (T.unpack text))

vlnka :: String -> String
vlnka text = strip (foldr (++) "" (map addGlueToWord (getPairsOfListMemebers(words text))))

main = toJSONFilter (vlnka_ast "")

unwrap_inline :: Inline -> [String]
unwrap_inline (Str a) = [T.unpack a]
unwrap_inline (Text.Pandoc.JSON.Space) = []
unwrap_inline (SoftBreak) = []
unwrap_inline (LineBreak) = []
unwrap_inline (Emph a) = concat (map unwrap_inline a)
unwrap_inline (Strong a) = concat (map unwrap_inline a)
unwrap_inline (Strikeout a) = concat (map unwrap_inline a)
unwrap_inline (Superscript a) = concat (map unwrap_inline a)
unwrap_inline (Subscript a) = concat (map unwrap_inline a)
unwrap_inline (SmallCaps a) = concat (map unwrap_inline a)
unwrap_inline (Quoted a b) = concat (map unwrap_inline b)
unwrap_inline (Cite a b) = concat (map unwrap_inline b)
unwrap_inline (Code a b) = []
unwrap_inline (Math a b) = []
unwrap_inline (RawInline a b) = []
unwrap_inline (Link a b c) = concat (map unwrap_inline b)
unwrap_inline (Image a b c) = concat (map unwrap_inline b)
unwrap_inline (Note a) = []
unwrap_inline (Span a b) = concat (map unwrap_inline b)

