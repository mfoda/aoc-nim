import strutils, strformat

let input = readFile("2015/D01.txt")

var currFloor: int
var basementIdx: int
for idx, direction in input:
    currFloor += (case direction:
    of '(': +1
    of ')': -1
    else: raise newException(ValueError, "invalid direction"))
    if basementIdx == 0 and currFloor == -1:
        basementIdx = idx

# part 1
echo &"Floor reached after following directions: {currFloor}"

# part 2
echo &"Position of direction leading to basement: {basementIdx + 1}"