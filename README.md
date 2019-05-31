# Varg

Varg is a functional - objective language, syntactically similar to Haskell and Java.

## Installation and running

Varg is shipped as a `stack` package. To install `Varg` interpreter to local bin folder, use `stack install`. 
If you prefer Cabal, `make` builds Varg executable directly in the current directory.

Varg executed with no arguments, runs `Main.vg` by default. The source code should contain at least a 
definition of class `Main`, with a function `main`, taking one argument of type `List String` and 
returning `Void`. To ensure that all necessary classes are loaded properly, it is encouraged to load
`Std.Overture` module first. The minimal example program looks as follows:

```
import "Std.Overture"

class Main where
  static function main (args : List String) : Void = 0
```
(Because `Void` is a superclass to all objects, `main` function can in that way return anything.
Interpreter prints the result of calling `toString` method on that value).

To run another source file, one should supply its path without extension (like `Varg good/2`).
The standard library `Std` should be put in the current catalogue. 

### Runtime options

Option `-v, --verbose` enables interpreter logs.
Option `-s, --strict` disables lazy evaluation.
Option `-m, --memory` shows total memory usage after execution.
Option `-t, --trace` enables step-by-step evaluation.

## Examples

All the correct and incorrect examples are contained in folders `good` and `bad`, respectively.
