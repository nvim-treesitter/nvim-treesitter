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
}
