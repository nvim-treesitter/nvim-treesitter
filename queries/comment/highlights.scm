(_) @spell

((tag
  (name) @text.todo
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#eq? @text.todo "TODO"))

("text" @text.todo
 (#eq? @text.todo "TODO"))

((tag
  (name) @text.note
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.note "NOTE" "XXX"))

("text" @text.note
 (#any-of? @text.note "NOTE" "XXX"))

((tag
  (name) @text.warning
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.warning "HACK" "WARNING"))

("text" @text.warning
 (#any-of? @text.warning "HACK" "WARNING"))

((tag
  (name) @text.danger
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.danger "FIXME" "BUG"))

("text" @text.danger
 (#any-of? @text.danger "FIXME" "BUG"))

; Issue number (#123)
("text" @number
 (#lua-match? @number "^#[0-9]+$"))

; User mention (@user)
("text" @constant
 (#lua-match? @constant "^[@][a-zA-Z0-9_-]+$"))
