import strutils, strformat

proc manhattanDist(x1: int, y1: int, x2 = 0, y2 = 0): int = 
    abs(x1 - x2) + abs(y1 - y2)

let instructions = readFile("2016/D01.txt").split(", ")

block part1:
    var 
        x,y, rot: int
    for inst in instructions:
        let 
            dir = inst[0]
            amt = inst[1..^1].parseInt
        if dir == 'R':
            rot = (rot + 90) mod 360
        if dir == 'L':
            rot = if rot == 0: 270 else: (rot - 90) mod 360
        case rot:
        of   0: y += amt
        of  90: x += amt
        of 180: y -= amt
        of 270: x -= amt
        else: discard

    echo &"Easter Bunny HQ is {manhattanDist(x, y)} blocks away"

block part2:
    type Loc = tuple[x, y: int]
    var 
        x,y, rot: int
        visited: seq[Loc]
    proc visitY(a, b: int) =
        for i in a+1..<b:
            var loc = (x: x, y: i)
            if loc in visited: echo manhattanDist(loc.x, loc.y)
            visited.add(loc)
    proc visitX(a, b: int) =
        for i in a+1..<b:
            var loc = (x: i, y: y)
            if loc in visited: echo manhattanDist(loc.x, loc.y)
            visited.add(loc)
    for inst in instructions:
        let 
            dir = inst[0]
            amt = inst[1..^1].parseInt
        if dir == 'R':
            rot = (rot + 90) mod 360
        if dir == 'L':
            rot = if rot == 0: 270 else: (rot - 90) mod 360
        case rot:
        of 0: 
            var y1 = y
            y += amt
            visitY(y1, y)
        of 90: 
            var x1 = x
            x += amt
            visitX(x1, x)
        of 180: 
            var y1 = y
            y -= amt
            visitY(y, y1)
        of 270: 
            var x1 = x
            x -= amt
            visitX(x, x1)
        else: discard