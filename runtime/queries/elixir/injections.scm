; Comments
((comment) @injection.content 
 (#set! injection.language "comment"))

; Documentation
(unary_operator
  operator: "@"
  operand: (call
    target: ((identifier) @_identifier (#any-of? @_identifier "moduledoc" "typedoc" "shortdoc" "doc"))
    (arguments [
      (string (quoted_content) @injection.content)
      (sigil (quoted_content) @injection.content)
    ]) 
    (#set! injection.language "markdown")))

; HEEx
(sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content
 (#eq? @_sigil_name "H")
 (#set! injection.language "heex"))

; Surface
(sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content
 (#eq? @_sigil_name "F")
 (#set! injection.language "surface"))

; Zigler
(sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content
 (#any-of? @_sigil_name "E" "L")
 (#set! injection.language "eex"))

(sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content
 (#any-of? @_sigil_name "z" "Z")
 (#set! injection.language "zig"))

; Regex
(sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content
 (#any-of? @_sigil_name "r" "R")
 (#set! injection.language "regex"))

; Json
(sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content
 (#any-of? @_sigil_name "j" "J")
 (#set! injection.language "json"))

