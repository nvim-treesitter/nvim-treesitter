; Keywords
[
  "@module"
  "@package"
] @keyword.import @nospell

[
  "@class"
  "@type"
  "@param"
  "@alias"
  "@field"
  "@generic"
  "@vararg"
  "@diagnostic"
  "@cast"
  "@deprecated"
  "@meta"
  "@source"
  "@version"
  "@operator"
  "@nodiscard"
  "@cast"
  "@overload"
  "@enum"
  "@language"
  "@see"
  "@as"
  "extends"
  (diagnostic_identifier)
] @keyword @nospell

"@async" @keyword.coroutine @nospell

(language_injection
  "@language"
  (identifier) @keyword @nospell)

(function_type
  [
    "fun"
    "function"
  ] @keyword.function @nospell)

(source_annotation
  filename: (identifier) @string.special.path @nospell
  extension: (identifier) @string.special.path @nospell)

(version_annotation
  version: _ @constant.builtin @nospell)

"@return" @keyword.return @nospell

; Qualifiers
[
  "public"
  "protected"
  "private"
  "package"
  "@public"
  "@protected"
  "@private"
  "(exact)"
  "(key)"
] @keyword.modifier @nospell

; Variables
(identifier) @variable @nospell

[
  "..."
  "self"
] @variable.builtin @nospell

; Macros
(alias_annotation
  (identifier) @function.macro @nospell)

; Parameters
(param_annotation
  (identifier) @variable.parameter @nospell)

(parameter
  (identifier) @variable.parameter @nospell)

; Fields
(field_annotation
  (identifier) @variable.member @nospell)

(table_literal_type
  field: (identifier) @variable.member @nospell)

(member_type
  [
    "#"
    "."
  ]
  .
  (identifier) @variable.member @nospell)

(member_type
  (identifier) @module @nospell)

(member_type
  (identifier) @type @nospell .)

; Types
(table_type
  "table" @type.builtin @nospell)

(builtin_type) @type.builtin @nospell

(class_annotation
  (identifier) @type @nospell)

(enum_annotation
  (identifier) @type @nospell)

((array_type
  [
    "["
    "]"
  ] @type)
  (#set! priority 105))

(type) @type

; Operators
[
  "|"
  "+"
  "-"
] @operator

; Literals
[
  (string)
  (literal_type)
  "`"
] @string

(module_annotation
  (string) @module @nospell)

[
  (number)
  (numeric_literal_type)
] @number

; Punctuation
[
  "["
  "]"
  "[["
  "]]"
  "[=["
  "]=]"
] @punctuation.bracket

[
  "{"
  "}"
] @punctuation.bracket

[
  "("
  ")"
] @punctuation.bracket

[
  "<"
  ">"
] @punctuation.bracket

[
  ","
  "."
  "#"
  ":"
] @punctuation.delimiter

[
  "@"
  "?"
] @punctuation.special

; Comments
(comment) @comment @spell

(at_comment
  (identifier) @type @nospell
  (_) @comment @spell)

(class_at_comment
  (identifier) @type @nospell
  ("extends"?
    (identifier)? @type @nospell)
  (_) @comment @spell)
