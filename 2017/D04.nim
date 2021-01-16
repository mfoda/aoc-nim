import sequtils, strutils, strformat, algorithm

let passphrases = readFile("2017/D04.txt").splitLines

# part 1
proc isValidPassphrase1(passphrase: string): bool =
    let words = passphrase.split
    words.deduplicate.len == words.len

echo &"Number of valid passphrases: {passphrases.filter(isValidPassphrase1).len}"

# part 2 
proc isAnagram(a: string, b: string): bool =
    a.sorted == b.sorted

proc isValidPassphrase2(passphrase: string): bool =
    let words = passphrase.split
    for i in 0..words.high:
        for j in i+1..words.high:
            if isAnagram(words[i], words[j]):
                return false
    return true

echo &"Number of valid passphrases: {passphrases.filter(isValidPassphrase2).len}"
