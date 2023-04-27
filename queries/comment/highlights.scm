(_) @spell

((tag
  (name) @nospell @text.todo
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#eq? @text.todo "TODO"))

("text" @nospell @text.todo
 (#eq? @text.todo "TODO"))

((tag
  (name) @nospell @text.note
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.note "NOTE" "XXX"))

("text" @nospell @text.note
 (#any-of? @text.note "NOTE" "XXX"))

((tag
  (name) @nospell @text.warning
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.warning "HACK" "WARNING"))

("text" @nospell @text.warning
 (#any-of? @text.warning "HACK" "WARNING"))

((tag
  (name) @nospell @text.danger
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.danger "FIXME" "BUG"))

("text" @nospell @text.danger
 (#any-of? @text.danger "FIXME" "BUG"))

; Issue number (#123)
("text" @number
 (#lua-match? @number "^#[0-9]+$"))

; User mention (@user)
("text" @nospell @constant 
 (#lua-match? @constant "^[@][a-zA-Z0-9_-]+$")
 (#set! "priority" 95))
