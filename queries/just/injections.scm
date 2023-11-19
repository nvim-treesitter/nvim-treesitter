
; If no shell is explicitly set, let's default to bash for recipe bodies
(source_file 
  (item (recipe (body (recipe_body) @injection.content
    (#set! injection.include-children)
    (#set! injection.language "bash"))))) 

; Sets the injection language of a recipe to the executable of the shebang line
;
; This works well in most cases, since it's probably "bash" or "python", but
; will break in cases where the executable doesn't match the language name,
; such as "python3"
;
(shebang_recipe
  (shebang interpreter: (TEXT) @injection.language)
  (shebang_body) @injection.content
  (#set! injection.include-children))

; If a shell is set (set shell := ["zsh"]) then use that
;(source_file 
;  (item (setting lang: (NAME) @injection.language))
;  (item (recipe (body (recipe_body) @injection.content
;    (#set! injection.include-children))))) 
;
; This works if the shell is set to something that matches a language name,
; like "bash", "zsh", "python" etc. However, since it can be set to any
; executable, including a full path, this can easily break. This needs some
; kind of post processing to be usable.
