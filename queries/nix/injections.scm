((comment) @injection.content
  (#set! injection.language "comment"))

((comment) @injection.language
  . ; this is to make sure only adjacent comments are accounted for the injections
  [
    (string_expression
      (string_fragment) @injection.content)
    (indented_string_expression
      (string_fragment) @injection.content)
  ]
  (#gsub! @injection.language "/%*%s*([%w%p]+)%s*%*/" "%1")
  (#set! injection.combined))

(apply_expression
  function: (_) @_func
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "regex")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "regex")))
    ]
  (#match? @_func "(^|\\.)match$")
  (#set! injection.combined))

(binding
  attrpath:
    (attrpath
      (identifier) @_path)
  expression:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "bash")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "bash")))
    ]
  (#match? @_path "(^\\w+(Phase|Hook|Check)|(pre|post)[A-Z]\\w+|script)$"))

(apply_expression
  function: (_) @_func
  argument:
    (_
      (_)*
      (_
        (_)*
        (binding
          attrpath:
            (attrpath
              (identifier) @_path)
          expression:
            [
              (string_expression
                ((string_fragment) @injection.content
                  (#set! injection.language "bash")))
              (indented_string_expression
                ((string_fragment) @injection.content
                  (#set! injection.language "bash")))
            ])))
  (#match? @_func "(^|\\.)writeShellApplication$")
  (#match? @_path "^text$")
  (#set! injection.combined))

(apply_expression
  function:
    (apply_expression
      function:
        (apply_expression
          function: (_) @_func))
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "bash")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "bash")))
    ]
  (#match? @_func "(^|\\.)runCommand((No)?CC)?(Local)?$")
  (#set! injection.combined))

((apply_expression
  function:
    (apply_expression
      function: (_) @_func)
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "bash")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "bash")))
    ])
  (#match? @_func "(^|\\.)write(Bash|Dash|ShellScript)(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function:
    (apply_expression
      function: (_) @_func)
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "fish")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "fish")))
    ])
  (#match? @_func "(^|\\.)writeFish(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function:
    (apply_expression
      function:
        (apply_expression
          function: (_) @_func))
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "haskell")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "haskell")))
    ])
  (#match? @_func "(^|\\.)writeHaskell(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function:
    (apply_expression
      function:
        (apply_expression
          function: (_) @_func))
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "javascript")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "javascript")))
    ])
  (#match? @_func "(^|\\.)writeJS(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function:
    (apply_expression
      function:
        (apply_expression
          function: (_) @_func))
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "perl")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "perl")))
    ])
  (#match? @_func "(^|\\.)writePerl(Bin)?$")
  (#set! injection.combined))

((apply_expression
  function:
    (apply_expression
      function:
        (apply_expression
          function: (_) @_func))
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "python")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "python")))
    ])
  (#match? @_func "(^|\\.)write(PyPy|Python)[23](Bin)?$")
  (#set! injection.combined))

((apply_expression
  function:
    (apply_expression
      function:
        (apply_expression
          function: (_) @_func))
  argument:
    [
      (string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "rust")))
      (indented_string_expression
        ((string_fragment) @injection.content
          (#set! injection.language "rust")))
    ])
  (#match? @_func "(^|\\.)writeRust(Bin)?$")
  (#set! injection.combined))

; (nixosTest) testScript
((binding
  attrpath: (attrpath) @_attr_name
  (#eq? @_attr_name "nodes"))
  (binding
    attrpath: (attrpath) @_func_name
    (#eq? @_func_name "testScript")
    (_
      (string_fragment) @injection.content
      (#set! injection.language "python")))
  (#set! injection.combined))

; home-manager Neovim plugin config
(attrset_expression
  (binding_set
    (binding
      attrpath: (attrpath) @_ty_attr
      (_
        (string_fragment) @_ty)
      (#eq? @_ty_attr "type")
      (#eq? @_ty "lua"))
    (binding
      attrpath: (attrpath) @_cfg_attr
      (_
        (string_fragment) @injection.content
        (#set! injection.language "lua"))
      (#eq? @_cfg_attr "config")))
  (#set! injection.combined))
