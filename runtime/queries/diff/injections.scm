((comment) @injection.content
  (#set! injection.language "comment"))

(block
  (new_file (filename) @injection.filename)
  (hunks
    (hunk changes: (changes) @injection.content
        (#set! injection.include-children))))
