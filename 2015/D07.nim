import strutils, strformat, nre, tables

proc executeInstruction(instruction: string, instructions: seq[string], state: TableRef[string, uint16]) = 
    let tokens = instruction.split(" -> ")
    let lhs = tokens[0].split(' ')
    let rhs = tokens[1]
    var x, y: uint16
    var op:string

    proc retrieve(variable: string): uint16 =
        for ins in instructions:
            if ins.split(' ')[^1] == variable:
                executeInstruction(ins, instructions, state)
                return state[variable]
        raise newException(IndexDefect, &"failed to retrieve variable {variable}")
            
    proc substitute(variable: string): uint16 =
        if variable in state:
            return state[variable]
        if variable.match(re"\d+").isSome:
            return uint16(variable.parseUInt) 
        return retrieve(variable) 

    case lhs.len:
        of 1: # assignment
            state[rhs] = substitute(lhs[0])
        of 2: # unary op
            op = lhs[0]
            x = substitute(lhs[1])
            if op == "NOT":
                state[rhs] = not x
            else:
                raise newException(ValueError, "invalid unary op")
        of 3: # binary op
            op = lhs[1]
            x = substitute(lhs[0])
            y = substitute(lhs[2])
            state[rhs] = case op:
                of "RSHIFT":
                    x shr y
                of "LSHIFT":
                    x shl y
                of "OR":
                    x xor y
                of "AND":
                    x and y
                else:
                    raise newException(ValueError, "invalid binary op")
        else:
            raise newException(ValueError, "invalid number of tokens")

var state = newTable[string, uint16]()
var instructions = readFile("2015/D07.txt").splitLines

proc executeAll() = 
    for instruction in instructions:
        executeInstruction(instruction, instructions, state)

block part1:
    executeAll()
    let wireA = state["a"]
    echo &"Signal provided to wire 'a' after execution: {wireA}"

block part2:
    var wireA = state["a"]
    state = newTable[string, uint16]()
    state["b"] = wireA
    executeAll()
    wireA = state["a"]
    echo &"Signal provided to wire 'a' after replacement: {wireA}"