((comment) @injection.content
 (#set! injection.language "comment"))

(apply_expression
  function: (_) @_func
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "regex")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "regex")))
  ]
  (#match? @_func "(^|\\.)match$")
  (#set! injection.combined))

(binding
  attrpath: (attrpath (identifier) @_path)
  expression: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "bash")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "bash")))
  ]
  (#match? @_path "(^\\w+(Phase|Hook)|(pre|post)[A-Z]\\w+|script)$"))

(apply_expression
  function: (_) @_func
  argument: (_ (_)* (_ (_)* (binding
    attrpath: (attrpath (identifier) @_path)
    expression: [
      (string_expression 
        ((string_fragment) @injection.content (#set! injection.language "bash")))
      (indented_string_expression 
        ((string_fragment) @injection.content (#set! injection.language "bash")))
    ])))
  (#match? @_func "(^|\\.)writeShellApplication$")
  (#match? @_path "^text$")
  (#set! injection.combined))

(apply_expression
  function: (apply_expression
    function: (apply_expression function: (_) @_func))
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "bash")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "bash")))
  ]
  (#match? @_func "(^|\\.)runCommand((No)?CC)?(Local)?$")
  (#set! injection.combined))

((apply_expression
  function: (apply_expression function: (_) @_func)
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "bash")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "bash")))
  ])
  (#match? @_func "(^|\\.)write(Bash|Dash|ShellScript)(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function: (apply_expression function: (_) @_func)
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "fish")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "fish")))
  ])
  (#match? @_func "(^|\\.)writeFish(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression function: (_) @_func))
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "haskell")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "haskell")))
  ])
  (#match? @_func "(^|\\.)writeHaskell(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression function: (_) @_func))
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "javascript")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "javascript")))
  ])
  (#match? @_func "(^|\\.)writeJS(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression function: (_) @_func))
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "perl")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "perl")))
  ])
  (#match? @_func "(^|\\.)writePerl(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression function: (_) @_func))
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "python")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "python")))
  ])
  (#match? @_func "(^|\\.)write(PyPy|Python)[23](Bin)?$")
  (#set! injection.combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression function: (_) @_func))
  argument: [
    (string_expression 
      ((string_fragment) @injection.content (#set! injection.language "rust")))
    (indented_string_expression 
      ((string_fragment) @injection.content (#set! injection.language "rust")))
  ])
  (#match? @_func "(^|\\.)writeRust(Bin)?$")
  (#set! injection.combined))
