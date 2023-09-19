(user) @namespace

(auth) @symbol

(gecos) @string

(home) @text.uri @constant

(shell) @text.uri @string.special

[
  (gid)
  (uid)
] @number

(separator) @punctuation.delimiter

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
