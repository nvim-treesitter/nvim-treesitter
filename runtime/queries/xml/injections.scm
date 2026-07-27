((Comment) @injection.content
  (#set! injection.language "comment"))

; SVG style
((element
  (STag
    (Name) @_name)
  (content) @injection.content)
  (#eq? @_name "style")
  (#set! injection.combined)
  (#set! injection.include-children)
  (#set! injection.language "css"))

; SVG script
((element
  (STag
    (Name) @_name)
  (content) @injection.content)
  (#eq? @_name "script")
  (#set! injection.combined)
  (#set! injection.include-children)
  (#set! injection.language "javascript"))

; phpMyAdmin dump
((element
  (STag
    (Name) @_name)
  (content) @injection.content)
  (#eq? @_name "pma:table")
  (#set! injection.combined)
  (#set! injection.include-children)
  (#set! injection.language "sql"))

(element
  (STag
    (Name) @_name)
  (content
    (CDSect
      (CData) @injection.content))
  (ETag
    (Name) @_end_tag)
  (#eq? @_name "Implementation")
  (#eq? @_end_tag "Implementation")
  (#set! injection.language "objectscript"))

(element
  (STag
    (Name) @_name)
  (content
    (CharData) @injection.content)
  (ETag
    (Name) @_end_tag)
  (#eq? @_name "Implementation")
  (#eq? @_end_tag "Implementation")
  (#set! injection.language "objectscript"))
