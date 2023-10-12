{
  func1 = param: builtins.readFile param;
  # ^ @function
        # ^ @parameter
                # ^ @constant.builtin
                         # ^ @function.builtin
  func2 = { p1, p2 }: p2;
  # ^ @function
          # ^ @parameter
  readFile' = readFile;
              # ^ @function.builtin
  x = func1 ./path/to/file.nix;
# ^ @field
      # ^ @function.call
              # ^ @string.special
}
