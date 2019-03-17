--[=[

Base module to build a PrevNext, the navigation bar at the top of a page
linking previous and next elements (whatever this means in a specific context).

Exports both a Lua and a WikiCode interface in order to work as the base class
in both environments.

To invoke this module from WikiCode the syntax is almost the same as
template:PrevNext.

{{#invoke: PrevNext | PrevNext | <args> }}

Arguments are (in Italian, copied from the template):
    - colorscheme: colore, preso dal [[Modulo:Colorscheme|colorscheme]]
    - color e color2: per usare colori del [[Modulo:Colore|modulo colore]]
                      invece di quelli del colorscheme (facoltativo il secondo)
    - prev: elemento precedente, da omettere se non presente
    - prevlink: se deve linkare da un'altra parte (facoltativo)
    - prevspr: se va mostrato un MiniSprite, numero di Dex di quest'ultimo
               (compresa eventuale sigla della forma)
    - prevsup: per mostrare un eventuale [[Modulo:Sup|sup]] di fianco alla voce
               (le sigle utilizzabili sono elencate in [[Modulo:Sigle/data|questa pagina]])
    - prevbag: ''yes'' se è uno strumento e va mostrato lo sprite della borsa
    - previmg: link ad un'immagine, che sarà aggiunta as is vicino alla voce.
               Se passato viene ignorato "prevspr" (ma non prevbag).
    - next, nextlink, nextspr, nextsup, nextbag, nextimg: come sopra ma per
                l'elemento successivo
    - prev2, prevlink2, prevspr2, prevsup2, prevbag2, previmg2: per mostrare un
                secondo elemento precedente (funzionano come i precedenti)
    - next2, nextlink2, nextspr2, nextsup2, nextbag2, nextimg2: per mostrare un
                secondo elemento successivo (funzionano come i precedenti)
    - list: link dell'elemento centrale
    - series: se deve mostrare altro testo
    - img: per mostrare una miniimmagine ai lati dell'elemento centrale
           (specificare l'estensione ed eventualmente la dimensione)

--]=]

local p = {}

local txt = require('Wikilib-strings') -- luacheck: no unused
local w = require('Wikilib')
local css = require('Css')
local ms = require('MiniSprite')
local links = require('Links')
local sup = require("Sup-data")

p.strings = {
    MAIN_BOX = [=[
<div style="padding: 0.3em 0;">
<div class="flex flex-row flex-wrap flex-items-stretch flex-main-stretch roundy text-center black-text" style="padding: 0.2em; ${bg}">${prevbox}${middlebox}${nextbox}</div></div>]=],
    SIDE_BOX = [=[
<div class="width-xl-30 ${class1}" style="padding: 0.2em;">
<div class="flex flex-row flex-wrap flex-items-center flex-main-center roundy height-100 ${class2}" style="padding: 0.2em;">${content}</div></div>]=],
    MIDDLE_BOX = [=[
<div class="width-xl-30 width-sm-100" style="padding: 0.2em;">
<div class="flex flex-row flex-items-center flex-main-center roundy white-bg height-100" style="padding: 0.2em;">${imgpre}${list}${imgpost}</div></div>]=],
    PREV_CONTENT = [=[
<div class="width-xl-100">[[${link}|&larr;]]${spr}${bag}&nbsp;[[${link}|${name}]]${sup}</div>]=],
    NEXT_CONTENT = [=[
<div class="width-xl-100">${spr}${bag}[[${link}|${name}]]${sup}&nbsp;[[${link}|&rarr;]]</div>]=],
}

--[[

Add a &nbsp; at the beginning or at the end of a string, depending on the
direction. If str is nil, returns nil.

Arguments:
    - str: the string to add the &nbsp; to. If nil, the funciton returns nil
    - dir: direction, either "prev" or "next" (add the &nbsp; resp. before and
           after the string)

--]]
local addNbsp = function(str, dir)
    if not str then
        return nil
    end
    if dir == "prev" then
        return "&nbsp;" .. str
    else
        return str .. "&nbsp;"
    end
end

--[[

Creates the markup for a side of the PrevNext, ie. anything on one side of the
middle box.

Arguments:
    - presence: a boolean containing whether the content is present or not
    - content: a string with the whole content

--]]
p.sideBox = function(presence, content)
    return string.interp(p.strings.SIDE_BOX, {
        class1 = presence and "width-sm-100" or "hidden-sm",
        class2 = presence and "white-bg" or "hidden-xl",
        content = presence and content
    })
end

--[[

Creates the markup for the box in the middle of the PrevNext.

Arguments:
    - list: string to link the list (full WikiCode)
    - img: img file name. If you don't want to show any image pass nil

--]]
p.middleBox = function(list, img)
    local imglink = img and table.concat{"[[File:", img, "]]"}
    return string.interp(p.strings.MIDDLE_BOX, {
        imgpre = addNbsp(imglink, "next") or "",
        list = list,
        imgpost = addNbsp(imglink, "prev") or "",
    })
end

--[[

Arguments (named):
    - dir: either "prev" or "next", direction of the content
    - name: the displayed name of the element
    - link: (optional) link of the element, if nil uses the name
    - spr: (optional) ndex for the MiniSprite of the element
    - bag: (optional) if "yes" the element should display an image via the
                      template bag
    - img: (optional) an image to add. If given, spr parameter is ignored (but
                      not bag)
    - sup: (optional) abbr of the game to put in the sup

--]]
p.makeContentLine = function(args)
    local interpdata = {
        link = args.link or args.name,
        name = args.name,
        spr = addNbsp(args.img or ms.staticLua(args.spr), args.dir) or "",
        bag = args.bag == "yes" and addNbsp(links.bag(args.name), args.dir)
                                or "",
        sup = args.sup and sup[args.sup] or "",
    }
    if args.dir == "prev" then
        return string.interp(p.strings.PREV_CONTENT, interpdata)
    else
        return string.interp(p.strings.NEXT_CONTENT, interpdata)
    end
end

--[[

Arguments (named):
    - dir: either "prev" or "next", the direction of the content
    - name: name of the element
    - link: (optional) link of the element
    - spr:
    - bag:
    - img:
    - sup:
    - all these with a trailing 2 (optionals)

--]]
p.makeContent = function(args)
    -- Args has more values, but all the values needed have the same key
    local res = p.makeContentLine(args)
    if args.name2 then
        res = res .. p.makeContentLine{
            dir = args.dir,
            name = args.name2,
            link = args.link2,
            spr = args.spr2,
            bag = args.bag2,
            img = args.img2,
            sup = args.sup2,
        }
    end
    return res
end


--[[

Lua interface.

Arguments are named because of their number. Names are the same as WikiCode
interface.

--]]
p.PrevNextLua = function(args)
    local bgargs = args.color and { type = args.color, type2 = args.color2 }
                              or { colorscheme = args.colorscheme or "pcwiki" }
    local prevpresence = args.prev and args.prev ~= "Nessuna"
    local nextpresence = args.next and args.next ~= "Nessuna"
    local listlink = string.interp("[[${link}|${name}]]", {
        link = args.list,
        name = args.series or args.list,
    })
    local prevcontent = p.makeContent{
        dir = "prev",
        name = args.prev,
        link = args.prevlink,
        spr = args.prevspr,
        bag = args.prevbag,
        img = args.previmg,
        sup = args.prevsup,
        name2 = args.prev2,
        link2 = args.prevlink2,
        spr2 = args.prevspr2,
        bag2 = args.prevbag2,
        img2 = args.previmg2,
        sup2 = args.prevsup2,
    }
    local nextcontent = p.makeContent{
        dir = "next",
        name = args.next,
        link = args.nextlink,
        spr = args.nextspr,
        bag = args.nextbag,
        img = args.nextimg,
        sup = args.nextsup,
        name2 = args.next2,
        link2 = args.nextlink2,
        spr2 = args.nextspr2,
        bag2 = args.nextbag2,
        img2 = args.nextimg2,
        sup2 = args.nextsup2,
    }
    return string.interp(p.strings.MAIN_BOX, {
        bg = css.horizGradLua(bgargs),
        prevbox = p.sideBox(prevpresence, prevcontent),
        nextbox = p.sideBox(nextpresence, nextcontent),
        middlebox = p.middleBox(listlink, args.img),
    })
end

--[[

WikiCode interface. Documented in the file comment.

--]]
p.PrevNext = function(frame)
    return p.PrevNextLua(w.emptyStringToNil(frame.args, string.trim))
end

p.prevnext = p.PrevNext

return p
