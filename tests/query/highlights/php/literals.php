<?php

echo <<<OMG
//   ^^^ @operator
//      ^^^ @label
              something
OMG;
//^ @label

echo true, TRUE, false, FALSE;
//   ^^^^ @boolean
//         ^^^^ @boolean
//               ^^^^^ @boolean
//                      ^^^^^ @boolean

echo PI_314;
//   ^^^^^^ @constant

echo __DIR__;
//   ^^^^^^^ @constant.builtin

echo null, 42, 42.524, "Testing\n";
//   ^^^^ @constant.builtin
//         ^^ @number
//             ^^^^^^ @number.float
//                             ^^ @string.escape
