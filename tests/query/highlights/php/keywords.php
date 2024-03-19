<?php

abstract class A
{
  protected readonly static $a;
//^^^^^^^^^ @keyword.modifier
//          ^^^^^^^^ @keyword.modifier
//                   ^^^^^^ @keyword.modifier
  public static function foo(): static {}
//^^^^^^ @keyword.modifier
//       ^^^^^^ @keyword.modifier
//              ^^^^^^^^ @keyword.function
//                       ^^^ @function.method
//                              ^^^^^^ @type.builtin
}

class B extends A implements T
//    ^ @type
//      ^^^^^^^ @keyword
//                ^^^^^^^^^^ @keyword
{
  use T, U {
//^^^ @keyword.import
    U::small insteadof T;
//  ^ @type
//     ^^^^^ @function.method
//           ^^^^^^^^^ @keyword
//                     ^ @type
    T::big as protected tBig;
//  ^ @type
//     ^^^ @function.method
//         ^^ @keyword.operator
//            ^^^^^^^^^ @keyword.modifier
//                      ^^^^ @function.method
    big as private tBig;
//  ^^^ @function.method
//      ^^ @keyword.operator
//         ^^^^^^^^^ @keyword.modifier
//                 ^^^^ @function.method
  }
  public function foo(callable $call): self
//                    ^^^^^^^^ @type.builtin
//                                     ^^^^ @type.builtin
  {
    static $a;
//  ^^^^^^ @keyword.modifier
    yield $a;
//  ^^^^^ @keyword.return
    yield from $a;
//        ^^^^ @keyword.return
    print "a";
//  ^^^^^ @keyword
    print("a");
//  ^^^^^ @keyword
    exit;
//  ^^^^ @keyword.return
    exit();
//  ^^^^ @function.builtin
    exit(1);
//  ^^^^ @function.builtin
  }
}
