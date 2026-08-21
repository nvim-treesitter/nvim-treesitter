[
  (comment)
  (generated_comment)
] @comment

(comment_content) @spell

(subject) @markup.heading

(type) @keyword

(scope) @variable.parameter

(change_id) @constant

(filepath) @string.special.path

((rest) @comment
  (#not-lua-match? @comment "^diff"))

"JJ: ignore-rest" @keyword.directive

[
  "("
  ")"
] @punctuation.bracket

":" @punctuation.delimiter

"!" @punctuation.special

[
  "A"
  "C"
] @diff.plus

"D" @diff.minus

[
  "M"
  "R"
] @diff.delta
