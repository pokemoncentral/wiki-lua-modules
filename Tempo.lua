--[[

Funzioni legate all'orario che restano corrette anche quando la pagina
è in cache. Il server calcola un valore di riserva, valido al momento
del parsing, e MediaWiki:Tempo.js lo aggiorna nel browser con l'orario
attuale del visitatore.

Fusi orari (parametro tz):
- utc (predefinito)
- local: fuso del wiki (Europe/Rome)
- user: fuso del visitatore; senza JS si usa quello del wiki
- un identificatore IANA, es. Asia/Tokyo; senza JS si usa UTC

Date in ingresso: ISO 8601 (aaaa-mm-gg, eventualmente seguito da
Thh:mm[:ss] e da Z o ±hh:mm; senza fuso vale UTC) oppure @<secondi Unix>.

Usato da Template:Ora e Template:Switch a tempo.

--]]

local t = {}

-- stylua: ignore
local mw = require('mw')

local lang = mw.language.getContentLanguage()
local trim = mw.text.trim

-- Parametri riservati di switch: tutti gli altri sono casi
local RISERVATI = {
    formato = true,
    tz = true,
    default = true,
    inline = true,
    start = true,
    ["end"] = true,
    intervalli = true,
    prima = true,
    durante = true,
    dopo = true,
    fuori = true,
}

local function getArgs(frame)
    for _ in pairs(frame.args) do
        return frame.args
    end
    return frame:getParent().args
end

local function errore(msg)
    return '<strong class="error">' .. msg .. "</strong>"
end

local function intero(n)
    return string.format("%d", n)
end

local function normTz(tz)
    tz = trim(tz or "")
    local low = tz:lower()
    if low == "" then
        return "utc"
    end
    if low == "utc" or low == "local" or low == "user" then
        return low
    end
    if tz:match("^[%w_+%-]+/[%w_+%-/]+$") then
        return tz
    end
    return "utc"
end

-- Valore di riserva calcolato dal server
local function formatta(formato, ts, tz)
    local ok, res = pcall(
        lang.formatDate,
        lang,
        formato,
        "@" .. intero(ts),
        tz == "local" or tz == "user"
    )
    return ok and res or ""
end

local function daysFromCivil(y, m, d)
    if m <= 2 then
        y = y - 1
    end
    local era = math.floor(y / 400)
    local yoe = y - era * 400
    local mp = (m + 9) % 12
    local doy = math.floor((153 * mp + 2) / 5) + d - 1
    local doe = yoe * 365 + math.floor(yoe / 4) - math.floor(yoe / 100) + doy
    return era * 146097 + doe - 719468
end

--[[
Converte una data ISO 8601 o @<secondi Unix> in secondi Unix;
nil se non valida.
--]]
t.parseIso = function(s)
    s = trim(s or "")
    local unix = s:match("^@(%-?%d+)$")
    if unix then
        return tonumber(unix)
    end
    local y, mo, d, resto = s:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)(.*)$")
    if not y then
        return nil
    end
    y, mo, d = tonumber(y), tonumber(mo), tonumber(d)
    if mo < 1 or mo > 12 or d < 1 or d > 31 then
        return nil
    end
    local h, mi, sec = 0, 0, 0
    local hh, mm, coda = resto:match("^[T ](%d%d):(%d%d)(.*)$")
    if hh then
        h, mi, resto = tonumber(hh), tonumber(mm), coda
        local ss, coda2 = resto:match("^:(%d%d)(.*)$")
        if ss then
            sec, resto = tonumber(ss), coda2
        end
    end
    local offset = 0
    if resto ~= "" and resto ~= "Z" then
        local segno, oh, om = resto:match("^([+-])(%d%d):?(%d%d)$")
        if not segno then
            return nil
        end
        offset = (tonumber(oh) * 60 + tonumber(om)) * 60
        if segno == "-" then
            offset = -offset
        end
    end
    return daysFromCivil(y, mo, d) * 86400 + h * 3600 + mi * 60 + sec - offset
end

--[[
Una chiave di caso è un elenco separato da virgole di valori (confronto
esatto, senza distinzione di maiuscole) o di intervalli numerici a-b;
se a > b l'intervallo scavalca lo zero (20-3 = 20, 21, 22, 23, 0, 1, 2, 3).
Stessa logica di MediaWiki:Tempo.js.
--]]
local function corrisponde(chiave, valore)
    local num = valore:match("^%-?%d+$") and tonumber(valore)
    local low = mw.ustring.lower(valore)
    for parte in mw.text.gsplit(chiave, ",", true) do
        parte = trim(parte)
        local a, b = parte:match("^(%d+)%s*%-%s*(%d+)$")
        if a then
            if num then
                a, b = tonumber(a), tonumber(b)
                if
                    (a <= b and num >= a and num <= b)
                    or (a > b and (num >= a or num <= b))
                then
                    return true
                end
            end
        elseif num and parte:match("^%-?%d+$") then
            if tonumber(parte) == num then
                return true
            end
        elseif mw.ustring.lower(parte) == low then
            return true
        end
    end
    return false
end

-- Stato rispetto a un elenco di intervalli { inizio, fine } (nil = aperto)
local function statoIntervalli(lista, ora)
    if #lista == 0 then
        return nil
    end
    local minInizio, maxFine = math.huge, -math.huge
    for _, iv in ipairs(lista) do
        local s, e = iv[1] or -math.huge, iv[2] or math.huge
        if ora >= s and ora < e then
            return "durante"
        end
        minInizio = math.min(minInizio, s)
        maxFine = math.max(maxFine, e)
    end
    if ora < minInizio then
        return "prima"
    end
    if ora >= maxFine then
        return "dopo"
    end
    return "fuori"
end

local function nodoCaso(radice, tag, contenuto, visibile)
    if contenuto:match("^[*#:;]") or contenuto:match("^{|") then
        contenuto = "\n" .. contenuto .. "\n"
    end
    return radice
        :tag(tag)
        :addClass("tempo-caso")
        :css("display", visibile and "contents" or "none")
        :wikitext(contenuto)
end

--[[
{{#invoke: Tempo | ora | <formato> | tz= | time= | live=yes | maiuscola=yes }}
Data/ora nel formato di #time; time= per una data fissa invece dell'ora attuale.
--]]
t.ora = function(frame)
    local args = getArgs(frame)
    local formato = args[1] or args.formato
    if not formato or trim(formato) == "" then
        return errore("Ora: specificare il formato")
    end
    formato = trim(formato)
    local tz = normTz(args.tz)
    local ts = os.time()
    local fisso = args.time and trim(args.time) ~= ""
    if fisso then
        ts = t.parseIso(args.time)
        if not ts then
            return errore("Ora: data non valida: " .. mw.text.nowiki(args.time))
        end
    end
    local testo = formatta(formato, ts, tz)
    local maiuscola = args.maiuscola == "yes"
    if maiuscola then
        testo = lang:ucfirst(testo)
    end
    local span = mw.html
        .create("span")
        :addClass("tempo-ora")
        :attr("data-formato", formato)
        :attr("data-tz", tz)
    if fisso then
        span:attr("data-time", intero(ts))
    end
    if args.live == "yes" then
        span:attr("data-live", "1")
    end
    if maiuscola then
        span:attr("data-maiuscola", "1")
    end
    return tostring(span:wikitext(mw.text.nowiki(testo)))
end

--[[
Switch a tempo, in due modalità:
- intervalli: start= / end= oppure intervalli=inizio/fine;inizio/fine,
  casi prima, durante, dopo, fuori;
- valore: formato= (codici di #time) e tz=, casi con chiavi come
  1,5,9 oppure 4-9 oppure lunedì, più default.
inline=yes usa span invece di div.
--]]
t.switch = function(frame)
    local args = getArgs(frame)
    local tag = args.inline == "yes" and "span" or "div"
    local radice =
        mw.html.create(tag):addClass("tempo-switch"):css("display", "contents")
    local ora = os.time()

    if args.intervalli or args.start or args["end"] then
        local lista, codificati = {}, {}
        local function aggiungi(s, e)
            s, e = trim(s or ""), trim(e or "")
            local ts, te
            if s ~= "" then
                ts = t.parseIso(s)
                if not ts then
                    return s
                end
            end
            if e ~= "" then
                te = t.parseIso(e)
                if not te then
                    return e
                end
            end
            table.insert(lista, { ts, te })
            table.insert(
                codificati,
                (ts and intero(ts) or "") .. "/" .. (te and intero(te) or "")
            )
        end
        local sbagliato
        if args.start or args["end"] then
            sbagliato = aggiungi(args.start, args["end"])
        end
        if not sbagliato and args.intervalli then
            for pezzo in mw.text.gsplit(args.intervalli, ";", true) do
                pezzo = trim(pezzo)
                if pezzo ~= "" then
                    local s, e = pezzo:match("^([^/]*)/([^/]*)$")
                    if not s then
                        sbagliato = pezzo
                        break
                    end
                    sbagliato = aggiungi(s, e)
                    if sbagliato then
                        break
                    end
                end
            end
        end
        if sbagliato then
            return errore(
                "Switch a tempo: data o intervallo non valido: "
                    .. mw.text.nowiki(sbagliato)
            )
        end

        local scelto = statoIntervalli(lista, ora) or "fuori"
        if args[scelto] == nil and (scelto == "prima" or scelto == "dopo") then
            scelto = "fuori"
        end
        radice:attr("data-intervalli", table.concat(codificati, ";"))
        for _, caso in ipairs({ "prima", "durante", "dopo", "fuori" }) do
            if args[caso] then
                nodoCaso(radice, tag, args[caso], caso == scelto):attr(
                    "data-caso",
                    caso
                )
            end
        end
        return tostring(radice)
    end

    local formato = args.formato
    if not formato or trim(formato) == "" then
        return errore(
            "Switch a tempo: specificare formato oppure start/end/intervalli"
        )
    end
    formato = trim(formato)
    local tz = normTz(args.tz)
    local valore = formatta(formato, ora, tz)

    local casi = {}
    for k, v in pairs(args) do
        local nome = trim(tostring(k))
        if not RISERVATI[nome] then
            table.insert(casi, { nome, v })
        end
    end
    table.sort(casi, function(a, b)
        return a[1] < b[1]
    end)

    local scelto
    for i, caso in ipairs(casi) do
        if corrisponde(caso[1], valore) then
            scelto = i
            break
        end
    end

    radice:attr("data-formato", formato):attr("data-tz", tz)
    for i, caso in ipairs(casi) do
        nodoCaso(radice, tag, caso[2], i == scelto):attr("data-valori", caso[1])
    end
    if args.default then
        nodoCaso(radice, tag, args.default, scelto == nil):attr(
            "data-caso",
            "default"
        )
    end
    return tostring(radice)
end

--[[
{{#invoke: Tempo | intervalliDaTesto | <testo> | ora=hh:mm }}
Estrae gli intervalli gg/mm/aaaa - gg/mm/aaaa dal testo e li restituisce
nel formato di intervalli= (inizio/fine;...), con inizio e fine all'ora
indicata (UTC, predefinita 00:00).
--]]
t.intervalliDaTesto = function(frame)
    local args = getArgs(frame)
    local testo = args[1] or ""
    local ora = trim(args.ora or "")
    if not ora:match("^%d%d:%d%d$") then
        ora = "00:00"
    end
    local out = {}
    for d1, m1, y1, d2, m2, y2 in
        testo:gmatch(
            "(%d%d?)/(%d%d?)/(%d%d%d%d)%s*%-%s*(%d%d?)/(%d%d?)/(%d%d%d%d)"
        )
    do
        table.insert(
            out,
            string.format(
                "%s-%02d-%02dT%sZ/%s-%02d-%02dT%sZ",
                y1,
                tonumber(m1),
                tonumber(d1),
                ora,
                y2,
                tonumber(m2),
                tonumber(d2),
                ora
            )
        )
    end
    return table.concat(out, ";")
end

return t
