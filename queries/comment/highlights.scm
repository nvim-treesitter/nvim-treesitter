(_) @spell

[
 "("
 ")"
] @punctuation.bracket

":" @punctuation.delimiter

(tag (name) @text.note (user)? @constant)

((tag ((name) @text.note))
 (#any-of? @text.note "NOTE"))

("text" @text.note
 (#any-of? @text.note "NOTE"))

((tag ((name) @text.todo))
 (#eq? @text.todo "TODO"))

("text" @text.todo 
 (#eq? @text.todo "TODO"))

((tag ((name) @text.warning))
 (#any-of? @text.warning "HACK" "WARNING"))

("text" @text.warning
 (#any-of? @text.warning "HACK" "WARNING"))

((tag ((name) @text.danger))
 (#any-of? @text.danger "FIXME" "XXX" "BUG"))

("text" @text.danger
 (#any-of? @text.danger "FIXME" "XXX" "BUG"))

; Issue number (#123)
("text" @number (#lua-match? @number "^#[0-9]+$"))
; User mention (@user)
("text" @constant (#lua-match? @constant "^[@][a-zA-Z0-9_-]+$"))
