bring cloud;
// <- @keyword.import
//    ^ @module

class Foo {
// <- @keyword.type
//    ^   @type
//        ^ @punctuation.bracket
  name: str;
//^    @property
//      ^   @type.builtin
//         ^ @punctuation.delimiter
  new(name:  str) {
//^    @keyword
//    ^    @variable
    this.name = name;
//      ^ @punctuation.delimiter
//       ^ @variable.member
//            ^ @operator
  }
}
