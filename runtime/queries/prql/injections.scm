((s_string) @injection.content
 (#set! injection.language "sql")
 (#offset! @injection.content 0 2 0 -1))

(from_text
  (keyword_from_text)
  (keyword_json)
  (literal) @injection.content
  (#set! injection.language "json")
  (#offset! @injection.content 0 3 0 -3))

((comment) @injection.content
 (#set! injection.language "comment"))
