((comment) @injection.content
  (#set! injection.language "comment"))

((match
  key: "PROGRAM"
  (value
    (content) @injection.content))
  (#set! injection.language "bash"))

((assignment
  key: "RUN"
  (value
    (content) @injection.content))
  (#set! injection.language "bash"))
