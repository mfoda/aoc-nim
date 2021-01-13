import strutils, sequtils, strformat

let lines = readFile("2015/D05.txt").splitLines

proc isNice1(str: string): bool =
    let has3Vowels = str.countIt(it in "aeoiu") >= 3
    var 
        has1Repeat: bool
        hasForbidden: bool
    for i in 0..str.high - 1:
        let pair = str[i..i + 1]
        if pair[0] == pair[1]:
            has1Repeat = true
        if pair in ["ab", "cd", "pq", "xy"]:
            hasForbidden = true
    has3Vowels and has1Repeat and not hasForbidden

let niceCount1 = lines.countIt(it.isNice1)
echo &"Number of nice strings: {niceCount1}"
    
# part 2
proc hasNonoverlappingPair(str: string): bool =
    for i in 0..str.high - 1:
        let pair1 = (str[i], str[i + 1])
        for j in i + 2..str.high - 1:
            let pair2 = (str[j], str[j + 1])
            if pair1 == pair2: return true
        
proc hasPairedTrio(str: string): bool =
    for i in 0..str.high - 2:
        if str[i] == str[i + 2]: return true
        
proc isNice2(str: string): bool =
    str.hasNonoverlappingPair and str.hasPairedTrio

let niceCount2 = lines.countIt(it.isNice2)
echo &"Number of nice strings: {niceCount2}"
