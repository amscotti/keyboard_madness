import unittest
import "../src/keyboard"

suite "Keyboard decode":

  setup:
    var k = newKeyboard()

  test "Select the starting point's key":
    check k.decode("S") == "G"

  test "Select the first letter to the left of the starting point":
    check k.decode("L,S") == "F"

  test "Select the third letter to the left of the starting point":
    check k.decode("L:3,S") == "S"

  test "Select the first letter to the right of the starting point":
    check k.decode("R,S") == "H"

  test "Select the third letter to the right of the starting point":
    check k.decode("R:3,S") == "K"

  test "Select the letter above the starting point":
    check k.decode("U,S") == "T"

  test "Select the letter below the starting point":
    check k.decode("D,S") == "B"

  test "Add a space into the selected keys":
    check k.decode("S,_,S") == "G G"

  test "Ignore any unknown instructions":
    check k.decode("S,Testing,Testing,Testing,S") == "GG"

suite "Keyboard encode":

  setup:
    var k = newKeyboard()

  test "Select the starting point's key":
    check k.encode("G") == "S"

  test "Select the first letter to the left of the starting point":
    check k.encode("F") == "L:1,S"

  test "Select the third letter to the left of the starting point":
    check k.encode("S") == "L:3,S"

  test "Select the first letter to the right of the starting point":
    check k.encode("H") == "R:1,S"

  test "Select the third letter to the right of the starting point":
    check k.encode("K") == "R:3,S"

  test "Select the letter above the starting point":
    check k.encode("T") == "U:1,S"

  test "Select the letter below the starting point":
    check k.encode("B") == "D:1,S"

  test "Add a space into the selected keys":
    check k.encode("G G") == "S,_,S"

  test "Encode complex string":
    check k.encode("HELLO") == "R:1,S,L:3,U:1,S,R:6,D:1,S,S,U:1,S"

  test "Encode and decode to get the original string":
    let text = "THIS IS A TEST"
    let encoded = k.encode(text)
    
    var kb = newKeyboard()
    check kb.decode(encoded) == text
