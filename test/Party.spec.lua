--  "Test cases" for Party

local party = require("Party")

local poke = [==[

<div class="inline-block">
<div class="roundy text-center flex flex-row flex-main-space-around flex-wrap flex-items-center" style="padding: 1ex; {{#invoke: css | horizGrad | Spettro | normale | Veleno | {{#ifeq: {{lc:Veleno}} | {{lc:Spettro}} | light | normale}}}}}}">
<div class="width-xl-50 width-xs-100">
<div class="roundy img-fluid" style="padding: 0.5ex; background: #fff;">{{#invoke: Spr | Spr | 093 | Rosso | male {{#ifeq: {{lc:no}} | yes | back}} {{#ifeq: {{lc:no}} | yes | shiny}}}}</div>
<div class="roundy" style="background: #fff; margin-top: 1ex;">{{#ifexpr: 1 > 6 | {{#ifeq: Poké Ball | none | | {{bag|Poké Ball}}&nbsp;}}}}{{colore2|000|Haunter|{{ucfirst:Haunter}}}}{{#ifexpr: 1 > 1 | {{#switch: Haunter | Nidoran♀ | Nidoran♂ = | {{#switch: {{lc:none}} | male | ♂ = {{male}} | female | ♀ = {{female}} | both = {{male}}/{{female}}}}}}}}&nbsp;<span class="small-font">L.</span>55{{#ifexpr: 1 > 1 | {{#switch: {{lc:male}} | shiny | male shiny | female shiny = [[File:Shiny{{#switch: 1 | 2 = GS | 3 = RS | 4 = DP | 5 = BW | 6 = XY | 7 = SL}}Star.png]] | {{#ifeq: {{lc:no}} | yes | [[File:Shiny{{#switch: 1 | 2 = GS | 3 = RS | 4 = DP | 5 = BW | 6 = XY | 7 = SL}}Star.png]]}}}}}}</div>
</div>
<div class="width-xl-50 width-xs-100">
<div class="small-font" style="margin-bottom: 0.1ex;">Tip{{#ifeq: {{lc:Veleno}} | {{lc:Spettro}} | o | i }}:</div>
<div class="same-line roundy{{#ifeq: {{lc:Veleno}} | {{lc:Spettro}} | | left}}" style="padding: 0.4ex 1.2ex; background: #{{#invoke: colore | Spettro | dark}};">{{tcolore|{{#ifeq: {{lc:Veleno}} | {{lc:Spettro}} | {{ucfirst:Spettro}} | {{#ifeq: {{lc:Spettro}} | coleottero | Coleot | {{ucfirst:Spettro}}}}}}|fff}}</div>{{#ifeq: {{lc:Veleno}} | {{lc:Spettro}} | | <div class="same-line roundyright" style="padding: 0.4ex 1.2ex; background: #{{#invoke: colore | Veleno | dark}};">{{tcolore|{{#ifeq: {{lc:Veleno}} | coleottero | Coleot | {{ucfirst:Veleno}}}}|fff}}</div>}}{{#ifexpr: 1 > 2 |
<div class="small-font" style="margin-top: 0.5ex; margin-bottom: -0.5ex;">Abilit&agrave;:</div>
<div>{{acolor|{{ucfirst:Nessuna}}|000}}{{#if: |&nbsp;o {{acolor|{{ucfirst:{{{ability2}}}}}|000}}}}</div>}}{{#ifexpr: 1 > 1 |
<div class="small-font" style="margin-top: 0.5ex; margin-bottom: -0.5ex;">Strumento:</div>
<div>{{#if:  | {{Bag|{{{held}}}}} {{colore2|000|{{ucfirst:{{{held}}}}}}}|Nessuno}}</div>}}
</div>
{{#switch: {{lc:}} | gara | contest = <div class="width-xl-50 width-xs-100" style="padding: 0.5ex;">{{ContestMoveBox|name=Stordiraggio|cat=Grinta|hearts=0}}</div>
<div class="width-xl-50 width-xs-100" style="padding: 0.5ex;">{{ContestMoveBox|name=Ombra Notturna|cat=Grinta|hearts=0}}</div>
<div class="width-xl-50 width-xs-100" style="padding: 0.5ex;">{{ContestMoveBox|name=Ipnosi|cat=Grinta|hearts=0}}</div>
<div class="width-xl-50 width-xs-100" style="padding: 0.5ex;">{{ContestMoveBox|name=Mangiasogni|cat=Grinta|hearts=0}}</div> | #default = <div class="width-xl-50 width-xs-100" style="padding: 0.5ex;">{{MoveBox|name=Stordiraggio|type=Spettro|cat=Fisico|gen=1}}</div>
<div class="width-xl-50 width-xs-100" style="padding: 0.5ex;">{{MoveBox|name=Ombra Notturna|type=Spettro|cat=Fisico|gen=1}}</div>
<div class="width-xl-50 width-xs-100" style="padding: 0.5ex;">{{MoveBox|name=Ipnosi|type=Psico|cat=Fisico|gen=1}}</div>
<div class="width-xl-50 width-xs-100" style="padding: 0.5ex;">{{MoveBox|name=Mangiasogni|type=Psico|cat=Fisico|gen=1}}</div>}}
</div>
</div>]==]

-- Single + Shaded named colors + manual expandablelight

print(party.single({
    args = {
        color = "ghiaccio normale",
        headcolor = "ghiaccio light",
        bordercolor = "ghiaccio dark",
        sprite = "RB Agatha.png",
        prize = "[[File:Dollaro Pokémon.png|link=Dollari Pokémon]]5940",
        name = '<span style="color: #000;">Agatha</span>',
        game = "RB",
        location = "Altopiano Blu",
        pokemon = "5",
        expandiblelight = "yes",
    },
}))

print(poke:rep(3))

-- Div

print(party.div({ args = { color = "spettro" } }))

print(poke:rep(2))

print(party.footer())

-- Single + Shaded named colors + no expandablelight

print(party.single({
    args = {
        color = "ghiaccio dark",
        headcolor = "ghiaccio light",
        bordercolor = "ghiaccio normale",
        sprite = "RB Agatha.png",
        prize = "[[File:Dollaro Pokémon.png|link=Dollari Pokémon]]5940",
        name = '<span style="color: #000;">Agatha</span>',
        game = "RB",
        location = "Altopiano Blu",
        pokemon = "5",
    },
}))

print(poke:rep(3))

-- Div

print(party.div({ args = { color = "spettro" } }))

print(poke:rep(2))

print(party.footer())

-- Tag + hexes + shadeless named color + more games + automatic expandablelight

print(party.tag({
    args = {
        back1 = "7722FF",
        back2 = "rubinoomega",
        sprcolor1 = "terra normale",
        sprcolor2 = "terra light",
        head1 = "terra normale",
        head2 = "terra light",
        spr2color1 = "terra normale",
        spr2color2 = "terra light",
        class = "Magmatenente",
        name = '[[Magmatenente Ottavio|<span style="color: #000;">Ottavio</span>]]',
        sprite = "ROZA VSOttavio.png",
        size = "200px",
        class2 = "Recluta Team Magma",
        name2 = '<span style="color: #000;">Recluta</span>',
        sprite2 = "ROZA VSRecluta Team Magma F.png|200px",
        game = "RO S",
        location = "Cascate Meteora",
        prize = "[[File:Dollaro Pokémon.png|link=Dollari Pokémon]]3.220",
        pokemon1 = "2",
        pokemon2 = "1",
    },
}))

print(poke:rep(2))

print(party.div({ args = { color = "Rubinoomega light" } }))

print(poke)

print(party.footer())
