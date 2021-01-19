import strformat, sequtils, strutils

let entries = readFile("2020/D01.txt").splitlines.map(parseInt)

# part 1
for i in 0..entries.high:
    for j in i+1..entries.high:
        let 
            a = entries[i] 
            b = entries[j]
        if a + b == 2020:
            echo &"Multiple of two entries summing to 2020: {a * b}"

# part 2
for i in 0..entries.high:
    for j in i+1..entries.high:
        for k in j+1..entries.high:
            let 
                a = entries[i] 
                b = entries[j]
                c = entries[k]
            if a + b + c == 2020:
                echo &"Multiple of three entries summing to 2020: {a * b * c}"