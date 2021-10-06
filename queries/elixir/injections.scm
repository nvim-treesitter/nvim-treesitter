(sigil 
  (sigil_name) @_sigil_name 
  (quoted_content) @surface 
(#eq? @_sigil_name "F"))

(sigil 
  (sigil_name) @_sigil_name 
  (quoted_content) @heex 
(#eq? @_sigil_name "H"))

(sigil 
  (sigil_name) @_sigil_name 
  (quoted_content) @zig 
(#eq? @_sigil_name "Z"))

(sigil 
  (sigil_name) @_sigil_name 
  (quoted_content) @regex 
(#any-of? @_sigil_name "r" "R"))

(comment) @comment
