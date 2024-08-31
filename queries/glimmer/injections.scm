; comments
((comment_statement) @injection.content
  (#set! injection.language "comment"))

; <style> tags
((element_node
  (element_node_start
    (tag_name) @_tag_name
    (#eq? @_tag_name "style"))) @injection.content
  (#offset! @injection.content 0 7 0 -8)
  (#set! injection.language "css")
  (#set! injection.include-children))

; <script> tags
((element_node
  (element_node_start
    (tag_name) @_tag_name
    (#eq? @_tag_name "script"))) @injection.content
  (#offset! @injection.content 0 8 0 -9)
  (#set! injection.language "glimmer_javascript")
  (#set! injection.include-children))
