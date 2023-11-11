; References
(identifier) @local.reference

(alias) @local.reference

; Module Definitions
(call
  target:
    ((identifier) @_identifier
      (#eq? @_identifier "defmodule"))
  (arguments
    (alias) @local.definition.type))

; Pattern Match Definitions
(binary_operator
  ; format-ignore
  left: 
    [
      (identifier) @local.definition.var
      (_ (identifier) @local.definition.var)
      (_ (_ (identifier) @local.definition.var))
      (_ (_ (_ (identifier) @local.definition.var)))
      (_ (_ (_ (_ (identifier) @local.definition.var))))
      (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))
      (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))
      (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))))))
    ]
  operator: "=")

; Stab Clause Definitions
; format-ignore
(stab_clause
  left:
    [
     (arguments
      [
        (identifier) @local.definition.var
        (_ (identifier) @local.definition.var)
        (_ (_ (identifier) @local.definition.var))
        (_ (_ (_ (identifier) @local.definition.var)))
        (_ (_ (_ (_ (identifier) @local.definition.var))))
        (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))
        (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))
        (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))))))
      ])

    (binary_operator
      left:
        (arguments
          ; format-ignore
          [
            (identifier) @local.definition.var
            (_ (identifier) @local.definition.var)
            (_ (_ (identifier) @local.definition.var))
            (_ (_ (_ (identifier) @local.definition.var)))
            (_ (_ (_ (_ (identifier) @local.definition.var))))
            (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))
            (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))
            (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var)))))))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.var))))))))))))))))))))
          ])
      operator: "when")
    ])

; Aliases
; format-ignore
(call
  target:
    ((identifier) @_identifier
      (#any-of? @_identifier "require" "alias" "use" "import"))
  (arguments
    [
      (alias) @local.definition.import
      (_ (alias) @local.definition.import)
      (_ (_ (alias) @local.definition.import))
      (_ (_ (_ (alias) @local.definition.import)))
      (_ (_ (_ (_ (alias) @local.definition.import))))
    ]))

; Local Function Definitions & Scopes
; format-ignore
(call
  target:
    ((identifier) @_identifier
      (#any-of? @_identifier "def" "defp" "defmacro" "defmacrop" "defguard" "defguardp" "defn" "defnp" "for"))
  (arguments
    [
      (identifier) @local.definition.function
      (binary_operator
        left: (identifier) @local.definition.function
        operator: "when")
      (binary_operator
        (identifier) @local.definition.parameter)
      (call
        target: (identifier) @local.definition.function
        (arguments
          [
            (identifier) @local.definition.parameter
            (_ (identifier) @local.definition.parameter)
            (_ (_ (identifier) @local.definition.parameter))
            (_ (_ (_ (identifier) @local.definition.parameter)))
            (_ (_ (_ (_ (identifier) @local.definition.parameter))))
            (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))
            (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))
            (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))))))))))
            (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))))))))))
          ]))
    ]?)
  (#set! definition.function.scope parent)(do_block)?) @local.scope

; ExUnit Test Definitions & Scopes
; format-ignore
(call
  target:
    ((identifier) @_identifier
      (#eq? @_identifier "test"))
  (arguments
    [
      (string)
      ((string)
        .
        ","
        .
        [
          (identifier) @local.definition.parameter
          (_ (identifier) @local.definition.parameter)
          (_ (_ (identifier) @local.definition.parameter))
          (_ (_ (_ (identifier) @local.definition.parameter)))
          (_ (_ (_ (_ (identifier) @local.definition.parameter))))
          (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))
          (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))
          (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter)))))))))))))))))))
          (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @local.definition.parameter))))))))))))))))))))
        ])
    ])
  (do_block)?) @local.scope

; Stab Clause Scopes
(stab_clause) @local.scope
