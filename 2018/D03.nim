import strformat, strutils, sequtils, strscans

type 
    Claim = object
        id: int
        x, y: int
        width, height: int
    Rect = array[1000, array[1000, int]]

proc parseClaim(str: string): Claim = 
    var id, x, y, w, h: int
    if not str.scanf("#$i @ $i,$i: $ix$i", id, x, y, w, h):
        raise newException(ValueError, "invalid claim") 
    Claim(
        id: id, x: x, y: y, width: w, height: h
    )

let claims = readFile("2018/D03.txt").splitLines.map(parseClaim)

proc markClaim1(rect: var Rect, claim: Claim): void =
    for h in 0..<claim.height:
        for w in 0..<claim.width:
            inc rect[claim.y + h][claim.x + w]

block part1:
    var rect: Rect
    for claim in claims:
        rect.markClaim1(claim)
    let twoPlusClaims = rect.mapIt(it.countIt(it >= 2)).foldl(a + b)
    echo &"Number of square inches of fabic with two or more claims is {twoPlusClaims}"

proc markClaim2(rect: var Rect, claim: Claim): void =
    for h in 0..<claim.height:
        for w in 0..<claim.width:
            var it = rect[claim.y + h][claim.x + w]
            rect[claim.y + h][claim.x + w] = if it == 0: claim.id else: -1

proc notOverlapped(rect: var Rect, claim: Claim): bool =
    for h in 0..<claim.height:
        for w in 0..<claim.width:
            if rect[claim.y + h][claim.x + w] != claim.id:
                return false
    return true

block part2:
    var rect: Rect
    for claim in claims:
        rect.markClaim2(claim)
    let nonOverlappedClaim = claims.filterIt(rect.notOverlapped(it))[0]
    echo &"ID of non-overlapping claim: {nonOverlappedClaim.id}"