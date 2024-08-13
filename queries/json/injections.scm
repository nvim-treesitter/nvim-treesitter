; scripts field in package.json
((object
  (pair
    key: (string
      (string_content) @_key)
    value: (object
      (pair
        value: (string
          (string_content) @injection.content)))))
  (#eq? @_key "scripts")
  (#set! injection.language "bash"))
