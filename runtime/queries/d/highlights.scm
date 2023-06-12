; Keywords
[
  (directive)
  (shebang)
] @keyword.directive

[
  (import)
  (module)
] @keyword.import

[
  (alias)
  (asm)
  (class)
  (delegate)
  (delete)
  (enum)
  (interface)
  (invariant)
  (mixin)
  (pragma)
  (struct)
  (template)
  (union)
  (unittest)
  (version)
  (with)
  (traits)
  (vector)
  (parameters_)
  (default)
  (goto)
] @keyword

(function) @keyword.function

(synchronized) @keyword.coroutine

[
  (if)
  (else)
  (switch)
  (case)
  (break)
] @keyword.conditional

[
  (do)
  (for)
  (foreach)
  (foreach_reverse)
  (while)
  (continue)
] @keyword.repeat

(return) @keyword.return

[
  (abstract)
  (deprecated)
  (private)
  (protected)
  (public)
  (package)
  (immutable)
  (final)
  (const)
  (override)
  (static)
] @type.qualifier

[
  (assert)
  (try)
  (catch)
  (finally)
  (throw)
  (nothrow)
] @keyword.exception

[
  (cast)
  (new)
  (in)
  (is)
  (not_in)
  (not_is)
  (typeid)
  (typeof)
] @keyword.operator

[
  (lazy)
  (align)
  (extern)
  (scope)
  (ref)
  (pure)
  (export)
  (shared)
  (gshared)
  (out)
  (inout)
] @keyword.storage

(parameter_attribute
  (return) @keyword.storage)

(parameter_attribute
  (in) @keyword.storage)

(parameter_attribute
  (out) @keyword.storage)

(debug) @keyword.debug

; Operators
[
  "/="
  "/"
  ".."
  "&"
  "&="
  "&&"
  "|"
  "|="
  "||"
  "-"
  "-="
  "--"
  "+"
  "+="
  "++"
  "<"
  "<="
  "<<"
  "<<="
  ">"
  ">="
  ">>="
  ">>>="
  ">>"
  ">>>"
  "!"
  "!="
  "$"
  "="
  "=="
  "*"
  "*="
  "%"
  "%="
  "^"
  "^="
  "^^"
  "^^="
  "~"
  "~="
  "@"
] @operator

; Variables
(identifier) @variable

[
  "exit"
  "success"
  "failure"
  (this)
  (super)
] @variable.builtin

(linkage_attribute
  "("
  _ @variable.builtin
  ")")

; Modules
(module_fqn
  (identifier) @module)

; Attributes
(at_attribute
  (identifier) @attribute)

; Constants
(enum_member
  (identifier) @constant)

(manifest_declarator
  .
  (identifier) @constant)

; Members
(aggregate_body
  (variable_declaration
    (declarator
      (identifier) @variable.member)))

(property_expression
  "."
  (identifier) @variable.member)

(type
  "."
  (identifier) @variable.member)

; Types
(class_declaration
  (class)
  .
  (identifier) @type)

(struct_declaration
  (struct)
  .
  (identifier) @type)

(union_declaration
  (union)
  .
  (identifier) @type)

(enum_declaration
  (enum)
  .
  (identifier) @type)

(alias_declaration
  (alias)
  .
  (identifier) @type)

((identifier) @type
  (#lua-match? @type "^[A-Z].*"))

(type
  .
  (identifier) @type .)

[
  (auto)
  (void)
  (bool)
  (byte)
  (ubyte)
  (char)
  (short)
  (ushort)
  (wchar)
  (dchar)
  (int)
  (uint)
  (long)
  (ulong)
  (real)
  (double)
  (float)
  (cent)
  (ucent)
  (ireal)
  (idouble)
  (ifloat)
  (creal)
  (double)
  (cfloat)
] @type.builtin

; Functions
(function_declaration
  (identifier) @function)

(call_expression
  (identifier) @function)

(call_expression
  (type
    (identifier) @function .))

(call_expression
  (property_expression
    (call_expression)
    (identifier) @function .))

; Parameters
(parameter
  (_)
  (identifier) @variable.parameter)

(function_literal
  "("
  (type
    (identifier) @variable.parameter))

; Constructors
(constructor
  (this) @constructor)

(destructor
  (this) @constructor)

(postblit
  .
  (this) @constructor)

; Punctuation
[
  ";"
  "."
  ":"
  ","
  "=>"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

"..." @punctuation.special

; Ternaries
(ternary_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

; Labels
(label
  (identifier) @label)

(goto_statement
  (identifier) @label)

; Literals
(string_literal) @string

[
  (int_literal)
  (float_literal)
] @number

(char_literal) @character

[
  (true)
  (false)
] @boolean

[
  (null)
  (special_keyword)
] @constant.builtin

; Comments
(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^///[^/]"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^///$"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[+][+][^+].*[+]/$"))
