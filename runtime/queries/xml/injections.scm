((Comment) @injection.content
  (#set! injection.language "comment"))

((element
  (STag
    (Name) @_name)
  (content) @injection.content)
  (#eq? @_name "style")
  (#set! injection.combined)
  (#set! injection.include-children)
  (#set! injection.language "css"))

((element
  (STag
    (Name) @_name)
  (content) @injection.content)
  (#eq? @_name "script")
  (#set! injection.combined)
  (#set! injection.include-children)
  (#set! injection.language "javascript"))

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
  (#eq? @_name "Implementation")
  (#set! injection.language "objectscript"))

(element
  (STag
    (Name) @_name)
  (content
    (CharData) @injection.content)
  (#eq? @_name "Implementation")
  (#set! injection.language "objectscript"))
