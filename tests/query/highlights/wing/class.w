bring cloud;
// <- keyword

class Foo {
// <- keyword
//    ^   variable
//        ^ punctuation.bracket
  name: str;
//^    field
//      ^   type.builtin
//         ^ punctuation.delimiter
  new(name:  str) {
//^    keyword
//    ^    variable
    this.name = name;
//      ^ punctuation.delimiter
//            ^ operator
  }
}
