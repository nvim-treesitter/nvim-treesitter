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
  (#set! priority 110))

([
  "]"
  "["
  ")"
  "("
] @punctuation.bracket
  (#set! priority 110))

([
  ","
  "."
] @punctuation.delimiter
  (#set! priority 110))

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
  (#set! priority 110))

([
  "and"
  "contains"
  "in"
  "or"
] @keyword.operator
  (#set! priority 110))

([
  "|"
  ":"
  "="
  (predicate)
] @operator
  (#set! priority 110))

((identifier) @variable
  (#set! priority 110))

((string) @string
  (#set! priority 110))

((boolean) @boolean
  (#set! priority 110))

((number) @number
  (#set! priority 110))

(filter
  name: (identifier) @function.call
  (#set! priority 110))

(raw_statement
  (raw_content) @spell
  (#set! priority 111))

((comment) @comment @spell
  (#set! priority 111))
