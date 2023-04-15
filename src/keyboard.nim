import strutils, std/tables

const keys = [
    ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ';'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M', ',', '.', '?'],
  ]

proc createPositions(): Table[char, tuple[y, x: int]] =
  result = initTable[char, tuple[y, x: int]]()
  for y in 0..<keys.len:
    for x in 0..<keys[y].len:
      result[keys[y][x]] = (y: y, x: x)

const positions = createPositions()

type
  Keyboard* = ref object
    register: tuple[y, x: int]
    keys: array[4, array[10, char]]
  Instruction = enum
    L, U, R, D, _, S, N

proc newKeyboard*(register: tuple[y, x: int] = (2, 4)): Keyboard =
  Keyboard(register: register, keys: keys)

proc getKeyAt(k: Keyboard): char =
  k.keys[k.register.y][k.register.x]

proc decode*(k: Keyboard, input: string): string =
  result = newStringOfCap(input.len)

  for i in input.split(","):
    let iSet = i.split(":")

    let instruction: Instruction =
      try:
        parseEnum[Instruction](iSet[0])
      except ValueError:
        continue

    var count = 1
    if iSet.len == 2:
      count = iSet[1].parseInt()

    case instruction:
      of Instruction.L:
        k.register.x -= count
      of Instruction.R:
        k.register.x += count
      of Instruction.U:
        k.register.y -= count
      of Instruction.D:
        k.register.y += count
      of Instruction._:
        result.add(" ")
      of Instruction.S:
        result.add(k.getKeyAt())
      of Instruction.N:
        result.add("\n")

proc encode*(k: Keyboard, text: string): string =
  var encodingInstructions = newSeq[string]()

  for ch in text.toUpper():
    case ch:
      of ' ':
        encodingInstructions.add("_")
      of '\n':
        encodingInstructions.add("N")
      else:
        if ch in positions:
          let newPos = positions[ch]
          if newPos.x < k.register.x:
            encodingInstructions.add("L:" & $(k.register.x - newPos.x))
          elif newPos.x > k.register.x:
            encodingInstructions.add("R:" & $(newPos.x - k.register.x))

          if newPos.y < k.register.y:
            encodingInstructions.add("U:" & $(k.register.y - newPos.y))
          elif newPos.y > k.register.y:
            encodingInstructions.add("D:" & $(newPos.y - k.register.y))

          k.register.x = newPos.x
          k.register.y = newPos.y
          encodingInstructions.add("S")

  encodingInstructions.join(",")
