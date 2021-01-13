import strutils, nre, sequtils, sugar, strformat

type 
    Screen = array[6, array[50, bool]]
    Action = enum aRect, aRotRow, aRotCol
    Instruction = object
        action: Action
        a, b: int

proc rect(screen: var Screen, a, b: int) = 
    for row in 0..<b:
        for col in 0..<a:
            screen[row][col] = true

proc rotRow(screen: var Screen, row, amt: int) =
    var rowCpy = screen[row]
    for i in 0..rowCpy.high:
        let rotIdx = (i + amt) mod rowCpy.len 
        rowCpy[rotIdx] = screen[row][i]
    screen[row] = rowCpy

proc rotCol(screen: var Screen, col, amt: int) =
    var colCpy = collect(newSeq):
        for row in screen: row[col]
    for i in 0..colCpy.high:
        let rotIdx = (i + amt) mod colCpy.len 
        colCpy[rotIdx] = screen[i][col]
    for i in 0..screen.high:
        screen[i][col] = colCpy[i] 

proc parseInstruction(str: string): Instruction =
    var 
        action: Action
        a, b:int
        captures: Captures
    if str.startsWith("rect"):
        captures = str.find(re"(\d+)x(\d+)").get.captures
        action = aRect 
    elif str.startsWith("rotate column"):
        captures = str.find(re"x=(\d+) by (\d+)").get.captures
        action = aRotCol 
    elif str.startsWith("rotate row"):
        captures = str.find(re"y=(\d+) by (\d+)").get.captures
        action = aRotRow 
    a = captures[0].parseInt
    b = captures[1].parseInt
    return Instruction(action: action, a: a, b: b)
        
let instructions = readFile("2016/D08.txt").splitLines.map(parseInstruction)
var screen: Screen

# part 1
for i in instructions:
    case i.action:
    of aRect:
        screen.rect(i.a, i.b)
    of aRotCol:
        screen.rotCol(i.a, i.b)
    of aRotRow:
        screen.rotRow(i.a, i.b)
    
let countLit = screen.mapIt(it.count(true)).foldl(a + b)
echo &"Number of lit pixels: {countLit}"

# part 2
for row in screen:
    echo row.mapIt(if it: '#' else: '.').join
 