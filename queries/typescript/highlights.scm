; inherits: ecma

[
  "declare"
  "enum"
  "export"
  "implements"
  "interface"
  "keyof"
  "type"
  "namespace"
  "override"
  "satisfies"
  "module"
  "infer"
] @keyword

(as_expression "as" @keyword)

[
  "abstract"
  "private"
  "protected"
  "public"
  "readonly"
] @type.qualifier

; types

(type_identifier) @type
(predefined_type) @type.builtin

(import_statement "type"
  (import_clause
    (named_imports
      ((import_specifier
          name: (identifier) @type)))))

(template_literal_type) @string

(non_null_expression "!" @operator)

;; punctuation

(type_arguments
  ["<" ">"] @punctuation.bracket)

(type_parameters
  ["<" ">"] @punctuation.bracket)

(union_type
  "|" @punctuation.delimiter)

(intersection_type 
  "&" @punctuation.delimiter)

(type_annotation
  ":" @punctuation.delimiter)

(index_signature
  ":" @punctuation.delimiter)

(opting_type_annotation
  "?:" @punctuation.delimiter)

"?." @punctuation.delimiter

(method_signature "?" @punctuation.special)
(property_signature "?" @punctuation.special)
(optional_parameter "?" @punctuation.special)

(template_type ["${" "}"] @punctuation.special)

(conditional_type ["?" ":"] @conditional.ternary)

; Variables

(undefined) @variable.builtin

;;; Parameters
(required_parameter (identifier) @parameter)
(optional_parameter (identifier) @parameter)

(required_parameter
  (rest_pattern
    (identifier) @parameter))

;; ({ a }) => null
(required_parameter
  (object_pattern
    (shorthand_property_identifier_pattern) @parameter))

;; ({ a: b }) => null
(required_parameter
  (object_pattern
    (pair_pattern
      value: (identifier) @parameter)))

;; ([ a ]) => null
(required_parameter
  (array_pattern
    (identifier) @parameter))

;; a => null
(arrow_function
  parameter: (identifier) @parameter)

;; function signatures
(ambient_declaration
  (function_signature
    name: (identifier) @function))

;; method signatures
(method_signature name: (_) @method)

;; property signatures
(property_signature
  name: (property_identifier) @method
  type: (type_annotation
          [
            (union_type (parenthesized_type (function_type)))
            (function_type)
          ]))
