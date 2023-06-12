(symbol) @variable

(label
  name: (symbol) @label)

[
  (instruction_mnemonic)
  (directive_mnemonic)
] @function.builtin

(include
  (directive_mnemonic) @keyword.import)

(include_bin
  (directive_mnemonic) @keyword.import)

(include_dir
  (directive_mnemonic) @keyword.import)

(size) @attribute

(macro_definition
  name: (symbol) @function.macro)

(macro_call
  name: (symbol) @function.macro)

(string_literal) @string

(path) @string.special.path

[
  (decimal_literal)
  (hexadecimal_literal)
  (octal_literal)
  (binary_literal)
] @number

[
  (reptn)
  (carg)
  (narg)
  (macro_arg)
] @variable.builtin

[
  (control_mnemonic)
  (address_register)
  (data_register)
  (float_register)
  (named_register)
] @keyword

(repeat
  (control_mnemonic) @keyword.repeat)

(conditional
  (control_mnemonic) @keyword.conditional)

(comment) @comment @spell

[
  (operator)
  "="
  "#"
] @operator

[
  "."
  ","
  "/"
  "-"
] @punctuation.delimiter

[
  "("
  ")"
  ")+"
] @punctuation.bracket

(section) @module
