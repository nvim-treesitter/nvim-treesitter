(parameter
  (type_specifier) @type)

(parameter
  (identifier) @variable.parameter)

(ecall_definition
  (identifier) @function)

(ocall_definition
  (identifier) @function)

(ecall_definition
  (retval) @type)

(ocall_definition
  (retval) @type)

(type_qualifier) @keyword.modifier

(comments) @comment

(string) @string

(header_name) @string

[
  ";"
  ","
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "enclave"
  "trusted"
  "untrusted"
  "allow"
] @keyword

(untrusted_suffix_allow
  (identifier) @variable.parameter)

(size_attribute
  (number) @number)

(size_attribute
  (identifier) @variable.parameter)

(trusted_prefix_public) @keyword.modifier

[
  "import"
  "from"
] @keyword.import

[
  "*"
  "="
] @operator

[
  "in"
  "out"
  "user_check"
  "string"
  "wstring"
  "isary"
  "isptr"
  "readonly"
  "size"
  "count"
] @storageclass

(size_attribute
  (number)) @number
