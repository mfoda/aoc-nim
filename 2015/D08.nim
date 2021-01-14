import strutils, nre, sequtils, strformat

proc memSize(str: string): int =
    var str = str[1..^2]
    str = str.replace(r"\\", r"\")
    str = str.replace(r"\""", "\"")
    str = str.replace(re"(\\x[0-9a-f]{2})", ".")
    str.len

let strings = readFile("2015/D08.txt").splitLines

block part1:
    let totalCodeSize = strings.mapIt(it.len).foldl(a+b)
    let totalMemSize = strings.map(memSize).foldl(a+b)
    echo &"Total code size minus memory size of file: {totalCodeSize - totalMemSize}"

proc encode(str: string): string =
    var str = str
    str = str.replace("\\", r"\\")
    str = str.replace("\"", r"\""")
    return '"' & str & '"'

block part2:
    let totalCodeSize = strings.mapIt(it.len).foldl(a+b)
    let totalEncodedSize= strings.mapIt(it.encode.len).foldl(a+b)
    echo &"Total encoded size minus code size of file: {totalEncodedSize - totalCodeSize}"