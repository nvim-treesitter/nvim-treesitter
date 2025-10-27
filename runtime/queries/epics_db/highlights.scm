(string) @string

(escape_sequence) @string.escape

(macro_expansion) @string.special

(record_name) @constant

(menu_definition
  name: (_) @type.definition)

(menu_choice
  name: (_) @constant)

(record_type_definition
  name: (_) @type.definition)

(field_definition
  name: (_) @variable.member)

(field_definition
  type: (_) @type)

(field_definition
  type: (_) @type.builtin
  (#any-of? @type.builtin
    "DBF_STRING" "DBF_CHAR" "DBF_UCHAR" "DBF_SHORT" "DBF_USHORT" "DBF_LONG" "DBF_ULONG" "DBF_FLOAT"
    "DBF_DOUBLE" "DBF_INT64" "DBF_UINT64" "DBF_ENUM" "DBF_MENU" "DBF_DEVICE" "DBF_INLINK"
    "DBF_OUTLINK" "DBF_FWDLINK" "DBF_NOACCESS"))

(field_item) @function

((field_item) @function.builtin
  (#any-of? @function.builtin
    "asl" "initial" "promptgroup" "prompt" "special" "pp" "interest" "base" "size" "extra" "menu"
    "prop"))

(field_descriptor
  (field_item) @_asl
  value: (_) @constant.builtin
  (#eq? @_asl "asl")
  (#any-of? @constant.builtin "ASL0" "ASL1"))

(field_descriptor
  (field_item) @_prompt
  value: (string) @spell
  (#any-of? @_prompt "prompt" "promptgroup"))

(field_descriptor
  (field_item) @_special
  value: (_) @constant.builtin
  (#eq? @_special "special")
  (#any-of? @constant.builtin
    "SPC_MOD" "SPC_NOMOD" "SPC_DBADDR" "SPC_SCAN" "SPC_ALARMACK" "SPC_AS" "SPC_RESET" "SPC_LINCONV"
    "SPC_CALC"))

(field_descriptor
  (field_item) @_pp
  value: (_) @boolean
  (#eq? @_pp "pp")
  (#any-of? @boolean "FALSE" "TRUE"))

(field_descriptor
  (field_item) @_base
  value: (_) @constant.builtin
  (#eq? @_base "base")
  (#any-of? @constant.builtin "DECIMAL" "HEX"))

(field_descriptor
  (field_item) @_prop
  value: (_) @boolean
  (#eq? @_prop "prop")
  (#any-of? @boolean "YES" "NO"))

(record_type) @type

((record_type) @type.builtin
  (#any-of? @type.builtin
    "aai" "aao" "ai" "ao" "aSub" "bi" "bo" "calc" "calcout" "compress" "dfanout" "event" "fanout"
    "histogram" "longin" "longout" "int64in" "int64out" "mbbi" "mbbiDirect" "mbbo" "mbboDirect"
    "permissive" "printf" "sel" "seq" "state" "stringin" "stringout" "lsi" "lso" "subArray" "sub"
    "waveform"))

(device_support_declaration
  link_type: (_) @constant.builtin
  (#any-of? @constant.builtin
    "CONSTANT" "PV_LINK" "VME_IO" "CAMAC_IO" "AB_IO" "GPIB_IO" "BITBUS_IO" "INST_IO" "BBGPIB_IO"
    "RF_IO" "VXI_IO"))

(variable_declaration
  name: (_) @variable)

(variable_declaration
  type: (_) @type)

(function_declaration
  name: (_) @function)

(number) @number.float

(field_name) @variable.member

((field
  name: (field_name) @variable.builtin
  value: (string) @variable)
  (#lua-match? @variable.builtin "^INP[0-9A-U]$"))

((field
  name: (field_name) @variable.builtin
  value: (string) @variable)
  (#lua-match? @variable.builtin "^OUT[A-V]$"))

(field
  name: (field_name) @variable.builtin
  value: (string) @variable
  (#lua-match? @variable.builtin "^LNK[0-9A-F]$"))

(field
  name: (_) @_field
  value: (string) @variable
  (#eq? @_field "FLNK"))

(field
  name: (_) @_field
  value: (string) @spell
  (#eq? @_field "DESC"))

(comment) @comment @spell

[
  "${"
  "{"
  "}"
  "$("
  "("
  ")"
] @punctuation.bracket

"," @punctuation.delimiter

"%" @punctuation.special

[
  "path"
  "addpath"
  "choice"
  "field"
  "device"
  "driver"
  "link"
  "registrar"
  "variable"
  "breaktable"
  "record"
  "grecord"
  "info"
  "alias"
] @keyword

"function" @keyword.function

"include" @keyword.import

[
  "menu"
  "recordtype"
] @keyword.type

(field_definition
  "field" @keyword.type)
