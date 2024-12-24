; Scopes
(source_file) @local.scope

; Definitions
(package_declaration
  (package_name) @local.definition.import)

(module_declaration
  (module_list
    (module_name) @local.definition.namespace))

(main_declaration
  (module_name) @local.definition.import)

(executable_declaration
  (package_name) @local.definition.import)

; References
(dependency_declaration
  (dependency_list
    (dependency_item
      (package_name) @local.reference)))

(module_name) @local.reference
