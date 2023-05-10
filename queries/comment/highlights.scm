(_) @spell

((tag
  (name) @text.todo @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#eq? @text.todo "TODO"))

("text" @text.todo @nospell
 (#eq? @text.todo "TODO"))

((tag
  (name) @text.note @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.note "NOTE" "XXX"))

("text" @text.note @nospell
 (#any-of? @text.note "NOTE" "XXX"))

((tag
  (name) @text.warning @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.warning "HACK" "WARNING"))

("text" @text.warning @nospell
 (#any-of? @text.warning "HACK" "WARNING"))

((tag
  (name) @text.danger @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @text.danger "FIXME" "BUG"))

("text" @text.danger @nospell
 (#any-of? @text.danger "FIXME" "BUG"))

; Issue number (#123)
("text" @number
 (#lua-match? @number "^#[0-9]+$"))
