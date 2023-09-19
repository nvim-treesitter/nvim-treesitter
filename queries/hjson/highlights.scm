(true) @boolean
(false) @boolean
(null) @constant.builtin
(number) @number
(pair key: (string) @label)
(pair value: (string) @string)
(array (string) @string)
;  (string_content (escape_sequence) @string.escape)
;  "," @punctuation.delimiter
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

(comment) @comment @spell

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
