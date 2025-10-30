shader_type spatial;

render_mode unshaded, wireframe;
// <- @keyword
//          ^^^^^^^^ @keyword
//                    ^^^^^^^^^ @keyword

/** My Doc comment*/
//^^^^^^^^^^^^^^^^^^ @comment.documentation
uniform float MY_VALUE: interesting_hint = 1.0;
//<- @keyword 
//      ^^^^^ type.builtin
//            ^^^^^^^^ constant
//                    ^ @punctuation.delimiter
//                      ^^^^^^^^^^^^^^^^ @attribute
//                                       ^ @operator
//                                         ^^^ @number.float
//                                            ^ punctuation.delimiter

void vertex() {
// <- type.builtin
//   ^^^^^^ @function
  do {} while (123< 2231);
//^^ keyword.repeat
//      ^^^^^ keyword.repeat
}
