
; If no shell is explicitly set, let's default to bash for recipe bodies
(source_file 
  (item (recipe (body (recipe_body) @injection.content))) 
  (#set! injection.include-children)
  (#set! injection.language "bash"))

; If a default shell is explicitly set, use the executable name for normal recipes
(source_file 
  (item (setting lang: (NAME) @_lang))
  (item (recipe (body (recipe_body) @injection.content))) 
  (#eq? @_lang "python3")
  (#set! injection.language "python")
  (#set! injection.include-children))
(source_file 
  (item (setting lang: (NAME) @injection.language))
  (item (recipe (body (recipe_body) @injection.content))) 
  (#set! injection.include-children))

; For shebang recipes, use the shebang executable name as the language
(shebang_recipe
  (shebang interpreter: (TEXT) @_lang)
  (shebang_body) @injection.content
  (#eq? @_lang "python3")
  (#set! injection.language "python")
  (#set! injection.include-children))
(shebang_recipe
  (shebang interpreter: (TEXT) @injection.language)
  (shebang_body) @injection.content
  (#set! injection.include-children))
