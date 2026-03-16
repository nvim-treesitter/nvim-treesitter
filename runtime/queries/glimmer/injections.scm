; comments
((comment_statement) @injection.content
  (#set! injection.language "comment"))

; <style> tags
((style_element
  (raw_text) @injection.content)
  (#set! injection.language "css"))

; <script> tags
((script_element
  (raw_text) @injection.content)
  (#set! injection.language "javascript")
  (#set! injection.include-children))
