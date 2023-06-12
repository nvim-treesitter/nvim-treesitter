; Properties
;-----------
(bare_key) @type

(quoted_key) @string

(pair
  (bare_key)) @property

(pair
  (dotted_key
    (bare_key) @property))

; Literals
;---------
(boolean) @boolean

(comment) @comment @spell

(string) @string

(escape_sequence) @string.escape

(integer) @number

(float) @number.float

(offset_date_time) @string.special

(local_date_time) @string.special

(local_date) @string.special

(local_time) @string.special

; Punctuation
;------------
"." @punctuation.delimiter

"," @punctuation.delimiter

"=" @operator

"[" @punctuation.bracket

"]" @punctuation.bracket

"[[" @punctuation.bracket

"]]" @punctuation.bracket

"{" @punctuation.bracket

"}" @punctuation.bracket
