import Data.Char
import Data.String
import Text.Pandoc.JSON
import qualified Data.Text as T
import Numeric

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
isThisStringNumber testedString =
    case (readFloat testedString) of
        [(num, "")] -> True
        _ -> False

endsWithNumber :: String -> Bool
endsWithNumber testedString = isThisStringNumber (last (words testedString))

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
addGlueToWord (word1, word2) = if shouldHaveVlnka (word1, word2) then concat [word1, "~"] else concat [word1, " "]

---------------------------------------------------------------------------------------
-- vlnka

shouldHaveVlnka :: (String, String) -> Bool
shouldHaveVlnka pairOfWords = foldr (||) False [
    isNumberWithUnit pairOfWords,
    isJednoslabicnaPredlozka (fst pairOfWords),
    isNumberWithAcronym pairOfWords,
    isMarkWithNumber pairOfWords]


vlnka_ast :: [Inline] -> [Inline]
vlnka_ast [] = []
vlnka_ast [a] = [a]
vlnka_ast [a,b] = [a,b]
vlnka_ast (Str a: Text.Pandoc.JSON.Space : Str b : rest) |  shouldHaveVlnka (T.unpack a, T.unpack b) =  vlnka_ast ((Str (T.concat [a, T.pack "\160", b])) : rest )
vlnka_ast (a : rest) = a : vlnka_ast rest

vlnka :: T.Text -> T.Text
vlnka text = T.pack (vlnka_str (T.unpack text))

vlnka_str :: String -> String
vlnka_str text = strip (foldr (++) "" (map addGlueToWord (getPairsOfListMemebers(words text))))

--vlnka_inline :: Inline -> Inline
--vlnka_inline (Str text) = Str (vlnka text)
--vlnka_inline (Emph inlines) = Emph (map vlnka_inline inlines)
--vlnka_inline (Strong inlines) = Strong (map vlnka_inline inlines)
--vlnka_inline (Strikeout inlines) = Strikeout (map vlnka_inline inlines)
--vlnka_inline (Superscript inlines) = Superscript (map vlnka_inline inlines)
--vlnka_inline (Subscript inlines) = Subscript (map vlnka_inline inlines)
--vlnka_inline (SmallCaps inlines) = SmallCaps (map vlnka_inline inlines)
--vlnka_inline (Quoted quoteType inlines) = Quoted quoteType (map vlnka_inline inlines)
--vlnka_inline (Cite citations inlines) = Cite citations (map vlnka_inline inlines)
--vlnka_inline (Code attr text) = Code attr text
--vlnka_inline (Text.Pandoc.JSON.Space) = Text.Pandoc.JSON.Space
--vlnka_inline (SoftBreak) = SoftBreak
--vlnka_inline (LineBreak) = LineBreak
--vlnka_inline (Math mathType text) = Math mathType text
--vlnka_inline (RawInline format text) = RawInline format text
--vlnka_inline (Link attr inlines target) = Link attr (map vlnka_inline inlines) target
--vlnka_inline (Image attr inlines target) = Image attr (map vlnka_inline inlines) target
--vlnka_inline (Note blocks) = Note blocks
--vlnka_inline (Span attr inlines) = Span attr (map vlnka_inline inlines)





main = toJSONFilter vlnka_ast

