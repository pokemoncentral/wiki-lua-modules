-- Funzioni di libreria di gestione testo

local text = {}

-- Rimuove gli spazi vuoti all'inizio e alla fine di una stringa

string.trim = function(s)
    return tostring(s):match('^%s*(.-)%s*$')
end

text.trim = string.trim

--[[

Rende possibile la string interpolation in stile Python
es.: interp("${name} is ${value}", {name = "foo", value = "bar"}
vedi: http://lua-users.org/wiki/StringInterpolation

--]]

string.interp = function(s, tab)
    return (s:gsub('($%b{})', function(w)
        return tab[w:sub(3, -2)] or w
    end))
end

text.interp = string.interp

--[[

Applica una funzione al primo carattere di una
stringa: la callback deve dunque prendere in
ingresso una stringa, e ritornare una stringa

--]]

string.transformFirst = function(s, transform)
    s = tostring(s)
    return transform(s:sub(1, 1)) .. s:sub(2)
end

string.transform_first = string.transformFirst
text.transformFirst, text.transform_first =
        string.transformFirst, string.transformFirst

-- Rende maiuscola la prima lettera di una stringa

string.firstUppercase = function(s)
    return string.transformFirst(s, string.upper)
end

string.first_uppercase, string.fu, string.ucfirst =
        string.firstUppercase, string.firstUppercase, string.firstUppercase
text.firstUppercase, text.first_uppercase =
        string.firstUppercase, string.firstUppercase
text.fu, text.ucfirst = string.firstUppercase, string.firstUppercase

-- Rende minuscola la prima leggera di una stringa

string.firstLowercase = function(s)
    return string.transformFirst(s, string.lower)
end

string.first_lowercase, string.fl, string.lcfirst =
        string.firstLowercase, string.firstLowercase, string.firstLowercase
text.firstLowercase, text.first_lowercase =
        string.firstLowercase, string.firstLowercase
text.fl, text.lcfirst = string.firstLowercase, string.firstLowercase

--[[

Rende maiuscola la prima lettera di ogni parola
di una stringa

--]]

string.camelCase = function(s)
    return (tostring(s):gsub('(%w[%w%d]*)', string.fu))
end

string.camel_case, string.cc = string.camelCase, string.camelCase
text.camelCase, text.camel_case, text.cc =
        string.camelCase, string.camelCase, string.camelCase

--[[

These functions format integer numbers on a fixed amount of digits, specified
in the second parameter, padding with zeros.

The special case for three figures is usefull because, given that ndexes have
three figures, is widely used.

--]]
string.nFigures = function(n, figures)
    return string.format('%0' .. tostring(figures) .. 'd', n)
end
string.n_figures = string.nFigures
text.nFigures, text.n_figures = string.n_figures, string.nFigures

string.threeFigures = function(n)
	return string.format('%03d', n)
end

string.three_figures, string.tf = string.threeFigures, string.threeFigures
text.threeFigures, text.three_figures, text.tf =
        string.threeFigures, string.threeFigures, string.threeFigures

--[[

Ritorna il numero intero presete all'inizio
della stringa passata come argomento.
Salta eventuali spaziature iniziali e accetta
anche un segno, '+' o '-', in prima posizione

--]]

string.parseInt = function(s)

    -- Evito inuliti computazioni se l'input è già un numero

    if type(s) == 'number' then
        return s
    end
    return tonumber(tostring(s):match('^%s*([%-%+]?%d+)'))
end

string.parse_int = string.parseInt
text.parseInt, text.parse_int = string.parseInt, string.parseInt

--[[

Ritorna il numero, intero o reale, presente
all'inizio della stringa passata come argomento.
Salta eventuali spaziature iniziali e accetta
anche il segno ('+' o '-') in prima posizione.
La parte intera può anche essere omessa (es '.5'),
nel qual caso è posta a zero.

--]]

string.parseNumber = function(s)

    -- Evito inuliti computazioni se l'input è già un numero

    if type(s) == 'number' then
        return s
    end
    return tonumber(tostring(s):match('^%s*([%-%+]?%d*%.?%d+)'))
end

string.parse_number = string.parseNumber
text.parseNumber, text.parse_number = string.parseNumber, string.parseNumber

--[[

Converts a number to string. If it's an
integer, it has no decimal digits, otherwise
the specified format is used, which defaults
to two decimal digits. The decimal separator
is comma.

--]]
string.printNumber = function(value, format)
    return math.floor(value) == math.ceil(value)
            and tostring(value)
            or (string.format(format or '%.2f', value):gsub('%.', '%,'))
end
string.print_number, string.printnumber =
    string.printNumber, string.printNumber
text.printNumber, text.print_number, text.printnumber =
    string.printNumber, string.printNumber, string.printNumber

return text
