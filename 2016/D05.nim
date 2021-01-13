import md5, strutils, strformat

let doorID = "cxdnnyjw"

# part 1
proc genHash1(id: string, count: int): string =
    var 
        hash = ""
        index = 0
    proc nextHash() =
        inc index
        hash = (id & $index).getMD5
    while true:
        while not hash.startsWith("00000"):
            nextHash()
        result &= hash[5]
        nextHash()
        if result.len == count: break

echo &"Password of door ID 'cxdnnyjw': {genHash1(doorID, 8)}"

# part 2
proc genHash2(id: string, count: int): string =
    var 
        hash = ""
        index = 0
    result = "X".repeat(8)
    proc nextHash() =
        inc index
        hash = (id & $index).getMD5
    while true:
        while not hash.startsWith("00000"):
            nextHash()
        let pos = if hash[5].isDigit: ($hash[5]).parseInt else: -1
        if pos != -1 and pos <= result.high and result[pos] == 'X': 
            result[pos] = hash[6]
        if 'X' notin result: break
        nextHash()

echo &"Password of door ID 'cxdnnyjw': {genHash2(doorID, 8)}"