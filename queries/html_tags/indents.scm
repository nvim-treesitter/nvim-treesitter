[
  (
    (element
      (start_tag 
        (tag_name) @_not_special)
    )
    (#not-any-of? @_not_special "meta" "link")
  )
  (element (self_closing_tag))
] @indent

; These tags are usually written one-lined and doesnt use self-closing tags so special-cased them 
; but add indent to the tag to make sure attributes inside them are still indented if written multi-lined
(
  (start_tag 
     (tag_name) @_special)
  (#any-of? @_special "meta" "link")
) @indent


; These are the nodes that will be captured when we do `normal o`
; But last element has already been ended, so capturing this
; to mark end of last element
(element (end_tag [">"] @indent_end))
(element (self_closing_tag "/>" @indent_end))

; Script/style elements aren't indented, so only branch the end tag of other elements
(element (end_tag) @branch)
[
  ">"
  "/>"
] @branch

(comment) @ignore
