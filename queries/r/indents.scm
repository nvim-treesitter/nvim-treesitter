[
 "{" "(" "[" "[["
 "|>" "if" "else" "while" "repeat" "for"
] @indent

[
 "}" ")" "]" "]]"
] @branch

((argument (identifier)) @aligned_indent
 (#set! "delimiter" "()"))

((parameter (identifier)) @aligned_indent
 (#set! "delimiter" "()"))

[
 "}" ")" "]" "]]"
] @indent_end

[
 (comment)
] @ignore
