class Box<T> {
  //      ^ @type
  //   ^ @type
  protected T $data;
  // ^ @type.qualifier
  //        ^ @type

  public function __construct(T $data) {
  //                          ^ @type
  //                             ^ @variable.parameter
  //        ^ @keyword.function
  // ^ @type.qualifier
  //                    ^ @function.method
    $this->data = $data;
  }

  public function getData(): T {
                // ^ @function.method
  // ^ @type.qualifier
    return $this->data;
              // ^ @operator
          // ^ @variable.builtin
  }
}
