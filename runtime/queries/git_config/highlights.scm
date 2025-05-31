; Sections
(section_name) @markup.heading

((section_name) @keyword.import
  (#eq? @keyword.import "include"))

((section_header
  (section_name) @keyword.import
  (subsection_name))
  (#any-of? @keyword.import "includeIf" "includeif"))

(variable
  (name) @property)

; Operators
"=" @operator

; Literals
(integer) @number

[
  (true)
  (false)
] @boolean

(string) @string

(escape_sequence) @string.escape

((string) @string.special.path
  (#lua-match? @string.special.path "^[.]?[.]?[/]"))

((string) @string.special.path
  (#lua-match? @string.special.path "^[~]"))

(section_header
  [
    "\""
    (subsection_name)
  ] @string.special)

((section_header
  (section_name) @_name
  (subsection_name) @string.special.url)
  (#any-of? @_name "credential" "url"))

((variable
  (name) @_name
  value: (string) @string.special.url)
  (#any-of? @_name "insteadOf" "insteadof"))

; Punctuation
[
  "["
  "]"
] @punctuation.bracket

; Comments
(comment) @comment @spell
