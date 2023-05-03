;; Pass code blocks to Cpp highlighter
(code 
  (code_body) @injection.content 
  (#set! injection.language "cpp"))

;; Pass identifiers to Go highlighter (Cheating I know)
;; ((identifier) @injection.content
;;  (#set! injection.language "lua")

;; Highlight regex syntax inside literal strings
((string_literal) @injection.content 
 (#set! injection.language "regex"))

;; Highlight PyFoam syntax as Python statements
(pyfoam_variable
  code_body: (_) @injection.content
  (#set! injection.language "python"))
(pyfoam_expression
  code_body: (_) @injection.content
  (#set! injection.language "python"))
