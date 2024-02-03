; Identifiers
(identifier) @variable

(process) @variable.builtin

(parameters
  (identifier)) @variable.parameter

(global_metadata
  key: (identifier) @variable.member)

(function_metadata
  function_name: (identifier) @variable.member)

; Literals
(_
  filename: (string)) @string.special.path

(documentation) @string.documentation @spell

[
  (string)
  (fstring)
] @string

(int) @number

(real) @number.float

; Types
(_
  type:
    [
      (int_type)
      (float_type)
      (any_type)
    ]) @type.builtin

[
  (single_precision)
  (double_precision)
  (quad_precision)
  (fixed_point_precision)
] @attribute

; Functions
(function_definition
  name: (identifier) @function)

(function_names) @function

[
  (lambda)
  (prefix)
  (prim1)
  (prim2)
  (prim3)
  (prim4)
  (prim5)
  (function_call)
] @function.call

[
  "exp"
  "log"
  "log10"
  "sqrt"
  "abs"
  "floor"
  "ceil"
  "rint"
  "round"
  "acos"
  "asin"
  "atan"
  "cos"
  "sin"
  "tan"
  "atan2"
  "int"
  "float"
  "pow"
  "min"
  "max"
  "fmod"
  "remainder"
  "prefix"
  "attach"
  "enable"
  "control"
  "rdtable"
  "rwtable"
  "select2"
  "select3"
  "lowest"
  "highest"
  "assertbounds"
  (par)
  (seq)
  (sum)
  (prod)
  (component)
  (library)
  (vslider_type)
  (hslider_type)
  (nentry_type)
  (vbargraph_type)
  (hbargraph_type)
  (vgroup_type)
  (hgroup_type)
  (tgroup_type)
  "button"
  "checkbox"
  "soundfile"
  "inputs"
  "outputs"
  "route"
] @function.builtin

; xor is a @keyword.operator
[
  (add)
  (sub)
  (mult)
  (div)
  (mod)
  (pow)
  (or)
  (and)
  (lshift)
  (rshift)
  (lt)
  (le)
  (gt)
  (ge)
  (eq)
  (neq)
  (delay)
  (one_sample_delay)
  "="
  "=>"
  "->"
] @operator

(recursive
  "~" @operator)

(sequential
  ":" @operator)

(split
  "<:" @operator)

(merge
  ":>" @operator)

(parallel
  "," @operator)

; Keywords
[
  (par)
  (seq)
  (sum)
  (prod)
] @keyword.repeat

(file_import
  "import" @keyword.import)

[
  (wire)
  (cut)
  (mem)
  "declare"
  "with"
  "environment"
  "case"
  "ffunction"
  "fconstant"
  "fvariable"
] @keyword

(xor) @keyword.operator

; Punctuation
[
  ","
  ";"
  "."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; Comments
(comment) @comment @spell

; Tags
[
  "<mdoc>"
  "</mdoc>"
  "<metadata>"
  "</metadata>"
  "<equation>"
  "</equation>"
  "<diagram>"
  "</diagram>"
  "<listing"
  "<notice"
  "/>"
] @tag
