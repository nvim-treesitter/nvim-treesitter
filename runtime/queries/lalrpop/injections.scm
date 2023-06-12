([
  (normal_action)
  (failible_action)
] @injection.content
  (#set! injection.language "rust"))

((use) @injection.content
  (#set! injection.language "rust"))

((regex_literal) @injection.content
  (#set! injection.language "regex")
  (#offset! @injection.content 0 2 0 -1))
