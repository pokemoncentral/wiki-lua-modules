# Notes on DebRes
## Generics
Create a base class somewhere, then subclass also for current gen. The main
DebRes module should contain only the interface to the right (ie. current
gen) subclass

## Constructor
Actually there are two constructors. The first takes name and formname,
the second takes types and abilities.

Sequence of operations:
- parse input, and produces `types` and `abils`
- `setmetatable` (inheritance)
  - right now `DebRes-1` does some shit that set as metatable super.super
- `this:createColors()`
- check if abilities should actually be used (ONLY `DebRes`)
- actual computation of types for each effectiveness
- footer creation

# TODO
- Merge `DebRes` and `DebRes-base`? How does this impact glitches?
- Cleanup all the shit
- Tests for glitches
