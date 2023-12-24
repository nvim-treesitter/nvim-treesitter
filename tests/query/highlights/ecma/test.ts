class H {
  pub_field = "Hello";
  //  ^ @property

  #priv_field = "World!";
  //   ^ @property

  #private_method() {
    //  ^ @function.method
    return `${this.pub_field} -- ${this.#priv_field}`;
    //                                      ^ @property
    //                ^ @property
  }

  public_method() {
    //  ^ @function.method
    return this.#private_method();
    //                ^ @function.method.call
  }

  ok() {
    return this.public_method();
    //                ^ @function.method.call
  }
}

function doSomething(options) {
  const {
    enable: on,
    //    ^ @punctuation.delimiter
  } = options
}
