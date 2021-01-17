import strformat, sequtils, tables, strutils, sugar

let 
    ids = readFile("2018/D02.txt").splitLines
    idFreq = ids.mapIt(it.toCountTable)

proc hasVal[T](tbl: CountTable[T], val: int): bool =
    for _, v in tbl:
        if v == val: 
            return true

block part1:
    var 
        count2 = idFreq.countIt(it.hasVal(2))
        count3 = idFreq.countIt(it.hasVal(3))
        checksum = count2 * count3
    echo &"Checksum of box IDs: {checksum}"

proc diffEq1(a, b: string): bool =
    zip(a, b).mapIt(if it[0] != it[1]: 1 else: 0).foldl(a + b) == 1

block part2:
    var combinations = collect(newSeq):
        for i in 0..ids.high:
            for j in i+1..ids.high:
                (ids[i], ids[j])
    let 
        pair = combinations.filterIt(diffEq1(it[0], it[1]))[0]
        commonLetters = collect(newSeq):
            for i in 0..pair[0].high:
                if pair[0][i] == pair[1][i]:
                    pair[0][i]
    echo &"Common letters between two correct box IDs: {commonLetters.join}"

