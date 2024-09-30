pub type Cat {
// <- @keyword.modifier
//  ^^^^ @keyword.type
//       ^^^ @type
//           ^ @punctuation.bracket
  Cat(name: String, cuteness: Int)
  // <- @constructor
  // ^ @punctuation.bracket
  //  ^^^^ @variable.member
  //      ^ @punctuation.delimiter
  //        ^^^^^^ @type
  //              ^ @punctuation.delimiter
  //                ^^^^^^^^ @variable.member
  //                        ^ @punctuation.delimiter
  //                          ^^^ @type
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
// <- @keyword.type
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
// <- @keyword.modifier
//  ^^^^^^ @keyword.modifier
//         ^^^^ @keyword.type
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
