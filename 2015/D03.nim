import strutils, sequtils, strformat

let input = readFile("2015/D03.txt")

type Loc = tuple[x: int, y: int]

proc moveTo(dir: char, currLoc: Loc): Loc = 
    var newLoc = currLoc
    case dir:
        of '>':
            newLoc.x += 1
        of '<':
            newLoc.x -= 1
        of '^':
            newLoc.y += 1
        of 'v':
            newLoc.y -= 1
        else:
            raise newException(ValueError, "invalid direction")
    return newLoc

# part 1
proc part1(): seq[Loc] =
    var loc = (x: 0, y: 0)
    result.add(loc)
    for dir in input:
        loc = moveTo(dir, loc)
        result.add(loc)

let uniqVisits1 = part1().deduplicate.len
echo &"Number of houses that received at least one present: {uniqVisits1}"

# part 2
proc part2(): seq[Loc] = 
    var 
        santaLoc = (x: 0, y: 0)
        roboLoc = (x: 0, y: 0)
        visited = @[santaLoc, roboLoc]
        flipFlop = true
        loc:Loc 
    for dir in input:
        if flipFlop:
            loc = santaLoc
            loc = moveTo(dir, loc)
            santaLoc = loc
        else:
            loc = roboLoc
            loc = moveTo(dir, loc)
            roboLoc = loc
        flipFlop = not flipFlop
        visited.add(loc)
    return visited

let uniqVisits2 = part2().deduplicate.len
echo &"Number of houses that received at least one present: {uniqVisits2}"