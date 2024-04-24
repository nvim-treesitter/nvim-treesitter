[
  "="
  "+"
  "-"
  "*"
  "/"
  "%"
  "+="
  "-="
  "*="
  "/="
  "%="
  "=="
  "!="
  "<"
  ">"
  "<="
  ">="
  ".."
  "..="
] @operator

[
  "and"
  "not"
  "or"
] @keyword.operator

[
  "return"
  "yield"
] @keyword.return

[
  "if"
  "then"
  "else"
  "else if"
  "match"
  "switch"
] @keyword.conditional

[
  (break)
  (continue)
  "for"
  "in"
  "loop"
  "until"
  "while"
] @keyword.repeat

[
  "throw"
  "try"
  "catch"
  "finally"
] @keyword.exception

[
  "export"
  "from"
  "import"
  "as"
] @keyword.import

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "|"
] @punctuation.bracket

(identifier) @variable

(import_module
  (identifier) @namespace)

(import_item
  (identifier) @namespace)

(export
  (identifier) @namespace)

(chain
  lookup: (identifier) @field)

(chain
  start: (identifier) @function)

[
  (true)
  (false)
] @boolean

(comment) @comment @spell

(debug) @keyword.debug

(string) @string

(fill_char) @string

(alignment) @operator

(escape) @string.escape

(null) @constant.builtin

(number) @number

(meta) @tag

(meta
  name: (identifier) @field)

(self) @variable.builtin

(arg
  (identifier) @parameter)

(ellipsis) @parameter

(entry_inline
  key: (identifier) @field)

(entry_block
  key: (identifier) @field)
