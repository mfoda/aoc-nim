import strutils, tables, strformat, sequtils


proc transpose[T](coll: seq[seq[T]]): seq[seq[T]] =
    let 
        rowH = coll[0].high
        colH = coll.high
    for row in 0..rowH:
        var tmp: seq[T] = @[]
        for col in 0..colH:
            tmp.add(coll[col][row])
        result.add(tmp)

let message = readFile("2016/D06.txt").splitLines
let cols2rows = message.mapIt(it.toSeq).transpose.mapIt(it.join)

# part 1
proc errorCorrect1(strs: seq[string]): string =
    for str in strs:
        result &= str.toCountTable.largest.key

echo &"Error-corrected version of message: {errorCorrect1(cols2rows)}"

# part 2
proc errorCorrect2(strs: seq[string]): string =
    for str in strs:
        result &= str.toCountTable.smallest.key

echo &"Error-corrected version of message: {errorCorrect2(cols2rows)}"
