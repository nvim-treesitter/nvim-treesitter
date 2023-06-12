((comment) @injection.content
  (#set! injection.language "comment"))

; The right side of =~ literals
(regex_literal
  (_) @injection.content
  (#set! injection.language "regex"))

; Default to bash highlighting for non-shebang recipes and commands
(recipe
  (recipe_body
    !shebang) @injection.content
  (#set! injection.include-children)
  (#set! injection.language "bash"))

(external_command
  (command_body) @injection.content
  (#set! injection.language "bash"))

; For shebang recipes, use the shebang executable name as the language by default
(recipe
  (recipe_body
    (shebang
      (language) @injection.language)) @injection.content
  (#not-any-of? @injection.language "python3" "nodejs" "node")
  (#set! injection.include-children))

; python3 -> python
(recipe
  (recipe_body
    (shebang
      (language) @_lang)) @injection.content
  (#eq? @_lang "python3")
  (#set! injection.language "python")
  (#set! injection.include-children))

; node/nodejs -> javascript
(recipe
  (recipe_body
    (shebang
      (language) @_lang)) @injection.content
  (#any-of? @_lang "node" "nodejs")
  (#set! injection.language "javascript")
  (#set! injection.include-children))
