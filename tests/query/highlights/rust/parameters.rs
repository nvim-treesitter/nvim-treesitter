pub fn func(ref root: &mut Element, ref mut param2: u32) {
    //      ^^^ @keyword.modifier
    //          ^^^^ @variable.parameter
    //                              ^^^ @keyword.modifier
    //                                  ^^^ @keyword.modifier
    //                                      ^^^^^^ @variable.parameter
    return;
}
