(comment) @comment @spell

(variable_name) @constant

(enum_constant) @constant

(ascii_name) @constant.builtin

"=" @operator

[
  (function_name)
  (command_name)
  (handler_name)
] @function

((command_name) @function.builtin
  (#any-of? @function.builtin "out" "in" "wait" "event" "exec" "disconnect" "connect"))

((handler_name) @function.builtin
  (#any-of? @function.builtin "mismatch" "writetimeout" "replytimeout" "readtimeout" "init"))

[
  "{"
  "}"
  "["
  "]"
  "("
  ")"
  "<"
  ">"
  "/"
  "#/"
] @punctuation.bracket

[
  "$"
  "\\$"
  "@"
] @punctuation.special

(variable_expansion
  [
    "\\${"
    "}"
  ] @punctuation.special)

(format_converter
  [
    "%"
    "{"
    "}"
    "["
    "]"
    "("
    ")"
    "<"
    ">"
    "#/"
    "/"
  ] @punctuation.special)

[
  "|"
  ";"
  ","
  "."
] @punctuation.delimiter

(quoted_literal) @string

(escape_sequence) @string.escape

(format_converter) @function.builtin

(checksum_flag) @operator

(checksum) @function

(regex_pattern) @string.regexp

(time_conversion_spec) @constant.builtin

(keyword) @keyword

(record_name) @constant

(field_name) @variable.member

((field_name) @variable.builtin
  (#any-of? @variable.builtin
    ; Common to all record types
    "NAME" "DESC" "SCAN" "PINI" "PHAS" "EVNT" "PRIO" "DISV" "DISA" "SDIS" "PROC" "DISS" "LCNT"
    "PACT" "FLNK" "SPVT" "STAT" "SEVR" "AMSG" "NSTA" "NSEV" "NAMSG" "ACKS" "ACKT" "UDF" "UDFS"
    "RSET" "DSET" "DPVT" "TPRO" "BKPT" "ASG" "ASP" "DISP" "DTYP" "MLOK" "MLIS" "PPN" "PPNR" "PUTF"
    "RDES" "RPRO" "TIME" "UTAG" "TSE" "TSEL"
    ; Common to input records
    "INP" "DTYP" "RVAL" "VAL" "SIMM" "SIML" "SVAL" "SIOL" "SIMS" "SDLY" "SSCN"
    ; Common to output records
    "OUT" "OVAL" "RBV" "DOL" "OMSL" "IVOA" "IVOV"
    ; Commonly used in other records
    "PREC" "EGU" "HIHI" "HIGH" "LOW" "LOLO" "HHSV" "HSV" "LSV" "LLSV" "HYST" "ADEl" "MDEL" "HOPR"
    "LOPR" "OMSL" "APST" "MPST" "FTVL" "NELM" "NORD" "SHFT" "MASK" "CALC" "SNAM" "NOBT" "SIZV" "LEN"))

((field_name) @variable.builtin
  (#lua-match? @variable.builtin "^[A-U]$"))

((field_name) @variable.builtin
  (#lua-match? @variable.builtin "^FTV?[A-U]$"))

((field_name) @variable.builtin
  (#lua-match? @variable.builtin "^N[O-E][A-U]$"))

((field_name) @variable.builtin
  (#lua-match? @variable.builtin "^INP[0-9A-U]$"))

((field_name) @variable.builtin
  (#lua-match? @variable.builtin "^OUT[A-V]$"))

(number) @number
