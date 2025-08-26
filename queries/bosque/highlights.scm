(identifier) @variable
(this) @variable.builtin

(true_lit) @boolean
(false_lit) @boolean

(namespace
  namespace_id: (identifier) @module)
(preprocess_statement
  preprocess_tag: (identifier) @module)

(enum_member) @constant
(none_lit) @constant

(custom_type) @type

(string) @string
(cstring) @string
(regex_expression) @regexp

(num_whole) @number
(num_float) @number.float

(comment) @comment @spell

(function_signature
  function_id: (custom_type) @function)


(namespace_access_expression
  (custom_type) @module)
(namespace_access_type
  (custom_type) @module
  access_target: (custom_type) @type)

(elist_type
  "(|" @type
  "|)" @type)

(type_params
  (type_start) @type
  (type_end) @type)

[
"!"
"+" 
"-" 
"*" 
"//" 
"%" 
"||" 
"&&" 
"|" 
"^" 
"&" 
"===" 
"!==" 
"==" 
"!=" 
">" 
">=" 
"<=" 
"==>" 
"<==>" 
"<" 
"<<" 
">>" 
"\\/"
"/\\"
] @operator

[
"(" 
")" 
"{" 
"}" 
] @punctuation.bracket


[
"#"
"$" 
"@"
"." 
"::"
":"
","
";" 
"=>" 
"->" 
] @punctuation.delimeter


[
"assert" 
] @keyword.conditional

[
"ref" 
"var" 
"let"
"const" 
"_debug" 
"debug" 
"..."
"ref"
"public"
"recursive"
"recursive?"
"chktest"
"errtest"
"safe"
"__safe"
"numeric"
"__numeric"
"__internal"
"__typedeclable"
"__typebase"
"keycomparable"
"__keycomparable"
"assume_safe"
"__assume_safe"
"validate"
"__validate"
] @keyword.modifier

[
"function" 
]@keyword.function

[
"some" 
"type" 
"as" 
"concept" 
"declare" 
"enum" 
"entity" 
"ensures" 
"field" 
"invariant" 
"return"
"method" 
"namespace" 
"of" 
"provides" 
"requires" 
"datatype" 
"using" 
"abort"
"Ok" 
"Fail"
"if" 
"match" 
"switch" 
"else" 
"#if"
"#else"
"#endif"
] @keyword

; "action" @keyword
; "bsqon" @keyword
; "$bsqon" @keyword
; "do" @keyword
; "elif" @keyword
; "env" @keyword
; "fail" @keyword
; "implements" @keyword
; "pred" @keyword
; "result" @keyword
; "self" @keyword
; "then" @keyword
; "yield" @keyword
; "continue" @keyword
; "break" @keyword
; "release" @keyword
; "safety" @keyword
; "spec" @keyword
; "test" @keyword
; "api" @keyword
; "in" @keyword
; "task" @keyword
; "when" @keyword
; "event" @keyword
; "status" @keyword
; "resource" @keyword
; "predicate" @keyword
; "softcheck" @keyword
; "example" @keyword
; "operator" @keyword
; "variant" @keyword
; "private" @keyword
; "internal" @keyword
; "hidden" @keyword
; "sensitive" @keyword
; "export" @keyword
; "deterministic" @keyword
; "idempotent" @keyword
; "abstract" @keyword
; "override" @keyword
; "virtual" @keyword

[
"None"
"Bool"
"Nat"
"Int"
"BigInt"
"BigNat"
"Rational"
"List"
"Option"
"Some"
"Float"
"MapEntry"
"Result"
"Map"
"Decimal"
"DecimalDegree"
"LatLongCoordinate"
"Complex"
"ByteBuffer"
"UUIDv4"
"UUIDv7"
"SHAContentHash"
"TZDateTime"
"TAITime"
"PlainDate"
"PlainTime"
"LogicalTime"
"ISOTimestamp"
"DeltaDateTime"
"DeltaSeconds"
"DeltaLogicalTime"
"DeltaISOTimestamp"
"CChar"
"UnicodeChar"
"CCharBuffer"
"UnicodeCharBuffer"
"String"
"CString"
"Regex"
"CRegex"
"PathRegex"
"Path"
"PathItem"
"Glob"
] @type
