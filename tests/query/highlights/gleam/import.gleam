import gleam/io
// <- @keyword.import
//     ^ @module
//          ^ @operator
//           ^ @module

import cat as kitten
// <- @keyword.import
//     ^ @module
//         ^ @keyword
//            ^ @module

import animal/cat.{Cat, stroke}
// <- @keyword.import
//     ^ @module
//           ^ @operator
//               ^ @punctuation.delimiter
//                ^ @punctuation.bracket
//                 ^^^ @type
//                    ^ @punctuation.delimiter
//                      ^^^^^^ @function
//                            ^ @punctuation.bracket
