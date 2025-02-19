((comment) @injection.content
  (#set! injection.language "comment"))

((label_name)
  [
    "=~"
    "!~"
  ]
  (label_value) @injection.content
  (#set! injection.language "regex")
  (#offset! @injection.content 0 1 0 -1))
