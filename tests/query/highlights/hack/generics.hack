class Box<T> {
  //      ^ @type
  //   ^ @type
  protected T $data;
  // ^ @keyword.modifier
  //        ^ @type

  public function __construct(T $data) {
  //                          ^ @type
  //                             ^ @variable.parameter
  //        ^ @keyword.function
  // ^ @keyword.modifier
  //                    ^ @function.method
    $this->data = $data;
  }

  public function getData(): T {
                // ^ @function.method
  // ^ @keyword.modifier
    return $this->data;
              // ^ @operator
          // ^ @variable.builtin
  }
}
