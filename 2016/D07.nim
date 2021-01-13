import strformat,strutils, nre, sequtils

type IP = string

let ips = readFile("2016/D07.txt").splitLines

# part 1 
proc hasABBA(str: string): bool =
    for i in 0..str.high - 3:
        let
            pair1 = $(str[i + 0] & str[i + 1])
            pair2 = $(str[i + 3] & str[i + 2])
            unique = str[i] != str[i + 1]
        if unique and pair1 == pair2:
            return true

proc getSupernets(ip: IP): seq[string] =
    ip.split(re"\[\w+\]") 

proc getHypernets(ip: IP): seq[string] =
    for match in ip.findIter(re"\[(\w+)\]"):
        result.add(match.captures[0])

proc supportsTLS(ip: IP): bool =
    let 
        supernets = ip.getSupernets
        hypernets = ip.getHypernets
    supernets.any(hasABBA) and not hypernets.any(hasABBA)

echo &"Number of IPs supporting TLS: {ips.filter(supportsTLS).len}"

# part 2
proc findABA(str: string): seq[string] =
    for i in 0..str.high - 2:
        let isABA = str[i] == str[i + 2] and str[i] != str[i + 1]
        if isABA: result.add(str[i..i+2])

proc hasBAB(str: string, patt: string): bool =
    for i in 0..str.high - 2:
        # aba
        # bab
        let isBAB = 
            str[i] == patt[1]     and 
            str[i + 1] == patt[0] and 
            str[i + 2] == patt[1] and
            str[i] != str[i + 1]
        if isBAB: return true

proc supportsSSL(ip: IP): bool =
    let 
        supernets = ip.getSupernets
        hypernets = ip.getHypernets
        abas = supernets.map(findABA).concat.filterIt(not it.isEmptyOrWhitespace)
    for aba in abas:
        if hypernets.anyIt(hasBAB(it, aba)): return true

echo &"Number of IPs supporting SSL: {ips.filter(supportsSSL).len}"