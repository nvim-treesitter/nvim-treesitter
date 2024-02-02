; Identifiers
(identifier) @variable

(process) @variable.builtin

(parameters
  (identifier)) @variable.parameter

; Literals
(_
  filename: (string)) @string.special.path

(function_names) @string.special

(documentation) @string.documentation

[
  (string)
  (fstring)
] @string

(real) @number.float

[
  (int)
  (real)
] @number

; Types
(global_metadata
  key: (identifier)) @property

(function_metadata
  key: (identifier)) @property

(_
  type:
    [
      (int)
      (float)
      (any)
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
  (exp)
  (log)
  (log10)
  (sqrt)
  (abs)
  (floor)
  (ceil)
  (rint)
  (round)
  (acos)
  (asin)
  (atan)
  (cos)
  (sin)
  (tan)
  (atan2)
  (int_cast)
  (float_cast)
  (pow_fun)
  (min)
  (max)
  (fmod)
  (remainder)
  (prefix_prim)
  (attach)
  (enable)
  (control)
  (rdtable)
  (rwtable)
  (select2)
  (select3)
  (component)
  (library)
  (lowest)
  (highest)
  (assertbounds)
  (par)
  (seq)
  (sum)
  (prod)
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

[
  (recursive
    "~")
  (sequential
    ":")
  (split
    "<:")
  (merge
    ":>")
  (parallel
    ",")
] @operator

; Keywords
[
  (par)
  (seq)
  (sum)
  (prod)
] @keyword.repeat

(file_import
  "import") @keyword.import

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
(comment) @comment

[
  (doc_metadata)
  (doc_equation)
  (doc_diagram)
  (doc_listing)
  (doc_notice)
] @tag

(doc_attribute) @tag.attribute
