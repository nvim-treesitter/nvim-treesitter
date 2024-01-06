[
  "killed"
  "by"
  "exited"
  "with"
  "<unfinished ...>"
  "<..."
  "resumed>"
] @keyword

[
  (errorName)
  (errorDescription)
] @keyword.exception

(syscall) @function.builtin

; Literals
(integer) @number

(pointer) @number.special

(value) @label

(string) @string

[
  "="
  "|"
  "*"
  "&&"
  "=="
] @operator

; Punctuation
[
  "+++"
  "---"
  "..."
  "~"
] @punctuation.special

[
  "("
  ")"
  "["
  "]"
] @punctuation.bracket

[
  ","
  "=>"
] @punctuation.delimiter

(comment) @comment @spell
