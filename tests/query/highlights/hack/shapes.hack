class C extends Superclass implements Iface {
//      ^ @keyword          ^ @keyword
  use Trait;
  // <- @keyword.import
  const type X = shape(
  // <- @keyword ^ @type.builtin
    "a" => int,
  // ^ @string
    "b" => string,
  //       ^ @type.builtin
  );
}
