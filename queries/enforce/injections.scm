([
  (comment_block)
  (comment_line)
  ] @injection.content
 (#set! injection.language "comment"))

([
  (doc_block)
  (doc_line)
  ] @injection.content
 (#set! injection.language "doxygen"))

; TODO: can't use printf language, we need numbered format
; (invokation
;   (member_access
;     accessed: ((type_primitive) @_accessed (#eq? @_accessed "string"))
;   	member: (identifier) @_method
;   	)
;   (actual_parameters
;   	(actual_parameter
;   	  (literal_string) @injection.content
;   	  )
;   	(actual_parameter)*
;   	)
;   (#eq? @_method "Format")
;   (#set! injection.language "printf")
;   )
