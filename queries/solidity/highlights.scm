(comment) @comment
(
 (comment) @attribute
 (#match? @attribute "^/// .*")
) ;; Handles natspec comments

; Pragma
(pragma_directive) @tag


; Literals
[
 (string)
 (hex_string_literal)
 (unicode_string_literal)
 (yul_string_literal)
] @string
[
 (number_literal)
 (yul_decimal_number)
 (yul_hex_number)
] @number
[
 (true)
 (false)
] @constant.builtin


; Type
(type_name (identifier) @type)
(type_name "mapping" @type)
(primitive_type) @type
(contract_declaration name: (identifier) @type)
(struct_declaration struct_name: (identifier) @type)
; (struct_member name: (identifier) @field) ;; Technically correct, but makes highlight worst
(enum_declaration enum_type_name: (identifier) @type)
; Color payable in payable address conversion as type and not as keyword
(payable_conversion_expression "payable" @type)
(emit_statement . (identifier) @type)
; Handles ContractA, ContractB in function foo() override(ContractA, contractB) {} 
(override_specifier (identifier) @type)
; Ensures that delimiters in mapping( ... => .. ) are not colored like types
(type_name "(" @punctuation.bracket "=>" @punctuation.delimiter ")" @punctuation.bracket)


; Functions and parameters

(function_definition
  function_name:  (identifier) @function)
(modifier_definition
  name:  (identifier) @function)
(yul_evm_builtin) @function.builtin

; Use contructor coloring for special functions
(constructor_definition "constructor" @constructor)
(fallback_receive_definition "receive" @constructor)
(fallback_receive_definition "fallback" @constructor)

(modifier_invocation (identifier) @function)

; Handles expressions like structVariable.g();
(call_expression . (member_expression (property_identifier) @method))

; Handles expressions like g();
(call_expression . (identifier) @function)

; Handles the field in struct literals like MyStruct({MyField: MyVar * 2})
(call_expression (identifier) @field . ":")

; Function parameters
(event_paramater name: (identifier) @parameter)
(function_definition
  function_name:  (identifier) @parameter)

; Yul functions
(yul_function_call function: (yul_identifier) @function)

; Yul function parameters
(yul_function_definition . (yul_identifier) @function (yul_identifier) @parameter)

(meta_type_expression "type" @keyword)

(member_expression (property_identifier) @property)
(property_identifier) @property
(struct_expression ((identifier) @property . ":"))
(enum_value) @property


; Keywords
[
 "pragma"
 "contract"
 "interface"
 "library"
 "is"
 "struct"
 "enum"
 "event"
 "using"
 "assembly"
 "switch"
 "case"
 "default"
 "break"
 "continue"
 "if"
 "else"
 "try"
 "catch"
 "return"
 "emit"
 "public"
 "internal"
 "private"
 "external"
 "pure"
 "view"
 "payable"
 "modifier"
 "returns"
 "memory"
 "storage"
 "calldata"
 "function"
 "var"
 (constant)
 (virtual)
 (override_specifier)
 (yul_leave)
] @keyword

[
 "for"
 "while"
 "do"
] @repeat

"import" @include
(import_directive "as" @include)
(import_directive "from" @include)

(event_paramater "indexed" @keyword)

; Punctuation

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket


[
  "."
  ","
] @punctuation.delimiter


; Operators

[
  "&&"
  "||"
  ">>"
  ">>>"
  "<<"
  "&"
  "^"
  "|"
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "<"
  "<="
  "=="
  "!="
  "!=="
  ">="
  ">"
  "!"
  "~"
  "-"
  "+"
  "++"
  "--"
] @operator

[
  "delete"
  "new"
] @keyword.operator

(identifier) @variable
(yul_identifier) @variable

