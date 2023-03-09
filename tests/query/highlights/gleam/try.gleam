pub fn main() {
  try x = Ok(1)
  // <- exception
  //  ^ variable
  //    ^ operator
  //      ^^ constant.builtin
  //        ^ punctuation.bracket
  //         ^ number
  //          ^ punctuation.bracket
  Ok(x + 1)
}
