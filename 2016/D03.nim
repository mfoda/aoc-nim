import strutils, sequtils, sugar, strformat

type Tri = tuple
    a: int
    b: int
    c: int

proc isValidTri(t: Tri): bool =
    (t.a + t.b > t.c) and (t.a + t.c > t.b) and (t.c + t.b > t.a)

proc parseTri(sides: array[3, string]): Tri =
    let nums = sides.map(parseInt)
    (a: nums[0], b: nums[1], c: nums[2])

let lines = readFile("2016/D03.txt").splitLines

# part 1 
let tris = collect(newSeq): 
    for line in lines:
        let sides = line.splitWhitespace
        parseTri([sides[0], sides[1], sides[2]])

let validTris1 = tris.filter(isValidTri)
echo &"Number of valid triangles: {validTris1.len}"

# part 2 
proc transpose[T](coll: seq[seq[T]]): seq[T] =
    let 
        rowH = coll[0].high
        colH = coll.high
    for row in 0..rowH:
        for col in 0..colH:
            result.add(coll[col][row])

proc chunksOf[T](coll: seq[T], n: int): seq[seq[T]] =
    for i in countup(0, coll.len - n, n):
        result.add coll[i..i + n - 1] 

let transposed = lines.mapIt(it.splitWhitespace).transpose

let validTris2 = transposed.chunksOf(3)
                           .mapIt(parseTri [it[0], it[1], it[2]])
                           .filter(isValidTri)

echo &"Number of valid triangles: {validTris2.len}"