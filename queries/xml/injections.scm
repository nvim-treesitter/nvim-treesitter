((Comment) @injection.content 
 (#set! injection.language "comment"))

; SVG style
((element
   (STag (Name) @_name)
   (content) @injection.content)
 (#eq? @_name "style")
 (#set! injection.combined)
 (#set! injection.include-children)
 (#set! injection.language "css"))

; SVG script
((element
   (STag (Name) @_name)
   (content) @injection.content)
 (#eq? @_name "script")
 (#set! injection.combined)
 (#set! injection.include-children)
 (#set! injection.language "javascript"))

; phpMyAdmin dump
((element
   (STag (Name) @_name)
   (content) @injection.content)
 (#eq? @_name "pma:table")
 (#set! injection.combined)
 (#set! injection.include-children)
 (#set! injection.language "sql"))
