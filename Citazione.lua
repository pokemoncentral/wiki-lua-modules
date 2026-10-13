-- Modulo:Citazione
--
-- Motore delle note (riferimenti) di Template:Ref. Si occupa di due cose:
--   1. emettere il tag <ref> nei tre casi possibili (nota di testo, nota
--      riusata, nota costruita da una fonte strutturata);
--   2. formattare in modo uniforme le fonti strutturate, a partire da pochi
--      parametri, così che le citazioni dello stesso tipo siano tutte uguali.
--
-- Uso (tramite Template:Ref):
--   {{ref|Testo della nota}}                      nota semplice
--   {{ref|Testo della nota|nome}}                 nota semplice con nome
--   {{ref|name=nome}}                             riuso di una nota già definita
--   {{ref|video=ID|titolo=…|autore=…|data=…}}     fonte strutturata (YouTube)
--   {{ref|tweet=ID|autore=…|data=…}}              fonte strutturata (X)
--   {{ref|sito=URL|titolo=…|data=…}}              sito ufficiale (Pokémon,
--                                                 The Pokémon Company, Nintendo,
--                                                 Game Freak)
--   {{ref|press=URL|titolo=…|data=…}}             pagina di un press site
--   {{ref|archivio=URL|titolo=…}}                 copia archiviata di una fonte
--   {{ref|Testo|group=Nota}}                      nota di un gruppo, elencata a
--                                                 parte con <references group="Nota" />
--
-- Il primo parametro posizionale può essere:
--   · una nota già scritta (un link, del testo): viene usata così com'è, e gli
--     altri parametri la decorano (copia archiviata, lingua, autore, data);
--   · un indirizzo nudo accompagnato da "titolo": in quel caso è la fonte, e il
--     titolo diventa il testo del link → [indirizzo titolo]
--
-- Campi di una fonte: data e lingua valgono per tutti i tipi; titolo, autore e
-- minuto per i video; autore e titolo (facoltativo) per i post su X; titolo per
-- il sito ufficiale. Il codice identificativo dipende dal tipo: "video" per
-- YouTube, "tweet" per X, "sito" per il sito ufficiale, "press" per il
-- press site.
-- L'archivio (copia su Internet Archive o archive.is) si può aggiungere a
-- qualunque fonte, e da solo costituisce la fonte.
-- Il gruppo (group) vale per qualunque nota, anche per i richiami con il solo
-- nome: una nota di gruppo si richiama indicando lo stesso gruppo.
-- Per aggiungere un nuovo tipo di fonte basta aggiungere in "tipi" una voce
-- con i campi "nome" (etichetta mostrata fra parentesi) e "url". Per un nuovo
-- sito ufficiale o press site basta invece una riga in SITI_UFFICIALI o
-- SITI_PRESS: l'etichetta viene scelta in base al dominio dell'indirizzo.

local p = {}

-- stylua: ignore
local mw = require('mw')

local CAT_ERRORE = "Pagine che usano template in modo errato"
local PREFISSO = "Errore nel template Ref: "

local MESI = {
    "gennaio",
    "febbraio",
    "marzo",
    "aprile",
    "maggio",
    "giugno",
    "luglio",
    "agosto",
    "settembre",
    "ottobre",
    "novembre",
    "dicembre",
}

-- ── utilità ──────────────────────────────────────────────────────────────────

local function trim(v)
    if v == nil then
        return nil
    end
    v = mw.text.trim(v)
    return v ~= "" and v or nil
end

local function errore(msg)
    return '<span class="error">'
        .. PREFISSO
        .. msg
        .. "</span>"
        .. "[[Categoria:"
        .. CAT_ERRORE
        .. "|R]]"
end

-- 01-09-2022 (o 01/09/2022) → "1º settembre 2022", con l'ordinale per il primo
-- del mese, come da manuale di stile; ogni altro formato è lasciato com'è.
local function dataIt(v)
    local g, m, a = v:match("^(%d%d?)%-(%d%d?)%-(%d%d%d%d)$")
    if not g then
        g, m, a = v:match("^(%d%d?)/(%d%d?)/(%d%d%d%d)$")
    end
    if not a or not MESI[tonumber(m)] then
        return v
    end
    g = tonumber(g)
    return (g == 1 and "1º" or g) .. " " .. MESI[tonumber(m)] .. " " .. a
end

-- 125 → "2:05", 3725 → "1:02:05".
local function durata(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor(sec % 3600 / 60)
    local s = sec % 60
    s = s < 10 and "0" .. s or tostring(s)
    if h > 0 then
        m = m < 10 and "0" .. m or tostring(m)
        return h .. ":" .. m .. ":" .. s
    end
    return m .. ":" .. s
end

-- "125", "2:05", "1:02:05" o "2m05s" → secondi; nil se non interpretabile.
local function secondi(v)
    if v:match("^%d+$") then
        return tonumber(v)
    end
    local h, m, s = v:match("^(%d+):(%d%d?):(%d%d?)$")
    if h then
        return tonumber(h) * 3600 + tonumber(m) * 60 + tonumber(s)
    end
    m, s = v:match("^(%d+):(%d%d?)$")
    if m then
        return tonumber(m) * 60 + tonumber(s)
    end
    -- formato usato da YouTube (es. "2m05s" o "1h2m3s")
    if v:match("^%d+[hms]") and v:match("[hms]$") then
        local unita = { h = 3600, m = 60, s = 1 }
        local tot, trovato = 0, false
        for n, u in v:gmatch("(%d+)([hms])") do
            trovato = true
            tot = tot + tonumber(n) * unita[u]
        end
        if trovato then
            return tot
        end
    end
    return nil
end

-- Aggiunge lo schema a un indirizzo scritto senza, e controlla che somigli a
-- un URL. Restituisce l'indirizzo normalizzato oppure nil.
local function comeUrl(v)
    if not v then
        return nil
    end
    local url = v
    if not url:match("^https?://") then
        url = "https://" .. url:gsub("^//", "")
    end
    if not url:match("^https?://[^%s/]+%.[^%s/]") then
        return nil
    end
    return url
end

-- Dominio (in minuscolo) di un indirizzo; nil se non è un indirizzo.
local function hostDi(url)
    local host = url and url:match("^https?://([^/?#]+)")
    return host and host:lower() or nil
end

-- Vero se l'host è il dominio indicato o un suo sottodominio
-- (www.nintendo.co.jp è su nintendo.co.jp).
local function suDominio(host, dominio)
    return host == dominio or host:sub(-(#dominio + 1)) == "." .. dominio
end

-- Da un indirizzo di web.archive.org ricava l'indirizzo originale e la data
-- della copia (nel formato italiano 23-11-2021: la marca temporale
-- dell'indirizzo è aaaa-mm-gg-ora).
--   https://web.archive.org/web/20211123193505/https://twitter.com/…
local function daInternetArchive(url)
    local ts, originale =
        url:match("web%.archive%.org/web/(%d+)/(https?://.+)$")
    if not originale then
        return nil
    end
    local data
    if #ts >= 8 then
        data = ts:sub(7, 8) .. "-" .. ts:sub(5, 6) .. "-" .. ts:sub(1, 4)
    end
    return originale, data
end

-- ── lettura dei parametri ────────────────────────────────────────────────────

-- I parametri arrivano da Template:Ref, che li inoltra tutti al modulo.
local function argomenti(frame)
    return frame.args
end

-- Campi di una fonte strutturata e relativi alias nei parametri.
local CAMPI = {
    tipo = { "tipo" },
    id = {
        "video",
        "tweet",
        "x",
        "sito",
        "ufficiale",
        "press",
        "stampa",
        "id",
        "codice",
    },
    titolo = { "titolo" },
    autore = { "autore" },
    data = { "data" },
    lingua = { "lingua" },
    minuto = { "minuto", "t" },
    archivio = { "archivio", "archiviato" },
    dataarchivio = { "dataarchivio" },
}

-- Parametro usato per il codice → tipo di fonte, quando "tipo" non è indicato.
local TIPO_DA_CODICE = {
    video = "video",
    tweet = "x",
    x = "x",
    sito = "sito",
    ufficiale = "sito",
    press = "press",
    stampa = "press",
}

-- Chiave e valore del primo alias compilato.
local function primo(raw, alias)
    for _, k in ipairs(alias) do
        local v = trim(raw[k])
        if v then
            return k, v
        end
    end
    return nil, nil
end

-- Restituisce i campi compilati, con il parametro che li ha forniti.
local function campiFonte(raw)
    local a, chiave = {}, {}
    for campo, alias in pairs(CAMPI) do
        local k, v = primo(raw, alias)
        if v then
            a[campo] = v
            chiave[campo] = k
        end
    end
    return a, chiave
end

-- ── siti ufficiali ───────────────────────────────────────────────────────────

-- Lingue dei siti ufficiali Pokémon, riconosciute dall'indirizzo: codici usati
-- nei percorsi (pokemon.com/it-it/…) e sottodomini (sg.portal-pokemon.com).
-- Attenzione a non aggiungere codici ambigui con i percorsi dei giochi: "sv"
-- in pokemon.co.jp/ex/sv/ è Scarlatto e Violetto, non lo svedese.
local LINGUE_PERCORSO = {
    it = "Italiano",
    en = "Inglese",
    us = "Inglese",
    ja = "Giapponese",
    jp = "Giapponese",
    es = "Spagnolo",
    fr = "Francese",
    de = "Tedesco",
    pt = "Portoghese",
    tc = "Cinese tradizionale",
    sc = "Cinese semplificato",
    cn = "Cinese semplificato",
    kr = "Coreano",
    ko = "Coreano",
    th = "Thailandese",
    vn = "Vietnamita",
}
local LINGUE_SOTTODOMINIO = {
    sg = "Inglese",
    tw = "Cinese tradizionale",
    hk = "Cinese tradizionale",
    ld = "Cinese tradizionale",
    cn = "Cinese semplificato",
    kr = "Coreano",
    th = "Thailandese",
    vn = "Vietnamita",
}

-- Siti giapponesi: sono in giapponese, a meno che il percorso non indichi
-- un'altra lingua (es. nintendo.co.jp/corporate/en/ è in inglese). Valgono
-- anche per i sottodomini (corporate.pokemon.co.jp).
local DOMINI_GIAPPONESI =
    { "pokemon.co.jp", "nintendo.co.jp", "gamefreak.co.jp" }

-- Etichetta mostrata fra parentesi per il parametro "sito", secondo il dominio
-- dell'indirizzo: i siti delle aziende hanno un'etichetta propria, ogni altro
-- indirizzo è il sito ufficiale Pokémon. Le righe si controllano in ordine,
-- quindi un sottodominio va messo prima del dominio che lo contiene
-- (corporate.pokemon.co.jp prima di un eventuale pokemon.co.jp).
local SITI_UFFICIALI = {
    { "corporate.pokemon.co.jp", "sito aziendale The Pokémon Company" },
    { "nintendo.co.jp", "sito ufficiale Nintendo" },
    { "gamefreak.co.jp", "sito ufficiale Game Freak" },
}

-- Etichetta della prima riga dell'elenco il cui dominio contiene l'indirizzo;
-- quella predefinita se nessuna corrisponde.
local function etichettaDaDominio(elenco, id, predefinita)
    local host = hostDi(comeUrl(id))
    if host then
        for _, sito in ipairs(elenco) do
            if suDominio(host, sito[1]) then
                return sito[2]
            end
        end
    end
    return predefinita
end

-- Ricava la lingua dall'indirizzo di un sito ufficiale; nil se non riconosciuta.
local function linguaDaUrl(url)
    local host, percorso = url:match("^https?://([^/]+)(.*)$")
    if not host then
        return nil
    end
    host = host:lower()
    -- sottodominio di portal-pokemon.com (es. sg.portal-pokemon.com → inglese)
    local sottodominio = host:match("^([%w%-]+)%.")
    if sottodominio and LINGUE_SOTTODOMINIO[sottodominio] then
        return LINGUE_SOTTODOMINIO[sottodominio]
    end
    -- codice di lingua nel percorso: /it/ e /it-it/, /en-us/, /ex/sv/ja/…
    for segmento in percorso:gmatch("/([%a][%a%-]*)") do
        local codice = segmento:match("^(%a+)%-%a+$") or segmento
        local lingua = LINGUE_PERCORSO[codice:lower()]
        if lingua then
            return lingua
        end
    end
    -- i siti giapponesi sono in giapponese, a meno che il percorso non dica altro
    for _, dominio in ipairs(DOMINI_GIAPPONESI) do
        if suDominio(host, dominio) then
            return "Giapponese"
        end
    end
    return nil
end

-- ── press site ─────────────────────────────────────────────────────────────

-- Il press site ufficiale (pokemon.gamespress.com) ha una pagina per paese, e
-- i codici nel percorso sono quelli dei paesi, non sempre uguali a quelli delle
-- lingue: "uk" è il Regno Unito (inglese), non l'ucraino. Belgio e Canada sono
-- esclusi perché bilingui: per quelli la lingua va indicata a mano.
local LINGUE_PRESS = {
    au = "Inglese",
    br = "Portoghese",
    cz = "Ceco",
    de = "Tedesco",
    es = "Spagnolo",
    fr = "Francese",
    gr = "Greco",
    il = "Ebraico",
    it = "Italiano",
    mx = "Spagnolo",
    nl = "Olandese",
    nz = "Inglese",
    pl = "Polacco",
    pt = "Portoghese",
    sk = "Slovacco",
    tr = "Turco",
    uk = "Inglese",
    us = "Inglese",
}

-- Press site diversi da quello internazionale, riconosciuti dal dominio, con
-- l'etichetta mostrata fra parentesi: il nome ufficiale del sito, quello che
-- compare in fondo al titolo di ogni sua pagina.
local SITI_PRESS = {
    {
        "asia-press.portal-pokemon.com",
        "The Pokémon Company Official Asia Press Site",
    },
}

-- Ricava la lingua di una pagina del press site. La versione internazionale
-- (senza codice di paese nell'indirizzo) è quella inglese; un codice di paese
-- non mappato (Belgio, Canada: bilingui) lascia la lingua indeterminata, così
-- non viene segnalata una lingua sbagliata e la si può indicare a mano.
-- Il press site asiatico cambia lingua senza cambiare indirizzo, e il link apre
-- sempre la versione inglese: per le altre lingue va indicata a mano.
local function linguaPress(url)
    local host, percorso = url:match("^https?://([^/]+)(.*)$")
    if host and suDominio(host:lower(), "asia-press.portal-pokemon.com") then
        return "Inglese"
    end
    if not host or not host:lower():match("gamespress%.com$") then
        return linguaDaUrl(url)
    end
    local codice = percorso:match("^/(%a%a)[/?#]")
        or percorso:match("^/(%a%a)$")
    if codice then
        return LINGUE_PRESS[codice:lower()]
    end
    return "Inglese"
end

-- ── tipi di fonte ────────────────────────────────────────────────────────────

local tipi = {}

-- Video su YouTube: titolo linkato al video, poi autore fra trattino e
-- piattaforma con gli altri dati fra parentesi.
--   [Titolo] – Autore (YouTube, 9 gennaio 2020, min. 2:05)
tipi.video = {
    nome = "YouTube",
    minuto = true,
    url = function(a)
        local id = a.id
        if not id then
            return nil
        end
        -- accetta indifferentemente il codice del video o l'URL completo
        id = id:match("[?&]v=([%w%-_]+)")
            or id:match("youtu%.be/([%w%-_]+)")
            or id
        if not id:match("^[%w%-_]+$") then
            return nil
        end
        local url = "https://www.youtube.com/watch?v=" .. id
        if a.t then
            url = url .. "&t=" .. a.t .. "s"
        end
        return url
    end,
}

-- Post su X (ex Twitter). Un post non ha titolo: se non ne viene indicato uno,
-- il testo del link diventa "Tweet di <autore>".
--   [Tweet di Pokémon (@Pokemon)] (X, 29 agosto 2022)
tipi.x = {
    nome = "X",
    titolo = function(a)
        if a.autore then
            return "Tweet di " .. a.autore
        end
        return nil
    end,
    url = function(a)
        local id = a.id
        if not id then
            return nil
        end
        -- accetta l'indirizzo completo (x.com o twitter.com, anche con
        -- parametri come ?s=19) oppure il solo codice numerico del post
        local utente, codice = id:match("[xX]%.com/([%w_]+)/status/(%d+)")
        if not codice then
            utente, codice = id:match("[tT]witter%.com/([%w_]+)/status/(%d+)")
        end
        if not codice and id:match("^%d+$") then
            codice = id
        end
        if not codice then
            return nil
        end
        if utente then
            return "https://x.com/" .. utente .. "/status/" .. codice
        end
        return "https://x.com/i/status/" .. codice
    end,
}
tipi.tweet = tipi.x

-- Sito ufficiale Pokémon, nelle sue varie versioni linguistiche (pokemon.com,
-- pokemon.co.jp, portal-pokemon.com…), e siti ufficiali delle aziende
-- (corporate.pokemon.co.jp, nintendo.co.jp, gamefreak.co.jp), che hanno
-- un'etichetta propria scelta in base al dominio (vedi SITI_UFFICIALI). La
-- lingua, quando è riconoscibile dall'indirizzo, viene aggiunta da sola; la si
-- può forzare con "lingua".
--   [Titolo della pagina]‹Inglese› (sito ufficiale Pokémon, 30 maggio 2018)
--   [Corporate Information]‹Inglese› (sito ufficiale Nintendo)
tipi.sito = {
    nome = "sito ufficiale Pokémon",
    etichetta = function(a)
        return etichettaDaDominio(
            SITI_UFFICIALI,
            a.id,
            "sito ufficiale Pokémon"
        )
    end,
    url = function(a)
        return comeUrl(a.id)
    end,
    lingua = function(a)
        local url = comeUrl(a.id)
        return url and linguaDaUrl(url) or nil
    end,
}
tipi.ufficiale = tipi.sito

-- Press site ufficiale: comunicati e avvisi stampa di The Pokémon Company
-- International, pubblicati su pokemon.gamespress.com in più versioni
-- linguistiche, e degli altri press site (vedi SITI_PRESS, es. quello
-- asiatico). L'etichetta è il nome ufficiale del sito, quello che compare in
-- fondo al titolo di ogni sua pagina. Lingua ricavata dall'indirizzo, come per
-- il sito ufficiale.
--   [Titolo del comunicato] (The Pokémon Company International Official Press
--   Site, 16 settembre 2026)
tipi.press = {
    nome = "The Pokémon Company International Official Press Site",
    etichetta = function(a)
        return etichettaDaDominio(
            SITI_PRESS,
            a.id,
            "The Pokémon Company International Official Press Site"
        )
    end,
    url = function(a)
        return comeUrl(a.id)
    end,
    lingua = function(a)
        local url = comeUrl(a.id)
        return url and linguaPress(url) or nil
    end,
}

-- Qualunque altra pagina web, senza etichetta: si usa quando l'unica
-- indicazione è la copia archiviata, di cui l'indirizzo originale fa parte,
-- oppure quando la fonte è un indirizzo nudo.
tipi.web = {
    url = function(a)
        return comeUrl(a.id)
    end,
}

-- ── formattazione di una fonte strutturata ───────────────────────────────────

-- Compone la nota: corpo principale (un link, o il testo già scritto), copia
-- archiviata, lingua, autore, e gli altri dati fra parentesi in fondo.
-- L'etichetta fra parentesi è quella del tipo, o quella che il tipo ricava
-- dall'indirizzo (siti ufficiali e press site).
local function componi(corpo, a, tipo, autore)
    local copia = ""
    if a.archivio then
        local etichetta = "archiviato"
        if a.dataarchivio then
            etichetta = etichetta .. " il " .. dataIt(a.dataarchivio)
        end
        copia = " ([" .. a.archivio .. " " .. etichetta .. "])"
    end
    local out = { corpo .. copia }
    if a.lingua then
        out[#out + 1] = "<sup>[" .. a.lingua .. "]</sup>"
    end
    if autore then
        out[#out + 1] = " – " .. autore
    end
    local meta = {}
    local nome = tipo and (tipo.etichetta and tipo.etichetta(a) or tipo.nome)
    if nome then
        meta[#meta + 1] = nome
    end
    if a.data then
        meta[#meta + 1] = dataIt(a.data)
    end
    if a.tTesto then
        meta[#meta + 1] = "min. " .. a.tTesto
    end
    if #meta > 0 then
        out[#out + 1] = " (" .. table.concat(meta, ", ") .. ")"
    end
    return table.concat(out)
end

function p.fonte(frame)
    local raw = argomenti(frame)
    local a, chiave = campiFonte(raw)
    local tipoEsplicito = trim(raw.tipo) ~= nil

    -- Il primo parametro può essere la fonte oppure la nota già scritta. È la
    -- fonte solo se è un indirizzo nudo accompagnato da "titolo": in quel caso
    -- il titolo diventa il testo del link. Se invece contiene già un link o del
    -- testo, resta la nota così com'è e viene solo decorata.
    local testo = trim(raw.testo) or trim(raw[1])
    if
        testo
        and not chiave.id
        and a.titolo
        and testo:match("^https?://%S+$")
    then
        a.id = testo
        testo = nil
    end

    -- archivio: si controlla subito l'indirizzo della copia
    if a.archivio then
        a.archivio = comeUrl(a.archivio)
        if not a.archivio then
            return errore("l'indirizzo della copia archiviata non è valido")
        end
    end

    a.tipo = a.tipo
        or TIPO_DA_CODICE[chiave.id]
        or (a.archivio and "web")
        or (a.id and "web")
        or "video"

    local tipo = tipi[a.tipo]
    if not tipo then
        return errore("tipo di fonte «" .. a.tipo .. "» sconosciuto")
    end

    -- la data della copia archiviata, se non indicata, si ricava dall'indirizzo
    if a.archivio and not a.dataarchivio then
        local _, data = daInternetArchive(a.archivio)
        if data then
            a.dataarchivio = data
        end
    end

    -- Nota già scritta nel primo parametro, senza una fonte strutturata: si usa
    -- com'è e si aggiungono solo le decorazioni (copia archiviata, lingua,
    -- autore). È il caso di {{ref|[https://… Titolo]|archivio=…}}.
    if testo and not chiave.id then
        return componi(testo, a, nil, a.autore)
    end

    -- Da qui serve una fonte. Se non è stato indicato un codice, l'originale si
    -- ricava dall'indirizzo di Internet Archive (che lo contiene); con
    -- archive.is non è possibile, e allora la copia stessa è la fonte.
    if a.archivio and not a.id then
        local originale = daInternetArchive(a.archivio)
        if originale then
            a.id = originale
        else
            a.id = a.archivio
            a.archivio = nil
        end
    end

    -- senza un codice non si può comporre niente, a meno che il tipo sia stato
    -- indicato a mano (allora l'errore lo dà il tipo stesso)
    if not a.id and not tipoEsplicito then
        return errore("manca la fonte (video, tweet, sito o archivio)")
    end

    -- il minuto riguarda solo i tipi che lo prevedono (i video)
    if a.minuto and not tipo.minuto then
        return errore("il minuto non è previsto per il tipo " .. tipo.nome)
    end
    if tipo.minuto then
        -- se al posto del codice è stato incollato l'indirizzo completo, il
        -- minuto (parametro "t") che vi compare viene recuperato
        if not a.minuto and a.id then
            local t = a.id:match("[?&]t=([%dhms]+)")
            if t and secondi(t) then
                a.minuto = t
            end
        end
        if a.minuto then
            local sec = secondi(a.minuto)
            if not sec then
                return errore("minuto «" .. a.minuto .. "» non valido")
            end
            a.t = sec
            a.tTesto = durata(sec)
        end
    end

    -- titolo: se il tipo ne prevede uno predefinito (X) e l'autore finisce nel
    -- testo del link, l'autore non viene poi ripetuto dopo il trattino
    local titolo, autore = a.titolo, a.autore
    if not titolo and tipo.titolo then
        titolo = tipo.titolo(a)
        autore = nil
    end
    if not titolo then
        return errore("manca il titolo della fonte")
    end

    local url = tipo.url and tipo.url(a)
    if not url then
        return errore("manca il codice " .. tipo.nome .. " o non è valido")
    end

    -- lingua: si può indicare, altrimenti alcuni tipi la ricavano dall'indirizzo
    -- (il sito ufficiale). L'italiano non viene segnalato, è la lingua della wiki
    if not a.lingua and tipo.lingua then
        a.lingua = tipo.lingua(a)
    end
    if a.lingua == "Italiano" then
        a.lingua = nil
    end

    -- il testo posizionale, se c'è, si aggiunge dopo il link principale
    local corpo = "[" .. url .. " " .. titolo .. "]"
    if testo then
        corpo = corpo .. " " .. testo
    end
    return componi(corpo, a, tipo, autore)
end

-- ── emissione della nota ─────────────────────────────────────────────────────

-- content = testo della nota; nil per una nota riusata (<ref name="…" />).
-- gruppo = gruppo della nota (group="…"): le note di un gruppo sono elencate a
-- parte, da <references group="…" /> (o da {{references|cit=yes}} per il
-- gruppo "Citazione").
local function nota(frame, content, nome, gruppo)
    local attributi = {}
    if nome then
        attributi.name = nome
    end
    if gruppo then
        attributi.group = gruppo
    end
    return frame:extensionTag("ref", content, attributi)
end

function p.rif(frame)
    local raw = argomenti(frame)
    local nome = trim(raw.nome or raw.name or raw[2])
    local gruppo = trim(raw.gruppo or raw.group)
    local testo = trim(raw.testo) or trim(raw[1])
    local campi = campiFonte(raw)

    -- Via rapida: il solo primo parametro è la nota intera.
    if testo and next(campi) == nil then
        return nota(frame, testo, nome, gruppo)
    end

    -- Altrimenti si compone: può servire per la copia archiviata, la lingua,
    -- il titolo e gli altri parametri, che vanno comunque rispettati.
    if testo or next(campi) ~= nil then
        return nota(frame, p.fonte(frame), nome, gruppo)
    end

    if nome then
        return nota(frame, nil, nome, gruppo)
    end

    return errore("mancano i parametri")
end

return p
