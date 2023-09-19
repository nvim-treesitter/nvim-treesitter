[
 (true)
 (false)
] @boolean

(null) @constant.builtin

(number) @number

(pair key: (string) @label)
(pair value: (string) @string)

(array (string) @string)

["," ":"] @punctuation.delimiter

[
 "[" "]"
 "{" "}"
] @punctuation.bracket

(("\"" @conceal)
 (#set! conceal ""))

(escape_sequence) @string.escape
((escape_sequence) @conceal
 (#eq? @conceal "\\\"")
 (#set! conceal "\""))

(ERROR _ @error)  ; up the specificity to nodes under error, instead of parent node
