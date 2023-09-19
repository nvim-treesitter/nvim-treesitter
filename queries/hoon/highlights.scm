(number) @number

(string) @string

[
  "("
  ")"
  "["
  "]"
]  @punctuation.bracket

[
  (coreTerminator)
  (seriesTerminator)
] @punctuation.delimiter


(rune) @operator

(term) @constant

(aura) @constant.builtin

(Gap) @comment

(boolean) @constant.builtin

(date) @string.special

(mold) @symbol
(specialIndex) @number.builtin
(lark) @operator
(fullContext) @symbol

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
