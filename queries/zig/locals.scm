(FnProto
  function: (IDENTIFIER) @local.definition.function)

(ParamDecl
  parameter: (IDENTIFIER) @local.definition.parameter
  (ParamType
    (ErrorUnionExpr
      (SuffixExpr
        variable_type_function: (IDENTIFIER) @local.reference
        (#set! reference.kind "type")))))

(VarDecl
  variable_type_function: (IDENTIFIER) @local.definition.var)

(VarDecl
  variable_type_function: (IDENTIFIER) @local.definition.type
  (ErrorUnionExpr
    (SuffixExpr
      (ContainerDecl))))

(ContainerField
  (ErrorUnionExpr
    (SuffixExpr
      variable_type_function: (IDENTIFIER) @local.definition.var)))

(ContainerField
  field_member: (IDENTIFIER) @local.definition.field)

(FieldInit
  field_member: (IDENTIFIER) @local.definition.field)

(FieldOrFnCall
  function_call: (IDENTIFIER) @local.reference
  (#set! reference.kind "function"))

(FieldOrFnCall
  field_access: (IDENTIFIER) @local.reference
  (#set! reference.kind "field"))

(SuffixExpr
  field_constant: (IDENTIFIER) @local.reference
  (#set! reference.kind "field"))

(SuffixExpr
  variable_type_function: (IDENTIFIER) @local.reference)

(LabeledStatement
  (BlockLabel
    (IDENTIFIER) @local.definition))

(BreakLabel
  (IDENTIFIER) @local.reference)

[
  (ForStatement)
  (IfStatement)
  (WhileStatement)
  (FnProto)
  (Block)
  (source_file)
  (ContainerDecl)
] @local.scope
