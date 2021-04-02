[
 "("
 ")"
] @punctuation.bracket

":" @punctuation.delimiter

(tag (name) @text.note (user)? @constant)

((tag ((name) @text.warning))
 (#match? @text.warning "^(TODO|HACK|WARNING)$"))

("text" @text.warning
 (#match? @text.warning "^(TODO|HACK|WARNING)$"))

((tag ((name) @text.danger))
 (#match? @text.danger "^(FIXME|XXX|BUG)$"))

("text" @text.danger
 (#match? @text.danger "^(FIXME|XXX|BUG)$"))

; Issue number (#123)
("text" @number (#match? @number "^#[0-9]+$"))
; User mention (@user)
("text" @constant (#match? @constant "^[@][a-zA-Z0-9_-]+$"))
