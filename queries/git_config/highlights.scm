; Sections
(section_name) @type

((section_name) @keyword.import
  (#eq? @keyword.import "include"))

((section_header
  (section_name) @keyword.import
  (subsection_name))
  (#eq? @keyword.import "includeIf"))

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

((string) @string.special.path
  (#lua-match? @string.special.path "^[.]?[/]"))

((string) @string.special.path
  (#lua-match? @string.special.path "^[~]"))

(section_header
  [
    "\""
    (subsection_name)
  ] @string.special)

; Punctuation
[
  "["
  "]"
] @punctuation.bracket

; Comments
(comment) @comment @spell
