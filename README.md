# Keyboard Madness

A Nim implementation of a virtual keyboard where you can encode and decode text by moving through the keyboard layout.

## Installation

1. Clone the repository
2. Make sure you have [Nim](https://nim-lang.org/) installed

## Build

Run `nimble build` to compile and run the project.

## Usage

```bash
❯ ./keyboard_madness                                   
Usage:
    keyboard_madness decode <code>...
    keyboard_madness encode <text>...
    keyboard_madness (-h | --help)
    keyboard_madness --version
```

## Examples

```bash
❯ ./keyboard_madness decode R,S,U,L:3,S,D,R:6,S,S,U,S
HELLO
```

```bash
❯ ./keyboard_madness decode L:3,S,R:5,U:1,S,R:3,S,D:2,S
SUP?
```

```bash
❯ ./keyboard_madness encode "HTTP 404 Not Found"
R:1,S,L:1,U:1,S,S,R:5,S,_,L:6,U:1,S,R:6,S,L:6,S,_,R:2,D:3,S,R:3,U:2,S,L:4,S,_,L:1,D:1,S,R:5,U:1,S,L:2,S,L:1,D:2,S,L:3,U:1,S
```

## Running Tests

Run `nimble test` to run the test suite.