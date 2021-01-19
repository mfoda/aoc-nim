import strformat, strutils, strscans, sequtils

type 
    Password = object
        text: string
        policy: Policy
    Policy = object
        reqLetter: char
        n1: int
        n2: int

proc parsePassword(str: string): Password =
    var
        reqLetter: string
        n1: int
        n2: int
        text: string
    if str.scanf("$i-$i $w: $w", n1, n2, reqLetter, text):
        return Password(
            text: text,
            policy: Policy(
                reqLetter: reqLetter[0],
                n1: n1,
                n2: n2
            )
        )

proc isValidPassword1(p: Password): bool =
    let requiredLetterCount = p.text.count(p.policy.reqLetter)
    requiredLetterCount >= p.policy.n1 and requiredLetterCount <= p.policy.n2

proc isValidPassword2(p: Password): bool =
    let 
        fst = p.text[p.policy.n1 - 1] == p.policy.reqLetter
        snd = p.text[p.policy.n2 - 1] == p.policy.reqLetter
    fst xor snd

let 
    passwords = readFile("2020/D02.txt").splitLines.map(parsePassword)
    valid1 = passwords.filter(isValidPassword1)
    valid2 = passwords.filter(isValidPassword2)

echo &"Number of valid passwords: {valid1.len}"
echo &"Number of valid passwords: {valid2.len}"