; basic keywords
[
  "assert"
  "in"
  "inherit"
  "let"
  "rec"
  "with"
] @keyword

; these are technically functions but they act more like keywords (abort and throw are control flow, derivation is a core language construct)
((identifier) @keyword
  (#any-of? @keyword "abort" "derivation" "throw"))

; if/then/else
[
  "if"
  "then"
  "else"
] @conditional

; field access default (`a.b or c`)
"or" @keyword.operator

; comments
(comment) @comment

; strings
[ (string_expression) (indented_string_expression) ] @string

; paths and URLs
[ (path_expression) (spath_expression) (uri_expression) ] @string.special

; escape sequences
(escape_sequence) @string.escape

; delimiters
[
  "."
  ";"
  ","
] @punctuation.delimiter

; brackets
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; `?` in `{ x ? y }:`, used to set defaults for named function arguments
(formal
  name: (identifier) @parameter
  "?"? @operator)

; `...` in `{ ... }`, used to ignore unknown named function arguments (see above)
(ellipses) @punctuation.special

; universal is the parameter of the function expression
; `:` in `x: y`, used to separate function argument from body (see above)
(function_expression
  universal: (identifier) @parameter
  ":" @punctuation.special)

; function calls
(apply_expression
  function: (variable_expression
    name: (identifier) @function.call))

; basic identifiers
(variable_expression) @variable

; builtin functions
; modified from `nix __dump-builtins | jq keys`
((identifier) @function.builtin (#any-of? @function.builtin
  "add"
  "all"
  "any"
  "attrNames"
  "attrValues"
  "baseNameOf"
  "bitAnd"
  "bitOr"
  "bitXor"
  "break"
  "catAttrs"
  "ceil"
  "compareVersions"
  "concatLists"
  "concatMap"
  "concatStringsSep"
  "deepSeq"
  "dirOf"
  "div"
  "elem"
  "elemAt"
  "fetchClosure"
  "fetchGit"
  "fetchTarball"
  "fetchurl"
  "filter"
  "filterSource"
  "floor"
  "foldl'"
  "fromJSON"
  "functionArgs"
  "genList"
  "genericClosure"
  "getAttr"
  "getEnv"
  "getFlake"
  "groupBy"
  "hasAttr"
  "hashFile"
  "hashString"
  "head"
  "intersectAttrs"
  "isAttrs"
  "isBool"
  "isFloat"
  "isFunction"
  "isInt"
  "isList"
  "isNull"
  "isPath"
  "isString"
  "length"
  "lessThan"
  "listToAttrs"
  "map"
  "mapAttrs"
  "match"
  "mul"
  "parseDrvName"
  "partition"
  "path"
  "pathExists"
  "placeholder"
  "readDir"
  "readFile"
  "removeAttrs"
  "replaceStrings"
  "seq"
  "sort"
  "split"
  "splitVersion"
  "storePath"
  "stringLength"
  "sub"
  "substring"
  "tail"
  "toFile"
  "toJSON"
  "toPath"
  "toString"
  "toXML"
  "trace"
  "traceVerbose"
  "tryEval"
  "typeOf"
  "zipAttrsWith"
))

((identifier) @include (#eq? @include "import"))

; booleans
((identifier) @boolean (#any-of? @boolean "true" "false"))

; constants
((identifier) @constant.builtin (#any-of? @constant.builtin "builtins" "null"))

; string interpolation (this was very annoying to get working properly)
(interpolation "${" @punctuation.special (_) "}" @punctuation.special) @none

; display entire builtins path as builtin (ex. `builtins.filter` is highlighted as one long builtin)
(select_expression
  expression: ((variable_expression) @_i (#eq? @_i "builtins"))
  attrpath: (attrpath attr: (identifier) @function.builtin))

(select_expression attrpath: (attrpath attr: (identifier) @field))
(attrset_expression (binding_set (binding . (attrpath (identifier) @field))))
(rec_attrset_expression (binding_set (binding . (attrpath (identifier) @field))))

; unary operators
(unary_expression operator: _ @operator)

; binary operators
(binary_expression operator: _ @operator)

; integers, also highlight a unary -
[
  (unary_expression "-" (integer_expression))
  (integer_expression)
] @number

; floats, also highlight a unary -
[
  (unary_expression "-" (float_expression))
  (float_expression)
] @float
