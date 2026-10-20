-- Dati condivisi sul Gioco di Carte Collezionabili Pokémon Pocket.
--
-- codes: corrispondenza fra il nome di un'espansione e il suo codice
-- (quello usato dal gioco e dal Template:GCCPSetNav, es. "A2", "B4a").
-- Serve, fra l'altro, a costruire le ancore delle tab delle immagini
-- negli infobox delle carte: <codice>-<numero carta>, es. A2-049.
--
-- Va aggiornato a ogni nuova espansione.

local data = {}

data.codes = {
    -- Serie A
    ["Geni Supremi"] = "A1",
    ["L'Isola Misteriosa"] = "A1a",
    ["Scontro Spaziotemporale"] = "A2",
    ["Luce Trionfale"] = "A2a",
    ["Tripudio Splendente"] = "A2b",
    ["Guardiani Astrali"] = "A3",
    ["Crisi Ultradimensionale"] = "A3a",
    ["Il Bosco di Eevee"] = "A3b",
    ["La Via del Cielo e del Mare"] = "A4",
    ["Sorgenti Recondite"] = "A4a",
    ["Busta Deluxe ex"] = "A4b",
    ["Promo-A"] = "PROMO-A",

    -- Serie B
    ["Mega Ascesa"] = "B1",
    ["Fiamme Cremisi"] = "B1a",
    ["Parata Fantasmagorica"] = "B2",
    ["Meraviglie di Paldea"] = "B2a",
    ["Mega Splendore"] = "B2b",
    ["Aura Pulsante"] = "B3",
    ["Assalto dei Paradossi"] = "B3a",
    ["Giorni Giocondi"] = "B3b",
    ["Sovrano dei Cieli"] = "B4",
    ["I Loschi Piani del Team Rocket"] = "B4a",
    ["Busta Deluxe Mega"] = "B4b",
    ["Promo-B"] = "PROMO-B",

    -- Serie C
    ['Fusione Duale'] = 'C1',
}

return data
