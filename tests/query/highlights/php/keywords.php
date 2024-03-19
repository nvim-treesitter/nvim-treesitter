<?php
//^^^ @punctuation.bracket

declare(strict_types=1);
//^^^^^ @keyword
//      ^^^^^^^^^^^^ @variable.parameter
//                  ^ @operator
//                   ^ @number
//                     ^ @punctuation.delimiter

include "file.php";
//^^^^^ @keyword.import
//      ^^^^^^^^^ @string
include_once "file.php";
//^^^^^^^^^^ @keyword.import
require "file.php";
//^^^^^ @keyword.import
require_once "file.php";
//^^^^^^^^^^ @keyword.import

namespace A\B;
//^^^^^^^ @keyword
//        ^^^ @module

if ($a and $b or $c xor $d) {} elseif ($b) {} else {}
// <- @keyword.conditional
//     ^^^ @keyword.operator
//            ^^ @keyword.operator
//                  ^^^ @keyword.operator
//                             ^^^^^^ @keyword.conditional
//                                            ^^^^ @keyword.conditional

for ($i = 0; $i < 1; $i++) { continue; }
// <- @keyword.repeat
//              ^ @operator
//                     ^^ @operator
//                           ^^^^^^^^ @keyword.repeat

while ($b) {}
//^^^ @keyword.repeat

do { } while ($c);
// <- @keyword.repeat
//     ^^^^^ @keyword.repeat

foreach ($foos as $foo) {}
//^^^^^ @keyword.repeat
//             ^^ @keyword.operator

try {} catch (Exception $e) {} finally {}
//^ @keyword.exception
//     ^^^^^ @keyword.exception
//            ^^^^^^^^^ @type
//                             ^^^^^^^ @keyword.exception

function a() {}
//^^^^^^ @keyword.function
//       ^ @function

abstract class A
//^^^^^^ @keyword.modifier
//       ^^^^^ @keyword
//             ^ @type
{
  private const BAR = 1;
//^^^^^^^ @keyword.modifier
//        ^^^^^ @keyword.modifier
  //            ^^^ @constant
  protected readonly static $a;
//^^^^^^^^^ @keyword.modifier
//          ^^^^^^^^ @keyword.modifier
//                   ^^^^^^ @keyword.modifier
  //                        ^^ @property
  final public $b;
//^^^^^ @keyword.modifier
  public static function foo(): static {}
//^^^^^^ @keyword.modifier
//       ^^^^^^ @keyword.modifier
//              ^^^^^^^^ @keyword.function
//                       ^^^ @function.method
//                              ^^^^^^ @type.builtin
  public function __construct() {}
//                ^^^^^^^^^^^ @constructor
}

class B extends A implements T
//    ^ @type
//      ^^^^^^^ @keyword
//              ^ @type
//                ^^^^^^^^^^ @keyword
//                           ^ @type
{
  use T, U {
//^^^ @keyword.import
//     ^ @punctuation.delimiter
    U::small insteadof T;
//  ^ @type
//   ^^ @operator
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
    $call instanceof Closure;
//  ^^^^^ @variable
//        ^^^^^^^^^^ @keyword.operator
//                   ^^^^^^^ @type
    fn ($a, $b) => $a + $b;
//  ^^ @keyword.function
    static $a;
//  ^^^^^^ @keyword.modifier
    global $a;
//  ^^^^^^ @keyword
    clone $call;
//  ^^^^^ @keyword
    match ($a) {
//  ^^^^^ @keyword.conditional
      default => "other",
//    ^^^^^^^ @keyword
//            ^^ @operator
    };

    switch ($a) {
//  ^^^^^^ @keyword.conditional
      case 'value':
//    ^^^^ @keyword.conditional
        break;
//      ^^^^^ @keyword
      default:
//    ^^^^^^^ @keyword
    }
    yield $a;
//  ^^^^^ @keyword.return
    yield from $a;
//        ^^^^ @keyword.return
    return $a;
//  ^^^^^^ @keyword.return
    goto a;
//  ^^^^ @keyword
    echo "a";
//  ^^^^ @keyword
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

throw new Exception("oh");
//^^^ @keyword.exception
//    ^^^ @keyword
//        ^^^^^^^^^ @constructor

interface T {}
//^^^^^^^ @keyword
//        ^ @type

trait T { public function small(): void {} }
//^^^ @keyword
//    ^ @type
//                                 ^^^^ @type.builtin
enum Foo { case Bar; }
//^^ @keyword
//         ^^^^  @keyword.conditional
