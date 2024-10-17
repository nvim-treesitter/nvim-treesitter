((comment) @injection.content
  (#set! injection.language "comment"))

; https://cylc.github.io/cylc-doc/latest/html/user-guide/task-implementation/job-scripts.html#jobscripts
((setting
  key: (key) @_key
  (#any-of? @_key
    "script" "init-script" "env-script" "pre-script" "post-script" "err-script" "exit-script")
  value: (_
    (string_content) @injection.content))
  (#set! injection.language "bash"))
