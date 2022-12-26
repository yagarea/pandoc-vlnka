
vlnka :: str -> str

isJednoslabicnaPredlozka :: str -> bool
isJednoslabicnaPredlozka str = case str of
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


