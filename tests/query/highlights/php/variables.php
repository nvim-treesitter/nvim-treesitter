<?php

class A {
  public function foo(self $a): self {
//                          ^ @variable
    new self();
//      ^^^^ @constructor
    new static();
//      ^^^^^^ @constructor
    new parent();
//      ^^^^^^ @constructor
    $this->foo();
//   ^^^^ @variable.builtin
//         ^^^ @function.method.call
    self::foo();
//  ^^^^ @variable.builtin
//        ^^^ @function.call
    static::foo();
//  ^^^^^^ @variable.builtin
    parent::foo();
//  ^^^^^^ @variable.builtin
    $this->foo;
//         ^^^ @variable.member
    $this->foo(a: 5);
//             ^ @variable.parameter
  }
}
