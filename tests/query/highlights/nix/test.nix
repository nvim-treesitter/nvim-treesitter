{
  func1 = param: builtins.readFile param;
  # ^ @function
        # ^ @variable.parameter
                # ^ @constant.builtin
                         # ^ @function.builtin
  func2 = { p1, p2 }: p2;
  # ^ @function
          # ^ @variable.parameter
  readFile' = readFile;
              # ^ @function.builtin
  x = func1 ./path/to/file.nix;
# ^ @variable.member
      # ^ @function.call
              # ^ @string.special.path
  hi = if true then 9 else throw "an error ${here + "string"}";
                           # ^ @keyword.exception
                                  # ^ @string
                                             # ^ @variable
                                                     # ^ @string
}
