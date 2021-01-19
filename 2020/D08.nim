import strformat, strutils, sequtils

type 
    Acc = int
    Op = enum
        opAcc, opJmp, opNop
    Instruction = object
        op: Op
        arg: int

proc parseInstruction(str: string): Instruction =
    let 
        tokens = str.split
        op = case tokens[0]:
            of "nop": opNop
            of "jmp": opJmp
            of "acc": opAcc
            else: raise newException(ValueError, "invalid op")
        arg = tokens[1].parseInt
    Instruction(op: op, arg: arg)

proc runUntilLoop(instructions: seq[Instruction]): Acc =
    var 
        acc: int
        ip: int
        visitedIPs: seq[int]
    while ip notin visitedIPs: 
        visitedIPs.add(ip) 
        let inst = instructions[ip]
        case inst.op: 
        of opNop: discard
        of opAcc: 
            acc += inst.arg
        of opJmp: 
            ip += inst.arg
            continue
        inc ip
    return acc

let instructions = readFile("2020/D08.txt").splitLines.map(parseInstruction)

# part 1
let acc = instructions.runUntilLoop
echo &"Accumulator value before entering infinite loop: {acc}"

# part 2
proc tryRun(instructions: seq[Instruction]): Acc =
    var 
        acc: int
        ip: int
        visitedIPs: seq[int]
    while true:
        if ip > instructions.high:
            return acc
        if ip in visitedIPs: 
            raise newException(OverflowDefect, "entered infinte loop")
        visitedIPs.add(ip) 
        let inst = instructions[ip]
        case inst.op: 
        of opNop: 
            inc ip
        of opAcc: 
            acc += inst.arg
            inc ip
        of opJmp: 
            ip += inst.arg

var mInstructions = instructions
block part2:
    for i in 0..mInstructions.high:
        let 
            inst = mInstructions[i]
            origOp = inst.op
        try:
            if inst.op == opJmp:
                mInstructions[i].op = opNop
                echo &"Value of acc after terimination {mInstructions.tryRun}"
                break part2
            elif inst.op == opNop:
                mInstructions[i].op = opJmp
                echo &"Value of acc after terimination {mInstructions.tryRun}"
                break part2
        except OverflowDefect:
            mInstructions[i].op = origOp
