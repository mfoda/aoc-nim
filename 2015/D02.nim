import strutils, sequtils, algorithm, strformat

let input = readFile("2015/D02.txt")

type Dimensions = tuple
    length: int
    width: int
    height: int

var dimensions: seq[Dimensions]

for line in splitLines(input):
    let parts = line.split('x')
    dimensions.add (length: parts[0].parseInt,
                    width: parts[1].parseInt, 
                    height: parts[2].parseInt)

# part 1
proc calcWrappingPaper(d: Dimensions): int =
    let sides = sorted([d.length, d.width, d.height])
    let smallestSide = sides[0] * sides[1]
    let surfaceArea = 2 * (d.length * d.width + d.width * d.height + d.height * d.length)
    result = surfaceArea + smallestSide

var wrappingPaper = dimensions.map(calcWrappingPaper).foldl(a + b)
echo &"Total square feet of wrapping paper to order: {wrappingPaper}"

# part 2
proc calcRibbon(d: Dimensions): int =
    # cubic ft of volume for bow
    let sides = [d.length, d.width, d.height].sorted
    let volume = sides.foldl(a * b)
    let smallestPerimeter = 2 * sides[0] + 2 * sides[1]
    result = volume + smallestPerimeter

var ribbon = dimensions.map(calcRibbon).foldl(a + b)
echo &"Total feet of ribbon to order: {ribbon}"