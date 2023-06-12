(macro_definition
  name: (symbol) @local.definition.macro)

(symbol_assignment
  name: (symbol) @local.definition.var)

(label
  name: (symbol) @local.definition.constant)

(symbol_definition
  name: (symbol) @local.definition.constant)

(offset_definition
  name: (symbol) @local.definition.constant)

(register_definition
  name: (symbol) @local.definition.constant)

(register_list_definition
  name: (symbol) @local.definition.constant)

(external_reference
  symbols: (symbol_list
    (symbol) @local.definition.import))

(symbol) @local.reference
