import sequtils
import strutils
import docopt

const
    keys = @[
        "! 1 2 3 4 5 6 7 8 9",
        "Z X C V B N M , . ?",
        "A S D F G H J K L :",
        "Q W E R T Y U I O P"
    ].map(proc(x: string): seq[string] = x.split(" "))

type 
    Keyboard = ref object
        register: (int, int)
        keys: seq[seq[string]]
    Instructions = enum
        L, U, R, D, _, S

proc newKeyboard(register: (int, int)=(2, 4)): Keyboard =
    Keyboard(register: register, keys: keys)

proc getKeyAt(k: Keyboard): string =
    let (y, x) = k.register
    return k.keys[y][x]

proc decode(k: Keyboard, input: string): string =
    var output: seq[string] = @[]
    
    for i in input.split(","):
        let iSet = i.split(":")
        
        let instruction = parseEnum[Instructions](iSet[0])
        var count:int = 1
        if len(iSet) == 2:
            count = iSet[1].parseInt()
            
        let (y, x) = k.register
        case instruction:
            of Instructions.L:
                k.register = (y, x-count)
            of Instructions.R:
                k.register = (y, x+count)
            of Instructions.U:
                k.register = (y-count, x)
            of Instructions.D:
                k.register = (y+count, x)
            of Instructions._:
                output.add(" ")
            of Instructions.S:
                output.add(k.getKeyAt())
        
    return output.join("")


if isMainModule:
    let doc = """
    KeyboardMadness.
    
    Usage:
      keyboard_madness decode <code>...
      keyboard_madness (-h | --help)
      keyboard_madness --version
    
    Options:
      -h --help     Show this screen.
      --version     Show version.
    """
    let k = newKeyboard()
    let args = docopt(doc, version = "KeyboardMadness 0.1.0")
    if args["decode"]:
        echo k.decode(args["<code>"][0])
    
