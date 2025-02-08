; inherits: jinja_inline

[
  "{{"
  "{{-"
  "{{+"
  "+}}"
  "-}}"
  "}}"
  "{%"
  "{%-"
  "{%+"
  "+%}"
  "-%}"
  "%}"
] @keyword.directive

; TODO: only match raw
(raw_start) @keyword
