(dict) @local.scope

(dict
  key: (_) @local.definition.type)

(key_value
  keyword: (_) @local.definition.parameter)

(key_value
  value:
    (macro
      (identifier)*)* @local.reference)
