import docopt
from keyboard import Keyboard, newKeyboard, decode, encode

if isMainModule:
  let doc = """
  KeyboardMadness.
  
  Usage:
    keyboard_madness decode <code>...
    keyboard_madness encode <text>...
    keyboard_madness (-h | --help)
    keyboard_madness --version
  
  Options:
    -h --help     Show this screen.
    --version     Show version.
  """
  let k: Keyboard = newKeyboard()
  let args = docopt(doc, version = "KeyboardMadness 0.2.0")
  if args["decode"]:
    echo k.decode(args["<code>"][0])
  elif args["encode"]:
    echo k.encode(args["<text>"][0])
