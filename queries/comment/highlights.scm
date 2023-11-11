((tag
  (name) @comment.todo @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.todo "TODO" "WIP" "FIXME"))

("text" @comment.todo @nospell
  (#any-of? @comment.todo "TODO" "WIP" "FIXME"))

((tag
  (name) @comment.note @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.note "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST"))

("text" @comment.note @nospell
  (#any-of? @comment.note "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST"))

((tag
  (name) @comment.warning @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.warning "HACK" "WARNING" "WARN" "FIX"))

("text" @comment.warning @nospell
  (#any-of? @comment.warning "HACK" "WARNING" "WARN" "FIX"))

((tag
  (name) @comment.error @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.error "FIXME" "BUG" "ERROR"))

("text" @comment.error @nospell
  (#any-of? @comment.error "FIXME" "BUG" "ERROR"))

; Issue number (#123)
("text" @number
  (#lua-match? @number "^#[0-9]+$"))

(uri) @string.special.url @nospell
