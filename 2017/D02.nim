import strformat, strutils, sequtils

let rows = readFile("2017/D02.txt").splitLines.mapIt(it.split.map(parseInt))

# part 1
proc checksum1(rows: seq[seq[int]]): int =
    rows.mapIt(it.max - it.min).foldl(a + b)

echo &"Checksum using max/min diff: {rows.checksum1}"

# part 2
proc findEvenDivision(row: seq[int]): int =
    for i in 0..row.high:
        for j in i+1..row.high:
            let a = row[i]
            let b = row[j]
            if a mod b == 0:
                return a div b
            if b mod a == 0:
                return b div a

proc checksum2(rows: seq[seq[int]]): int =
    rows.map(findEvenDivision).foldl(a + b)

echo &"Checksum using divisors: {rows.checksum2}"