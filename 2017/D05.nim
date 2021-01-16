import strformat, sequtils, strutils


var offsets = readFile("2017/D05.txt").splitLines.map(parseInt)

block part1:
    var 
        idx = 0
        steps = 0
        offsets = offsets
    while idx <= offsets.high:
        steps += 1
        var it = offsets[idx]
        offsets[idx] += 1
        idx += it

    echo &"Steps until reaching exit {steps}"

block part2:
    var 
        idx = 0
        steps = 0
        offsets = offsets
    while idx <= offsets.high:
        steps += 1
        var it = offsets[idx]
        offsets[idx] = if it >= 3: it - 1 else: it + 1
        idx += it

    echo &"Steps until reaching exit {steps}"