-- Modulo dati per le MT/MN

local m = {}

--[[
    Zip two lists into a list of pairs after decorating the elements in each
    list with a given key.

    If one list is longer than the other, the extra elements are included with
    no counterpart from the shorter list.

    Example:
        zipLongestWithKeys(
            "base", { "bread", "pizza" },
            "topping", { "butter", "mushrooms", "pineapple" }
        )
        ->
        {
            { {"base", "bread"}, {"topping", "butter"} },
            { {"base", "pizza"}, {"topping", "mushrooms"} },
            { {"topping", "pineapple"} }
        }
--]]
local zipLongestWithKeys = function(key0, list0, key1, list1)
    local res = {}
    local maxIndex = math.max(#list0, #list1)

    -- Yes, we do have tables in this file that start from 0
    for idx = 0, maxIndex do
        local item0 = list0[idx]
        local item1 = list1[idx]
        if item0 or item1 then
            local itemRes = {}
            if item0 then
                table.insert(itemRes, { key0, item0 })
            end
            if item1 then
                table.insert(itemRes, { key1, item1 })
            end
            -- This handles 0 as an index, as opposed to table.insert
            res[idx] = itemRes
        end
    end

    return res
end

m[1] = {}
-- stylua: ignore
m[1].MT = {
	"megapugno", "ventagliente", "danzaspada", "turbine", "megacalcio",
	"tossina", "perforcorno", "corposcontro", "riduttore", "sdoppiatore",
	"bollaraggio", "pistolacqua", "geloraggio", "bora", "iper raggio",
	"giornopaga", "sottomissione", "contrattacco", "movimento sismico", "ira",
	"megassorbimento", "solarraggio", "ira di drago", "fulmine", "tuono",
	"terremoto", "abisso", "fossa", "psichico", "teletrasporto", "mimica",
	"doppioteam", "riflesso", "pazienza", "metronomo", "autodistruzione",
	"uovobomba", "fuocobomba", "comete", "capocciata", "covauova",
	"mangiasogni", "aeroattacco", "riposo", "tuononda", "psiconda",
	"esplosione", "frana", "tripletta", "sostituto",
}
m[1].MN = { "taglio", "volo", "surf", "forza", "flash" }

m[2] = {}
-- stylua: ignore
m[2].MT = {
	"dinamipugno", "bottintesta", "maledizione", "rotolamento", "boato",
	"tossina", "falcecannone", "spaccaroccia", "psicamisù", "introforza",
	"giornodisole", "profumino", "russare", "bora", "iper raggio",
	"ventogelato", "protezione", "pioggiadanza", "gigassorbimento",
	"resistenza", "frustrazione", "solarraggio", "codacciaio", "dragospiro",
	"tuono", "terremoto", "ritorno", "fossa", "psichico", "palla ombra",
	"fangosberla", "doppioteam", "gelopugno", "bullo", "sonnolalia",
	"fangobomba", "terrempesta", "fuocobomba", "comete", "rafforzatore",
	"tuonopugno", "mangiasogni", "individua", "riposo", "attrazione", "furto",
	"alacciaio", "fuocopugno", "tagliofuria", "incubo",
}
m[2].MN = { "taglio", "volo", "surf", "forza", "flash", "mulinello", "cascata" }

m[3] = {}
-- stylua: ignore
m[3].MT = {
    "centripugno", "dragartigli", "idropulsar", "calmamente", "boato",
    "tossina", "grandine", "granfisico", "semitraglia", "introforza",
    "giornodisole", "provocazione", "geloraggio", "bora", "iper raggio",
    "schermoluce", "protezione", "pioggiadanza", "gigassorbimento",
    "salvaguardia", "frustrazione", "solarraggio", "codacciaio", "fulmine",
    "tuono", "terremoto", "ritorno", "fossa", "psichico", "palla ombra",
    "breccia", "doppioteam", "riflesso", "ondashock", "lanciafiamme",
    "fangobomba", "terrempesta", "fuocobomba", "rocciotomba", "aeroassalto",
    "attaccalite", "facciata", "forzasegreta", "riposo", "attrazione", "furto",
    "alacciaio", "baratto", "scippo", "vampata",
}
-- stylua: ignore
m[3].MN = {
    "taglio", "volo", "surf", "forza", "flash", "spaccaroccia", "cascata",
    { { "RZS", "sub" } },
}

m[4] = {}
-- stylua: ignore
m[4].MT = {
    "centripugno", "dragartigli", "idropulsar", "calmamente", "boato",
    "tossina", "grandine", "granfisico", "semitraglia", "introforza",
    "giornodisole", "provocazione", "geloraggio", "bora", "iper raggio",
    "schermoluce", "protezione", "pioggiadanza", "gigassorbimento",
    "salvaguardia", "frustrazione", "solarraggio", "codacciaio", "fulmine",
    "tuono", "terremoto", "ritorno", "fossa", "psichico", "palla ombra",
    "breccia", "doppioteam", "riflesso", "ondashock", "lanciafiamme",
    "fangobomba", "terrempesta", "fuocobomba", "rocciotomba", "aeroassalto",
    "attaccalite", "facciata", "forzasegreta", "riposo", "attrazione", "furto",
    "alacciaio", "baratto", "scippo", "vampata", "trespolo", "focalcolpo",
    "energipalla", "falsofinale", "acquadisale", "lancio", "raggioscossa",
    "resistenza", "dragopulsar", "assorbipugno", "fuocofatuo", "ventargenteo",
    "divieto", "esplosione", "ombrartigli", "rivincita", "riciclo",
    "gigaimpatto", "lucidatura", "flash", "pietrataglio", "slavina", "tuononda",
    "vortexpalla", "danzaspada", "levitoroccia", "psicamisù", "incanto",
    "neropulsar", "frana", "forbice x", "sonnolalia", "dononaturale",
    "velenpuntura", "mangiasogni", "laccioerboso", "bullo", "spennata",
    "retromarcia", "sostituto", "cannonflash", "distortozona",
}
-- stylua: ignore
m[4].MN = {
    "taglio", "volo", "surf", "forza",
    { { "DPPt", "scacciabruma" }, { "HGSS", "mulinello" } },
    "spaccaroccia", "cascata", "scalaroccia",
}

m[5] = {}
-- stylua: ignore
m[5].MT = {
    "unghiaguzze", "dragartigli", "psicoshock", "calmamente", "boato",
    "tossina", "grandine", "granfisico", "velenoshock", "introforza",
    "giornodisole", "provocazione", "geloraggio", "bora", "iper raggio",
    "schermoluce", "protezione", "pioggiadanza", "telecinesi", "salvaguardia",
    "frustrazione", "solarraggio", "abbattimento", "fulmine", "tuono",
    "terremoto", "ritorno", "fossa", "psichico", "palla ombra", "breccia",
    "doppioteam", "riflesso", "fangonda", "lanciafiamme", "fangobomba",
    "terrempesta", "fuocobomba", "rocciotomba", "aeroassalto", "attaccalite",
    "facciata", "nitrocarica", "riposo", "attrazione", "furto", "calciobasso",
    "coro", "echeggiavoce", "vampata", "cambiaposto", "focalcolpo",
    "energipalla", "falsofinale", "idrovampata", "lancio", "raggioscossa",
    "cadutalibera", "bruciatutto", "spintone", "fuocofatuo", "acrobazia",
    "divieto", "esplosione", "ombrartigli", "rivincita", "nemesi",
    "gigaimpatto", "lucidatura", "flash", "pietrataglio", "invertivolt",
    "tuononda", "vortexpalla", "danzaspada", "entomoblocco", "psicamisù",
    "battiterra", "alitogelido", "frana", "forbice x", "codadrago",
    "cuordileone", "velenpuntura", "mangiasogni", "laccioerboso", "bullo",
    "spennata", "retromarcia", "sostituto", "cannonflash", "distortozona",
    "sprizzalampo", "spaccaroccia", "urlorabbia",
}
m[5].MN = { "taglio", "volo", "surf", "forza", "cascata", "sub" }

m[6] = {}
-- stylua: ignore
m[6].MT = {
    "unghiaguzze", "dragartigli", "psicoshock", "calmamente", "boato",
    "tossina", "grandine", "granfisico", "velenoshock", "introforza",
    "giornodisole", "provocazione", "geloraggio", "bora", "iper raggio",
    "schermoluce", "protezione", "pioggiadanza", "trespolo", "salvaguardia",
    "frustrazione", "solarraggio", "abbattimento", "fulmine", "tuono",
    "terremoto", "ritorno", "fossa", "psichico", "palla ombra", "breccia",
    "doppioteam", "riflesso", "fangonda", "lanciafiamme", "fangobomba",
    "terrempesta", "fuocobomba", "rocciotomba", "aeroassalto", "attaccalite",
    "facciata", "nitrocarica", "riposo", "attrazione", "furto", "calciobasso",
    "coro", "echeggiavoce", "vampata", "alacciaio", "focalcolpo", "energipalla",
    "falsofinale", "idrovampata", "lancio", "raggioscossa", "cadutalibera",
    "bruciatutto", "spintone", "fuocofatuo", "acrobazia", "divieto",
    "esplosione", "ombrartigli", "rivincita", "nemesi", "gigaimpatto",
    "lucidatura", "flash", "pietrataglio", "invertivolt", "tuononda",
    "vortexpalla", "danzaspada", "entomoblocco", "psicamisù", "battiterra",
    "alitogelido", "frana", "forbice x", "codadrago", "assillo", "velenpuntura",
    "mangiasogni", "laccioerboso", "bullo", "sonnolalia", "retromarcia",
    "sostituto", "cannonflash", "distortozona", "sprizzalampo",
    { { "XY", "spaccaroccia" }, { "ROZA", "forzasegreta" } }, "urlorabbia",
    "naturforza", "neropulsar", "crescipugno", "magibrillio", "confidenza",
}
-- stylua: ignore
m[6].MN = {
    "taglio", "volo", "surf", "forza", "cascata",
    { { "ROZA", "spaccaroccia" } }, { { "ROZA", "sub" } },
}

m[7] = {}
-- stylua: ignore
m[7].MT = {
    "cuordileone", "dragartigli", "psicoshock", "calmamente", "boato",
    "tossina", "grandine", "granfisico", "velenoshock", "introforza",
    "giornodisole", "provocazione", "geloraggio", "bora", "iper raggio",
    "schermoluce", "protezione", "pioggiadanza", "trespolo", "salvaguardia",
    "frustrazione", "solarraggio", "abbattimento", "fulmine", "tuono",
    "terremoto", "ritorno", "sanguisuga", "psichico", "palla ombra", "breccia",
    "doppioteam", "riflesso", "fangonda", "lanciafiamme", "fangobomba",
    "terrempesta", "fuocobomba", "rocciotomba", "aeroassalto", "attaccalite",
    "facciata", "nitrocarica", "riposo", "attrazione", "furto", "calciobasso",
    "coro", "echeggiavoce", "vampata", "alacciaio", "focalcolpo", "energipalla",
    "falsofinale", "idrovampata", "lancio", "raggioscossa", "cadutalibera",
    "vorticolpo", "spintone", "fuocofatuo", "acrobazia", "divieto",
    "esplosione", "ombrartigli", "rivincita", "sottilcorno", "gigaimpatto",
    "lucidatura", "velaurora", "pietrataglio", "invertivolt", "tuononda",
    "vortexpalla", "danzaspada", "volo", "psicamisù", "battiterra",
    "alitogelido", "frana", "forbice x", "codadrago", "assillo", "velenpuntura",
    "mangiasogni", "laccioerboso", "bullo", "sonnolalia", "retromarcia",
    "sostituto", "cannonflash", "distortozona", "sprizzalampo", "surf",
    "urlorabbia", "naturforza", "neropulsar", "cascata", "magibrillio",
    "confidenza",
}

-- stylua: ignore
local mt8spsc = {
    [0] = "megapugno", "megacalcio", "giornopaga", "fuocopugno", "gelopugno",
    "tuonopugno", "volo", "missilspillo", "iper raggio", "gigaimpatto",
    "fogliamagica", "solarraggio", "lama solare", "turbofuoco", "tuononda",
    "fossa", "stridio", "schermoluce", "riflesso", "salvaguardia",
    "autodistruzione", "riposo", "frana", "furto", "russare", "protezione",
    "visotruce", "ventogelato", "gigassorbimento", "fascino", "alacciaio",
    "attrazione", "terrempesta", "pioggiadanza", "giornodisole", "grandine",
    "mulinello", "picchiaduro", "fuocofatuo", "facciata", "comete",
    "altruismo", "vendetta", "breccia", "esclusiva", "sub", "palla clima",
    "falselacrime", "rocciotomba", "sabbiotomba", "semitraglia",
    "gelolancia", "rimbalzo", "colpodifango", "cadutamassi", "acquadisale",
    "retromarcia", "rivincita", "garanzia", "lancio", "barattoforza",
    "barattoscudo", "velociscambio", "assorbipugno", "slavina", "ombrartigli",
    "fulmindenti", "gelodenti", "rogodenti", "psicotaglio", "distortozona",
    "mirabilzona", "magicozona", "velenocroce", "velenoshock", "calciobasso",
    "coro", "sciagura", "acrobazia", "nemesi", "invertivolt", "battiterra",
    "elettrotela", "conchilama", "spazzasberla", "urlorabbia", "spettrotuffo",
    "assorbibacio", "campo erboso", "campo nebbioso", "campo elettrico",
    "campo psichico", "magifiamma", "elettromistero", "falsofinale",
    "eterelama", "sottilcorno", "vorticolpo", "battipiedi", "vastoimpatto",
}
-- stylua: ignore
local mt8dlps = {
    "centripugno", "dragartigli", "idropulsar", "calmamente", "boato",
    "tossina", "grandine", "granfisico", "semitraglia", "cuordileone",
    "giornodisole", "provocazione", "geloraggio", "bora", "iper raggio",
    "schermoluce", "protezione", "pioggiadanza", "gigassorbimento",
    "salvaguardia", "magibrillio", "solarraggio", "codacciaio", "fulmine",
    "tuono", "terremoto", "calciobasso", "fossa", "psichico", "palla ombra",
    "breccia", "doppioteam", "riflesso", "ondashock", "lanciafiamme",
    "fangobomba", "terrempesta", "fuocobomba", "rocciotomba", "aeroassalto",
    "attaccalite", "facciata", "invertivolt", "riposo", "attrazione", "furto",
    "alacciaio", "baratto", "idrovampata", "vampata", "trespolo", "focalcolpo",
    "energipalla", "falsofinale", "acquadisale", "lancio", "raggioscossa",
    "resistenza", "dragopulsar", "assorbipugno", "fuocofatuo", "ronzio",
    "congiura", "esplosione", "ombrartigli", "rivincita", "riciclo",
    "gigaimpatto", "lucidatura", "flash", "pietrataglio", "slavina", "tuononda",
    "vortexpalla", "danzaspada", "levitoroccia", "psicamisù", "urlorabbia",
    "neropulsar", "frana", "forbice x", "sonnolalia", "battiterra",
    "velenpuntura", "mangiasogni", "laccioerboso", "bullo", "spennata",
    "retromarcia", "sostituto", "cannonflash", "distortozona", "taglio", "volo",
    "surf", "forza", "scacciabruma", "spaccaroccia", "cascata", "scalaroccia",
}
m[8] = { MT = zipLongestWithKeys("SpSc", mt8spsc, "DLPS", mt8dlps) }

-- stylua: ignore
m[8].DT = {
    [0] = "danzaspada", "corposcontro", "lanciafiamme", "idropompa", "surf",
    "geloraggio", "bora", "colpo basso", "fulmine", "tuono", "terremoto",
    "psichico", "agilità", "focalenergia", "metronomo", "fuocobomba",
    "cascata", "amnesia", "sanguisuga", "tripletta", "sostituto",
    "contropiede", "fangobomba", "punte", "oltraggio", "psicoshock",
    "resistenza", "sonnolalia", "megacorno", "staffetta", "ripeti",
    "codacciaio", "sgranocchio", "palla ombra", "divinazione", "baraonda",
    "ondacalda", "provocazione", "raggiro", "troppoforte", "baratto",
    "calciardente", "granvoce", "vampata", "cosmoforza", "fanghiglia",
    "ferroscudo", "dragartigli", "granfisico", "calmamente", "fendifoglia",
    "dragodanza", "vortexpalla", "zuffa", "fielepunte", "fuococarica",
    "forzasfera", "velenpuntura", "neropulsar", "semebomba", "forbice x",
    "ronzio", "dragopulsar", "gemmoforza", "focalcolpo", "energipalla",
    "baldeali", "geoforza", "congiura", "cozzata zen", "cannonflash",
    "verdebufera", "vigorcolpo", "sporcolancio", "metaltestata",
    "pietrataglio", "levitoroccia", "laccioerboso", "fangonda", "pesobomba",
    "energisfera", "ripicca", "veicolaforza", "cambiaposto", "idrovampata",
    "cuordileone", "sprizzalampo", "giravvita", "marchiafuoco", "tifone",
    "carineria", "velenotrappola", "magibrillio", "braccioteso",
    "forza equina", "colpo infernale", "sferapolline", "psicozanna",
    "idrobreccia", "schiacciacorpo",
}
for k, v in pairs(m[8].DT) do
    m[8].DT[k] = { { "SpSc", v } }
end

-- stylua: ignore
local mt9sv ={
    "riduttore", "fascino", "falselacrime", "agilità", "fangosberla",
    "visotruce", "protezione", "rogodenti", "fulmindenti", "gelodenti",
    "idropulsar", "colpo basso", "acidobomba", "acrobazia", "entomoblocco",
    "psicoraggio", "stordiraggio", "furto", "incantavoce", "apripista",
    "balzo", "doccia fredda", "raggioscossa", "turbofuoco", "facciata",
    "velenocoda", "aeroassalto", "battiterra", "sciagura", "urlorabbia",
    "ferrartigli", "comete", "fogliamagica", "ventogelato", "colpodifango",
    "rocciotomba", "assorbibacio", "nitrocarica", "calciobasso", "aerasoio",
    "veicolaforza", "ombra notturna", "lancio", "codadrago", "velenoshock",
    "slavina", "resistenza", "invertivolt", "giornodisole", "pioggiadanza",
    "terrempesta", "vista innevata", "sottilcorno", "psicoshock", "fossa",
    "semitraglia", "falsofinale", "breccia", "cozzata zen", "retromarcia",
    "ombrartigli", "ripicca", "psicozanna", "granfisico", "eterelama",
    "corposcontro", "fuocopugno", "tuonopugno", "gelopugno", "sonnolalia",
    "semebomba", "energisfera", "assorbipugno", "riflesso", "schermoluce",
    "cadutamassi", "cascata", "dragartigli", "magibrillio", "metronomo",
    "laccioerboso", "tuononda", "velenpuntura", "battipiedi", "riposo",
    "frana", "provocazione", "danzaspada", "schiacciacorpo", "punte",
    "fielepunte", "esclusiva", "cannonflash", "neropulsar", "sanguisuga",
    "elettromistero", "volo", "baratto", "metaltestata", "dragodanza",
    "gemmoforza", "sporcolancio", "sostituto", "ferroscudo", "forbice x",
    "giravvita", "fuocofatuo", "sgranocchio", "raggiro", "idrobreccia",
    "gigassorbimento", "sferapulsar", "ventoincoda", "palla ombra",
    "dragopulsar", "levitoroccia", "granvoce", "ondacalda", "energipalla",
    "psichico", "pesobomba", "ripeti", "surf", "vortighiaccio",
    "lanciafiamme", "fulmine", "carineria", "amnesia", "calmamente",
    "altruismo", "sferapolline", "staffetta", "geoforza", "contropiede",
    "geloraggio", "campo elettrico", "campo erboso", "campo psichico",
    "campo nebbioso", "congiura", "fuocobomba", "idropompa", "bora",
    "fiammapatto", "acquapatto", "erbapatto", "sprizzalampo", "fangobomba",
    "terremoto", "pietrataglio", "spettrotuffo", "gigaimpatto", "incendio",
    "idrocannone", "radicalbero", "oltraggio", "vampata", "focalcolpo",
    "verdebufera", "tifone", "distortozona", "ronzio", "iper raggio",
    "baldeali", "fuococarica", "tuono", "zuffa", "solarraggio",
    "dragobolide", "raggio d'acciaio", "terascoppio",
    -- first DLC
    "boato", "sottocarica", "nube", "tossina", "sabbiotomba", "dispetto",
    "gravità", "abbattimento", "vortexpalla", "privazione", "coleomorso",
    "superzanna", "vuotonda", "assalto", "forza equina", "gelolancia",
    "idrovampata", "marchiafuoco", "lama solare", "baraonda",
    "centripugno", "palla clima", "erboscivolata", "fiamminvidia",
    "virata", "doppia ala", "poltergeist", "sfogarabbia", "squamacolpo",
    "nebbioscoppio",
    -- second DLC
    "malcomune", "psicamisù", "sdoppiatore", "rimonta", "fiortempesta",
    "rabbia bruciante", "mulinello", "fanghiglia", "elettrotuffo",
    "elettrotela", "triplo axel", "coaching", "fangonda", "sabbiardente",
    "danzadipiume", "divinazione", "vastenergia", "strisciacolpo",
    "raggiometeora", "colpo infernale", "vastoimpatto", "ferrostrido",
    "maledizione", "pressa d'acciaio", "grido del drago", "ammaliavoce",
    "psicorumore", "colpo di mano"
}

-- stylua: ignore
local mt9lpza = {
    "bottintesta", "dragartigli", "psicoshock", "spaccaroccia", "boato",
    "calmamente", "tossina", "tuononda", "virata", "breccia", "granfisico",
    "frana", "geloraggio", "rogodenti", "gelodenti", "schermoluce",
    "protezione", "crescipugno", "gemmoforza", "carineria", "fulmindenti",
    "aeroassalto", "tuonopugno", "gelopugno", "sgranocchio", "energipalla",
    "comete", "fossa", "fuocopugno", "danzaspada", "riflesso", "doppioteam",
    "corposcontro", "nottesferza", "resistenza", "rocciotomba", "levitoroccia",
    "fuocobomba", "scarica", "semitraglia", "idropulsar", "gigassorbimento",
    "volo", "iper raggio", "privazione", "colpodifango", "agilità",
    "autodistruzione", "ventogelato", "vampata", "salvaguardia", "geoforza",
    "fangobomba", "dragobolide", "gigaimpatto", "sdoppiatore", "fuocofatuo",
    "metaltestata", "cozzata zen", "divinazione", "ombrartigli",
    "lanciafiamme", "psichico", "solarraggio", "pietrataglio", "invertivolt",
    "fulmine", "ondacalda", "terremoto", "mulinello", "granvoce", "turbofuoco",
    "surf", "palla ombra", "dragopulsar", "idrobreccia", "velenpuntura",
    "battiterra", "tifone", "ferroscudo", "forbice x", "retromarcia",
    "congiura", "cannonflash", "sostituto", "sprizzalampo", "codacciaio",
    "punte", "fielepunte", "neropulsar", "maledizione", "magibrillio",
    "oltraggio", "turbine", "provocazione", "idropompa", "anticura",
    "cascata", "metronomo", "sporcolancio", "elettrotela", "focalcolpo",
    "cuordileone", "fuococarica", "bora", "tuono", "zuffa"
}

m[9] = { MT = zipLongestWithKeys("SV", mt9sv, "LPZA", mt9lpza) }

return m
