(const_declaration
  name: (const_identifier) @definition.function
  value: (proc_literal))

(const_declaration
  name: (const_identifier) @definition.var)

(single_assignment
  lhs: (identifier) @definition.function
  rhs: (proc_literal))

(var_declaration
  name: (identifier) @definition.var)

(for_statement
  name: (identifier) @definition.var)

(assignment_statement
  lhs: (identifier) @definition.var
  (operator) @_operator
  (#eq? @_operator ":="))

(parameter_declaration
  name: (identifier) @definition.var)

(struct_field_declaration
  name: (identifier) @definition.field)

(enum_type
  variants: (initializer_list (identifier) @definition.enum))

(const_declaration
  name: (const_identifier) @definition.type
  value: [(struct_type) (union_type) (enum_type)])

(import_declaration
  name: (package_identifier) @definition.import)

(identifier) @reference

(block) @scope
(top_block) @scope
