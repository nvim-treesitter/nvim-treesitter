(_) @spell

((tag
  (name) @text.todo @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#set! "priority" 126)
  (#any-of? @text.todo "TODO" "WIP"))

("text" @text.todo @nospell
 (#set! "priority" 126)
 (#any-of? @text.todo "TODO" "WIP"))

((tag
  (name) @text.note @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#set! "priority" 126)
  (#any-of? @text.note "NOTE" "XXX" "INFO"))

("text" @text.note @nospell
 (#set! "priority" 126)
 (#any-of? @text.note "NOTE" "XXX" "INFO"))

((tag
  (name) @text.warning @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#set! "priority" 126)
  (#any-of? @text.warning "HACK" "WARNING" "WARN" "FIX"))

("text" @text.warning @nospell
 (#set! "priority" 126)
 (#any-of? @text.warning "HACK" "WARNING" "WARN" "FIX"))

((tag
  (name) @text.danger @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#set! "priority" 126)
  (#any-of? @text.danger "FIXME" "BUG" "ERROR"))

("text" @text.danger @nospell
 (#set! "priority" 126)
 (#any-of? @text.danger "FIXME" "BUG" "ERROR"))

; Issue number (#123)
("text" @number
 (#set! "priority" 126)
 (#lua-match? @number "^#[0-9]+$"))

((uri) @text.uri @nospell)

((user) @constant
 (#set! "priority" 126)
 )

("(" @punctuation.bracket
 (#set! "priority" 126)
 )

(")" @punctuation.bracket
 (#set! "priority" 126)
 )

(":" @punctuation.delimiter
 (#set! "priority" 126)
 )
