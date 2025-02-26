<?php

namespace Foo\Bar;
//        ^^^ @module
//            ^^^ @module

use Baz as Baaz;
//  ^^^ @type
//         ^^^^ @type
use Foo\Baz as Baaz;
//  ^^^ @module
//      ^^^ @type
//             ^^^^ @type

use Foo\{Bar, Baz as Baaz};
//       ^^^ @type
//            ^^^ @type
//                   ^^^^ @type

use function foo as fooo;
//           ^^^ @function
//                  ^^^^ @function
//
use function Foo\foo as fooo;
//           ^^^ @module
//               ^^^ @function
//                      ^^^^ @function
use function Foo\{bar, foo as fooo};
//                ^^^ @function
//                     ^^^ @function
//                            ^^^^ @function
use const FOO as FOOO;
//        ^^^ @constant
//               ^^^^ @constant
use const Foo\FOO as FOOO;
//        ^^^ @module
//            ^^^ @constant
//                   ^^^^ @constant
use const Foo\{FOO as FOOO, BAR};
//             ^^^ @constant
//                    ^^^^ @constant
//                          ^^^ @constant

use Foo\Baz\{
//  ^^^ @module
//      ^^^ @module
  Bar as Barr,
//^^^ @type
//       ^^^^ @type
  Foo\Bar as Barr,
//^^^ @module
//    ^^^ @type
//           ^^^^ @type
  function foo as fooo,
//         ^^^ @function
//                ^^^^ @function
  function Foo\foo as fooo,
//         ^^^ @module
//             ^^^ @function
//                    ^^^^ @function
  const FOO as FOOO,
//      ^^^ @constant
//             ^^^^ @constant
  const Foo\FOO as FOOO,
//      ^^^ @module
//          ^^^ @constant
//                 ^^^^ @constant
};

class Foo {
    public function foo() {
        Bar::foo();
//      ^^^ @type
//           ^^^ @function.call
        \Bar::foo();
//       ^^^ @type
//            ^^^ @function.call
        Foo\Bar::foo();
//      ^^^ @module
//          ^^^ @type
//               ^^^ @function.call
        \Foo\Bar::foo();
//       ^^^ @module
//           ^^^ @type
//                ^^^ @function.call
        namespace\Bar::foo();
//      ^^^^^^^^^ @module.builtin
//                ^^^ @type
//                     ^^^ @function.call
        namespace\Foo\Bar::foo();
//      ^^^^^^^^^ @module.builtin
//                ^^^ @module
//                    ^^^ @type
//                         ^^^ @function.call
        new Bar();
//          ^^^ @constructor
        new \Bar();
//           ^^^ @constructor
        new Foo\Bar();
//          ^^^ @module
//              ^^^ @constructor
        new \Foo\Bar();
//           ^^^ @module
//               ^^^ @constructor
        new namespace\Bar();
//          ^^^^^^^^^ @module.builtin
//                    ^^^ @constructor
        new namespace\Foo\Bar();
//          ^^^^^^^^^ @module.builtin
//                    ^^^ @module
//                        ^^^ @constructor
        BAZ;
//      ^^^ @constant
        \BAZ;
//       ^^^ @constant
        Foo\BAZ;
//      ^^^ @module
//          ^^^ @constant
        \Foo\BAZ;
//       ^^^ @module
//           ^^^ @constant
        namespace\BAZ;
//      ^^^^^^^^^ @module.builtin
//                ^^^ @constant
        namespace\Foo\BAZ;
//      ^^^^^^^^^ @module.builtin
//                ^^^ @module
//                    ^^^ @constant
        foo();
//      ^^^ @function.call
        \foo();
//       ^^^ @function.call
        Foo\foo();
//      ^^^ @module
//          ^^^ @function.call
        \Foo\foo();
//       ^^^ @module
//           ^^^ @function.call
        namespace\foo();
//      ^^^^^^^^^ @module.builtin
//                ^^^ @function.call
        namespace\Foo\foo();
//      ^^^^^^^^^ @module.builtin
//                ^^^ @module
//                    ^^^ @function.call
  }
}
