; Scopes
(call (do_block)) @scope
(stab_clause) @scope

; References
(identifier) @reference
(alias) @reference

; Module Definitions
(call
  target: ((identifier) @_identifier (#eq? @_identifier "defmodule"))
  (arguments (alias) @definition.type))

; Local Function Definitions
; TODO: add support for test blocks
; test "foo", %{conn: conn} do
(call
  target: ((identifier) @_identifier (#any-of? @_identifier "def" "defp" "defmacro" "defmacrop" "defguard" "defguardp" "defn" "defnp" "for"))
  (arguments [
    (identifier) @definition.function
    (binary_operator left: (identifier) @definition.function)
    (call target: (identifier) @definition.function (arguments [
      (identifier) @definition.parameter
      (_ (identifier) @definition.parameter)
      (_ (_ (identifier) @definition.parameter))
      (_ (_ (_ (identifier) @definition.parameter)))
      (_ (_ (_ (_ (identifier) @definition.parameter))))
      (_ (_ (_ (_ (_ (identifier) @definition.parameter)))))
      (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter))))))
      (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter)))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter)))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter)))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter)))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter)))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter))))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter)))))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter))))))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter)))))))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.parameter))))))))))))))))))))
    ]))
  ]?) (#set! definition.function.scope parent))

; Pattern Match Definitions
(binary_operator left: [
  (identifier) @definition.var
  (_ (identifier) @definition.var)
  (_ (_ (identifier) @definition.var))
  (_ (_ (_ (identifier) @definition.var)))
  (_ (_ (_ (_ (identifier) @definition.var))))
  (_ (_ (_ (_ (_ (identifier) @definition.var)))))
  (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))
  (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))))))))))
] operator: "=")

; Stab Clause Definitions
(stab_clause left: [
  (_ (identifier) @definition.var)
  (_ (_ (identifier) @definition.var))
  (_ (_ (_ (identifier) @definition.var)))
  (_ (_ (_ (_ (identifier) @definition.var))))
  (_ (_ (_ (_ (_ (identifier) @definition.var)))))
  (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))
  (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var)))))))))))))))))))
  (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @definition.var))))))))))))))))))))
])

; Aliases
(call
  target: ((identifier) @_identifier (#any-of? @_identifier "require" "alias" "use" "import"))
  (arguments [
    (alias) @definition.import
    (_ (alias) @definition.import)
    (_ (_ (alias) @definition.import))
    (_ (_ (_ (alias) @definition.import)))
    (_ (_ (_ (_ (alias) @definition.import))))
  ]
))
