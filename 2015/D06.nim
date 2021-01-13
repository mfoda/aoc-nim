import strutils, sequtils, strformat, nre, sugar

# part 1
type Action1 = tuple
    x1: int
    y1: int
    x2: int
    y2: int
    fn: bool -> bool

proc parseAction1(str: string): Action1 =
    var fn: bool -> bool 
    if str.startsWith("turn on"):
        fn = (_: bool) => true
    if str.startsWith("turn off"):
        fn = (_: bool) => false
    if str.startsWith("toggle"):
        fn = (b: bool) => not b

    let capt = str.find(re"(\d+),(\d+) through (\d+),(\d+)").get.captures
    return (
        x1: capt[0].parseInt,
        y1: capt[1].parseInt,
        x2: capt[2].parseInt,
        y2: capt[3].parseInt,
        fn: fn
    )

let actions1 = readFile("2015/D06.txt").splitLines.map(parseAction1)

var grid1: array[1..1000, array[1..1000, bool]]
for action in actions1:
    for row in action.y1..action.y2:
        for col in action.x1..action.x2:
            grid1[row][col] = action.fn(grid1[row][col])

var countLit = 0
for row in 1..1000:
    for col in 1..1000:
        if grid1[row][col]: 
            countLit += 1

echo &"Number of lit lights after executing instructions: {countLit}"

# part 2
type Action2 = tuple
    x1: int
    y1: int
    x2: int
    y2: int
    fn: int -> int

proc parseAction2(str: string): Action2 =
    var fn: int -> int
    if str.startsWith("turn on"):
        fn = (n: int) => n + 1
    if str.startsWith("turn off"):
        fn = (n: int) => max(n - 1, 0)
    if str.startsWith("toggle"):
        fn = (n: int) => n + 2 

    let capt = str.find(re"(\d+),(\d+) through (\d+),(\d+)").get.captures
    return (
        x1: capt[0].parseInt,
        y1: capt[1].parseInt,
        x2: capt[2].parseInt,
        y2: capt[3].parseInt,
        fn: fn
    )

let actions2 = readFile("2015/D06.txt").splitLines.map(parseAction2)

var grid2: array[1..1000, array[1..1000, int]]
for action in actions2:
    for row in action.y1..action.y2:
        for col in action.x1..action.x2:
            grid2[row][col] = action.fn(grid2[row][col])

var totalBrightness = 0
for row in 1..1000:
    for col in 1..1000:
        totalBrightness += grid2[row][col]

echo &"Total brightness after executing all instructions: {totalBrightness}"

