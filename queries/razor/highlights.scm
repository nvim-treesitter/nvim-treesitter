; inherits: c_sharp

[
  (razor_comment)
  (html_comment)
] @comment @spell

[
  "at_page"
  "at_using"
  "at_model"
  "at_rendermode"
  "at_inject"
  "at_implements"
  "at_layout"
  "at_inherits"
  "at_attribute"
  "at_typeparam"
  "at_namespace"
  "at_preservewhitespace"
  "at_block"
  "at_at_escape"
  "at_colon_transition"
] @constant.macro

[
  "at_lock"
  "at_section"
] @keyword

[
  "at_if"
  "at_switch"
] @keyword.conditional

[
  "at_for"
  "at_foreach"
  "at_while"
  "at_do"
] @keyword.repeat

[
  "at_try"
  "catch"
  "finally"
] @keyword.exception

[
  "at_implicit"
  "at_explicit"
] @variable

"at_await" @keyword.coroutine

(razor_rendermode) @property

(razor_attribute_name) @function
