var x = null;
// <- keyword
//      ^ keyword

// int literal.
var x = 12;
// <- keyword
//      ^ number

// int hex literal.
var x = 0xFF42;
// <- keyword
//      ^ number

// float literal.
var x = 4.2;
// <- keyword
//      ^ number

// float literal with no trailing number.
var x = 4.;
// <- keyword
//      ^ number

// float literal e notation.
var x = 4.3e5;
// <- keyword
//      ^ number

// string literal single quote
var x = 'hello';
// <- keyword
//      ^ string

// string literal double quote
var x = "hello";
// <- keyword
//      ^ string

// string literal single quote interpolated identifier
// var y = 1;
var x = 'hello $y';
// <- keyword
//      ^ string
//             ^ punctuation.special
//              ^ variable

// string literal single quote interpolated identifier in braces
var y = 1;
var x = 'hello ${y}';
// <- keyword
//      ^ string
//             ^ punctuation.special
//               ^ variable
//                ^ punctuation.special

// string literal single quote interpolated expression in braces
var y = 1;
var x = 'hello ${y + 1}';
// <- keyword
//      ^ string
//             ^ punctuation.special
//               ^ variable
//                   ^ number
//                    ^ punctuation.special

var x = [1, 2, 3, 4, 5];

var x = [
	1, 2, 3, 4,
	5, 6, 7, 8
];
