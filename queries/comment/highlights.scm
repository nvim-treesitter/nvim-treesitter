((tag
  (name) @comment.todo @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.todo "TODO" "WIP"))

("text" @comment.todo @nospell
  (#any-of? @comment.todo "TODO" "WIP"))

((tag
  (name) @comment.info @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.info "XXX" "INFO" "DOCS" "PERF" "TEST"))

("text" @comment.info @nospell
  (#any-of? @comment.info "XXX" "INFO" "DOCS" "PERF" "TEST"))

((tag
  (name) @comment.hint @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.hint "NOTE"))

("text" @comment.hint @nospell
  (#any-of? @comment.hint "NOTE"))

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

((uri) @string.special.url @nospell)
