((comment) @comment @spell
  (#set! priority 110))

(raw_statement
  (raw_content) @spell
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

([
  "as"
  "assign"
  "capture"
  "decrement"
  "echo"
  "endcapture"
  "endform"
  "endjavascript"
  "endraw"
  "endschema"
  "endstyle"
  "form"
  "increment"
  "javascript"
  "layout"
  "liquid"
  "raw"
  "schema"
  "style"
  "with"
] @keyword
  (#set! priority 110))

([
  "case"
  "else"
  "elsif"
  "endcase"
  "endif"
  "endunless"
  "if"
  "unless"
  "when"
] @keyword.conditional
  (#set! priority 110))

([
  "break"
  "by"
  "continue"
  "cycle"
  "endfor"
  "endpaginate"
  "endtablerow"
  "for"
  "paginate"
  "tablerow"
] @keyword.repeat
  (#set! priority 110))

([
  "and"
  "contains"
  "in"
  "or"
] @keyword.operator
  (#set! priority 110))

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

[
  "include"
  "render"
  "section"
  "sections"
] @keyword.import

[
  "|"
  ":"
  "="
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "=="
  "<"
  "<="
  "!="
  ">="
  ">"
] @operator

[
  "]"
  "["
  ")"
  "("
] @punctuation.bracket

[
  ","
  "."
] @punctuation.delimiter
