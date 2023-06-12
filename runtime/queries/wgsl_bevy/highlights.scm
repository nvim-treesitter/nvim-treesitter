; inherits wgsl
[
  "virtual"
  "override"
] @keyword

[
  "#import"
  "#define_import_path"
  "as"
] @keyword.import

"::" @punctuation.delimiter

(function_declaration
  (import_path
    (identifier) @function .))

(import_path
  (identifier) @module
  (identifier))

(struct_declaration
  (preproc_ifdef
    (struct_member
      (variable_identifier_declaration
        (identifier) @variable.member))))

(struct_declaration
  (preproc_ifdef
    (preproc_else
      (struct_member
        (variable_identifier_declaration
          (identifier) @variable.member)))))

(preproc_ifdef
  name: (identifier) @constant.macro)

[
  "#ifdef"
  "#ifndef"
  "#endif"
  "#else"
] @keyword.directive
