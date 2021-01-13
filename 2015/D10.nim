import strutils, strformat

const input = "1321131112"

proc groupByIdent[T](coll: seq[T]): seq[tuple[x: T, n: int]] =
    var i = 0
    while i <= coll.high:
        let x = coll[i]
        var n = 0
        while i + n <= coll.high and coll[i + n] == x:
            n += 1
        result.add (x: x, n: n)
        i += n

proc applyTransformation(n: int): string = 
    var sequence = input
    for _ in 1..n:
        let expanded = @sequence.groupByIdent()
        var newsequence = ""
        for group in expanded:
            newsequence.add &"{group.n}{group.x}"
        sequence = newsequence
    return sequence

# part 1
echo &"Length of result after applying 40 transformations: {applyTransformation(40).len}"
# part 1
echo &"Length of result after applying 50 transformations: {applyTransformation(50).len}"