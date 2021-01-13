import strutils, strformat, md5

let input = "ckczppom"

proc findHashPrefixN(prefix: string): int =
    var hash: string
    var index = 0
    while not hash.startsWith(prefix):
        hash = getMD5(input & index.intToStr)
        index += 1
    return index - 1

# part 1
echo &"Lowest positive number producing hash with 5 leading zeros: {findHashPrefixN(\"00000\")}"
# part 2
echo &"Lowest positive number producing hash with 6 leading zeros: {findHashPrefixN(\"000000\")}"