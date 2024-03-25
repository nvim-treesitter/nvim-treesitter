([
  "{{"
  "}}"
  "{{-"
  "-}}"
  "{%"
  "%}"
  "{%-"
  "-%}"
] @tag.delimiter
  (#set! priority 101))

([
  "]"
  "["
  ")"
  "("
] @punctuation.bracket
  (#set! priority 101))

([
  ","
  "."
] @punctuation.delimiter
  (#set! priority 101))

([
  "as"
  "assign"
  "break"
  "by"
  "capture"
  "case"
  "continue"
  "cycle"
  "decrement"
  "echo"
  "else"
  "elsif"
  "endcapture"
  "endcase"
  "endfor"
  "endform"
  "endif"
  "endjavascript"
  "endpaginate"
  "endraw"
  "endschema"
  "endstyle"
  "endtablerow"
  "endunless"
  "for"
  "form"
  "if"
  "include"
  "increment"
  "javascript"
  "layout"
  "liquid"
  "paginate"
  "raw"
  "render"
  "schema"
  "section"
  "sections"
  "style"
  "tablerow"
  "unless"
  "when"
  "with"
] @keyword
  (#set! priority 101))

([
  "and"
  "contains"
  "in"
  "or"
] @keyword.operator
  (#set! priority 101))

([
  "|"
  ":"
  "="
  (predicate)
] @operator
  (#set! priority 101))

((identifier) @variable
  (#set! priority 101))

((string) @string
  (#set! priority 101))

((boolean) @boolean
  (#set! priority 101))

((number) @number
  (#set! priority 101))

(filter
  name: (identifier) @function.call
  (#set! priority 101))

(raw_statement
  (raw_content) @spell
  (#set! priority 102))

((comment) @comment
  (#set! priority 102))
