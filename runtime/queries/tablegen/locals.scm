; Scopes
[
  (class)
  (multiclass)
  (def)
  (defm)
  (defset)
  (defvar)
  (foreach)
  (if)
  (let)
] @local.scope

; References
[
  (var)
  (identifier)
] @local.reference

; Definitions
(instruction
  (identifier) @local.definition.field)

(let_instruction
  (identifier) @local.definition.field)

(include_directive
  (string) @local.definition.import)

(template_arg
  (identifier) @local.definition.parameter)

(class
  name: (identifier) @local.definition.type)

(multiclass
  name: (identifier) @local.definition.type)

(def
  name: (value
    (_) @local.definition.type))

(defm
  name: (value
    (_) @local.definition.type))

(defset
  name: (identifier) @local.definition.type)

(def_var
  name: (identifier) @local.definition.var)
