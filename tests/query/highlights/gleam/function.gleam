pub fn add(x: Int, y: Int) -> Int {
// <- @type.qualifier
//  ^^ @keyword.function
//     ^^^ @function
//        ^ @punctuation.bracket
//         ^ @variable.parameter
//          ^ @punctuation.delimiter
//            ^^^ @type.builtin
//               ^ @punctuation.delimiter
//                 ^ @variable.parameter
//                  ^ @punctuation.delimiter
//                    ^^^ @type.builtin
//                       ^ @punctuation.bracket
//                         ^ @punctuation.delimiter
//                            ^^^ @type.builtin
//                                ^ @punctuation.bracket
}
// <- @punctuation.bracket

pub fn twice(f: fn(t) -> t, x: t) -> t {
// <- @type.qualifier
//  ^ @keyword.function
//     ^^^^^ @function
//          ^ @punctuation.bracket
//           ^ @variable.parameter
//            ^ @punctuation.delimiter
//              ^^ @keyword.function
//                ^ @punctuation.bracket
//                 ^ @type
//                  ^ @punctuation.bracket
//                    ^^ @punctuation.delimiter
//                       ^ @type
//                        ^ @punctuation.delimiter
//                          ^ @variable.parameter
//                           ^ @punctuation.delimiter
//                             ^ @type
//                              ^ @punctuation.bracket
//                                ^^ @punctuation.delimiter
//                                   ^ @type
//                                     ^ @punctuation.bracket
}
// <- @punctuation.bracket

fn list_of_two(my_value: a) -> List(a) {
// <- @keyword.function
// ^ @function
//            ^ @punctuation.bracket
//             ^ @variable.parameter
//                     ^ @punctuation.delimiter
//                       ^ @type
//                        ^ @punctuation.bracket
//                          ^ @punctuation.delimiter
//                             ^^^^ @type.builtin
//                                 ^ @punctuation.bracket
//                                  ^ @type
//                                   ^ @punctuation.bracket
//                                     ^ @punctuation.bracket
}
// <- @punctuation.bracket

fn replace(
// <- @keyword.function
// ^^^^^^^ @function
//        ^ @punctuation.bracket
  in string: String,
  // <- @label
  // ^^^^^^ @variable.parameter
  //       ^ @punctuation.delimiter
  //         ^^^^^^ @type.builtin
  //               ^ @punctuation.delimiter
  each pattern: String,
  // <- @label
  //   ^^^^^^^ @variable.parameter
  //          ^ @punctuation.delimiter
  //            ^^^^^^ @type.builtin
  //                  ^ @punctuation.delimiter
  with replacement: String,
  // <- @label
  //   ^^^^^^^^^^^ @variable.parameter
  //              ^ @punctuation.delimiter
  //                ^^^^^^ @type.builtin
  //                      ^ @punctuation.delimiter
) {
  replace(in: "A,B,C", each: ",", with: " ")
  // <- @function.call
  //     ^ @punctuation.bracket
  //      ^^ @label
  //        ^ @punctuation.delimiter
  //          ^^^^^^^ @string
  //                 ^ @punctuation.delimiter
  //                   ^^^^ @label
  //                       ^ @punctuation.delimiter
  //                         ^^^ @string
  //                            ^ @punctuation.delimiter
  //                              ^^^^ @label
  //                                  ^ @punctuation.delimiter
  //                                    ^^^ @string
  //                                       ^ @punctuation.bracket
}
// <- @punctuation.bracket

pub external fn random_float() -> Float = "rand" "uniform"
// <- @type.qualifier
//  ^^^^^^^^ @type.qualifier
//           ^^ @keyword.function
//              ^^^^^^^^^^^^ @function
//                          ^ @punctuation.bracket
//                           ^ @punctuation.bracket
//                             ^^ @punctuation.delimiter
//                                ^^^^^ @type.builtin
//                                      ^ @operator
//                                        ^^^^^^ @module
//                                               ^^^^^^^^^ @function

pub external fn inspect(a) -> a = "Elixir.IO" "inspect"
// <- @type.qualifier
//  ^^^^^^^^ @type.qualifier
//           ^^ @keyword.function
//              ^^^^^^^ @function
//                     ^ @punctuation.bracket
//                      ^ @type
//                       ^ @punctuation.bracket
//                         ^^ @punctuation.delimiter
//                            ^ @type
//                              ^ @operator
//                                ^^^^^^^^^^^ @module
//                                            ^^^^^^^^^ @function
