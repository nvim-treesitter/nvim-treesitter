[
  (source_file)
  (dependency_list)
  (module_list)
] @fold

(dependency_declaration
  "depends"
  "="
  (dependency_list)) @fold

(module_declaration
  "modules"
  "="
  (module_list)) @fold

(package_declaration
  "package"
  (package_name)) @fold

(main_declaration
  "main"
  "="
  (module_name)) @fold

(executable_declaration
  "executable"
  "="
  (package_name)) @fold

(version_declaration
  "version"
  "="
  (version_number)) @fold

(langversion_declaration
  "langversion"
  (version_range)) @fold
