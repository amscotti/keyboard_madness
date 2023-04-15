# Package

version       = "0.1.0"
author        = "Anthony Scotti"
description   = "Decodes keyboard maddness codes"
license       = "MIT"
srcDir        = "src"
bin           = @["keyboard_madness"]

# Dependencies

requires "nim >= 0.18.0"
requires "docopt"

task test, "Run the Nimble tester!":
  withDir "tests":
    exec "nim c -r keyboard_test"

    