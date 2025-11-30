; highlights.scm - Syntax highlighting queries for TOON
; Maps grammar nodes to standard Neovim highlight capture groups
; Reference: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
; Literals
; --------
(null) @constant.builtin

(true) @boolean

(false) @boolean

(number) @number

(integer) @number

; Strings
(quoted_string) @string

(unquoted_string) @string

(escape_sequence) @string.escape

; Properties/Keys
; ---------------
; Object keys
(pair
  key: (key
    (identifier) @property))

(pair
  key: (key
    (dotted_key
      (identifier) @property)))

(pair
  key: (key
    (quoted_string) @property))

; Array declaration keys
(array_declaration
  key: (key
    (identifier) @property))

(array_declaration
  key: (key
    (dotted_key
      (identifier) @property)))

; Field names in tabular arrays
(field_name
  (identifier) @property)

(field_name
  (quoted_string) @property)

; List item keys (objects as list items)
(list_item
  key: (key
    (identifier) @property))

; Punctuation
; -----------
; Delimiters
":" @punctuation.delimiter

"," @punctuation.delimiter

"|" @punctuation.delimiter

"." @punctuation.delimiter

(delimiter) @punctuation.delimiter

(field_delimiter) @punctuation.delimiter

(delimiter_marker) @punctuation.delimiter

; Brackets
"[" @punctuation.bracket

"]" @punctuation.bracket

"{" @punctuation.bracket

"}" @punctuation.bracket

; Special
"\"" @punctuation.special

(list_marker) @punctuation.special
