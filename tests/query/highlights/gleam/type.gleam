pub type Cat {
// <- @type.qualifier
//  ^^^^ @keyword
//       ^^^ @type
//           ^ @punctuation.bracket
  Cat(name: String, cuteness: Int)
  // <- @constructor
  // ^ @punctuation.bracket
  //  ^^^^ @variable.member
  //      ^ @punctuation.delimiter
  //        ^^^^^^ @type.builtin
  //              ^ @punctuation.delimiter
  //                ^^^^^^^^ @variable.member
  //                        ^ @punctuation.delimiter
  //                          ^^^ @type.builtin
  //                             ^ @punctuation.bracket
}

fn cats() {
  Cat(name: "Nubi", cuteness: 2001)
  // <- @type
  // ^ @punctuation.bracket
  //  ^^^^ @variable.member
  //      ^ @punctuation.delimiter
  //        ^^^^^^ @string
  //              ^ @punctuation.delimiter
  //                ^^^^^^^^ @variable.member
  //                        ^ @punctuation.delimiter
  //                          ^^^^ @number
  //                              ^ @punctuation.bracket
  Cat("Ginny", 1950)
  // <- @constructor
  // ^ @punctuation.bracket
  //  ^^^^^^^ @string
  //         ^ @punctuation.delimiter
  //           ^^^^ @number
  //               ^ @punctuation.bracket
}

type Box(inner_type) {
// <- @keyword
//   ^^^ @type
//      ^ @punctuation.bracket
//       ^^^^^^^^^^ @type
//                 ^ @punctuation.bracket
//                   ^ @punctuation.bracket
  Box(inner: inner_type)
  // <- @constructor
  // ^ @punctuation.bracket
  //  ^^^^^ @variable.member
  //       ^ @punctuation.delimiter
  //         ^^^^^^^^^^ @type
  //                   ^ @punctuation.bracket
}

pub opaque type Counter {
// <- @type.qualifier
//  ^^^^^^ @type.qualifier
//         ^^^^ @keyword
//              ^^^^^^^ @type
//                      ^ @punctuation.bracket
  Counter(value: Int)
}

pub fn have_birthday(person) {
  Person(..person, age: person.age + 1, is_happy: True)
  // <- @constructor
  //    ^ @punctuation.bracket
  //     ^^ @operator
  //       ^^^^^^ @variable
  //             ^ @punctuation.delimiter
  //               ^^^ @variable.member
  //                  ^ @punctuation.delimiter
  //                    ^^^^^^ @variable
  //                          ^ @punctuation.delimiter
  //                           ^^^ @variable.member
  //                               ^ @operator
  //                                 ^ @number
  //                                  ^ @punctuation.delimiter
  //                                    ^^^^^^^^ @variable.member
  //                                            ^ @punctuation.delimiter
  //                                              ^^^^ @boolean
  //                                                  ^ @punctuation.bracket
}
