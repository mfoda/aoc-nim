import strformat, strutils, sequtils

let 
    frequencyChanges = readFile("2018/D01.txt").splitLines.map(parseInt)
    frequencySum = frequencyChanges.foldl(a + b)

# part 1
echo &"Resulting frequency after changes: {frequencySum}"

var 
    idx = 0
    freq: int
    seen = @[freq]
while true:
    freq += frequencyChanges[idx]
    if freq in seen:
        break
    seen.add(freq)
    idx = (idx + 1) mod frequencyChanges.len

# part 2
echo &"First frequency reached twice: {freq}"