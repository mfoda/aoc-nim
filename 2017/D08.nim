import strutils, strformat, sequtils, nre, tables, sugar

type 
    State = Table[string, int]
    Op = enum oInc, oDec
    Instruction = object
        targetReg: string
        op: Op
        targetVal: int
        testReg: string
        testCond: int -> bool

proc parseInstruction(str: string): Instruction =
    let 
        patt = re"(\w+) (inc|dec) ([-0-9]+) if (\w+) (.+) ([-0-9]+)"
        capt = str.match(patt).get.captures
        testVal = capt[5].parseInt
    Instruction(
        targetReg: capt[0],
        op: case capt[1]
            of "inc": oInc
            of "dec": oDec
            else: raise newException(ValueError, "invalid op"),
        targetVal: capt[2].parseInt,
        testReg: capt[3],
        testCond: case capt[4]:
            of ">" : (n:int) => n > testVal
            of ">=": (n:int) => n >= testVal
            of "<" : (n:int) => n < testVal
            of "<=": (n:int) => n <= testVal
            of "==": (n:int) => n == testVal
            of "!=": (n:int) => n != testVal
            else: raise newException(ValueError, "invalid cond")
    )

proc executeInstruction(state: var State, i: Instruction): int =
    if i.testReg notin state:
        state[i.testReg] = 0
    if i.testCond(state[i.testReg]):
        state[i.targetReg] = case i.op
            of oInc: state.getOrDefault(i.targetReg) + i.targetVal
            of oDec: state.getOrDefault(i.targetReg) - i.targetVal
    return state[i.targetReg]

let instructions = readFile("2017/D08.txt").splitLines.map(parseInstruction) 

# part 1
var state1 = initTable[string, int]()
for i in instructions:
    discard state1.executeInstruction(i)
var maxVal1: int
for k,v in state1.pairs:
    maxVal1 = max(maxVal1, v)

echo  &"Largest register value after execution: {maxVal1}"

# part 2
var state2 = initTable[string, int]()
var maxVal2: int
for i in instructions:
    let res = state2.executeInstruction(i)
    maxVal2 = max(maxVal2, res)

echo  &"Largest register value during execution: {maxVal2}"