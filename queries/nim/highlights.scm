(keyw) @keyword

[
 "["
 "]"
 "("
 ")"
 ] @punctuation.bracket

[
 "."
 ":"
 ] @punctuation.delimiter

[
  (operator)
  (opr)
  "="
] @operator

(importStmt (keyw) @include)
(fromStmt (keyw) @include)
(str_lit) @string
(int_lit) @number
[(float_lit) (float_suffix)] @float

[
 (comment)
 (docComment)
 (multilineComment)
 (multilineDocComment)
] @comment

(primary . (symbol (ident) @function.call) . (primarySuffix (functionCall)))
(primary (primarySuffix (qualifiedSuffix (symbol (ident) @function.call))) . (primarySuffix (functionCall)))

(routine . (keyw) . (ident) @function)
(paramList (paramColonEquals (symbol (ident) @parameter)))

(typeDesc (primary (symbol) @type))
;(typeDesc (primarySuffix (cmdCall (primary (symbol) @type))))
