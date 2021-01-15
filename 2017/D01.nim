import strutils, sequtils, strformat

var digits = readFile("2017/D01.txt").toSeq.mapIt(($it).parseInt)
# make circular
digits.insert(digits[0], 0)

# part 1 
proc sumConsec(digits: seq[int]): int =
    for i in 0..<digits.high:
        if digits[i] == digits[i + 1]:
            result += digits[i]


let sum1 = digits.sumConsec
echo &"Sum of consecutive digits: {sum1}"

# part 2 
proc sumMirror(digits: seq[int]): int =
    for i in 0..digits.high:
        let j = (i + digits.len div 2) mod digits.len
        if digits[i] == digits[j]:
            result += digits[i]

let sum2 = digits[1..^1].sumMirror
echo &"Sum of mirrored digits: {sum2}"
