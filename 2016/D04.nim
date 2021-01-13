import strutils, sequtils, nre, tables, algorithm, sugar, strformat

type Room = object
    name: string
    sectorID: int
    checksum: string

proc parseRoom(str: string): Room = 
    let 
        match = str.match(re"([a-z-]+)-(\d+)\[(\w+)\]")
        capt = match.get.captures 
    if match.isNone:
        raise newException(ValueError, "parse room failed")
    Room(
        name: capt[0],
        sectorID: capt[1].parseInt,
        checksum: capt[2]
    )

proc isRealRoom(room: Room): bool = 
    # compare descending by val then ascending by key
    proc cmpCustom[T](a, b: tuple[key: T, val: int]): int =
        let 
            cmpVal = cmp(b.val, a.val)
            cmpKey = cmp(a.key, b.key)
        if cmpVal == 0: cmpKey else: cmpVal
    var 
        freq = room.name.filterIt(it.isAlphaAscii).toCountTable
        pairs = collect(newSeq):
            for k, v in freq.pairs:
                (key: k, val: v)
    pairs = pairs.sorted(cmpCustom)

    var keys = collect(newSeq):
        for p in pairs[..4]: p.key
    keys.join() == room.checksum

let
    input = readFile("2016/D04.txt").splitLines
    rooms = input.map(parseRoom)
    realRooms = rooms.filter(isRealRoom)

# part 1
let idSum = realRooms.mapIt(it.sectorID).foldl(a + b)
echo &"Sum of real room sector IDs: {idSum}"

# part 2
proc decrypt(room: Room): string =
    proc rot(ch: char): char =
        var it = int(ch)
        for _ in 1..room.sectorID:
            it = (it mod 97 + 1) mod 26 + int('a')
        return char(it)
    for ch in room.name:
        result &= (if ch == '-': ' ' else: rot(ch))

proc findE[T](coll: seq[T], fn: T -> bool): T =
    for e in coll:
        if fn(e): return e
    raise newException(IndexDefect, "no matching element found")

let northPoleRoom = realRooms.findE(x => x.decrypt.contains("northpole"))
echo &"Sector ID of room where north pole objects are stored: {northPoleRoom.sectorID}"
