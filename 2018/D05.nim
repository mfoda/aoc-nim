import sequtils, strformat, strutils, sugar

type 
    Polymer = seq[Unit]
    Unit = char

let polymer = readFile("2018/D05.txt").toSeq

proc isOppositePolarity(a, b: Unit): bool =
    a != b and a.toLowerAscii == b.toLowerAscii

proc react(polymer: Polymer): Polymer =
    var polymer = polymer
    var idx = 0
    while idx < polymer.high - 1:
        if isOppositePolarity(polymer[idx], polymer[idx + 1]):
            polymer.delete(idx, idx + 1)
            dec idx
        else:
            inc idx
        idx = max(idx, 0)
    return polymer

# part 1
echo &"Units remaining after fully reacting polymer {polymer.react.len}"

# part 2
proc removeReact(polymer: Polymer, unit: Unit): Polymer =
    var polymer = polymer
    polymer.keepItIf(it != unit.toLowerAscii and it != unit.toUpperAscii)
    return polymer.react

let units = ('a'..'z').toSeq
var reactedPolymers = collect(newSeq):
    for unit in units:
        polymer.removeReact(unit)

echo &"Length of shortest polymer possible: {reactedPolymers.mapIt(it.len).min}"