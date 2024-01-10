class H {
  pub_field = "Hello";
  //  ^ @variable.member

  #priv_field = "World!";
  //   ^ @variable.member

  #private_method() {
    //  ^ @function.method
    return `${this.pub_field} -- ${this.#priv_field}`;
    //                                      ^ @variable.member
    //                ^ @variable.member
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
