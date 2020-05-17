;; From tree-sitter-python licensed under MIT License
; Copyright (c) 2016 Max Brunsfeld

; Identifier naming conventions


((import_from_statement
   name: (dotted_name
           (identifier)) @type)
 (match? @type "^[A-Z]"))

((identifier) @constant
 (match? @constant "^[A-Z][A-Z_]*$"))

; Function calls

(decorator) @function

(call
  function: (attribute
              attribute: (identifier) @method))

(call
  function: (identifier) @function)

((call
   (identifier) @constructor)
 (match? @constructor "^[A-Z]"))

;; Builtin functions

((call
  function: (identifier) @function.builtin)
 (match?
   @function.builtin
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$"))

;; Function definitions

(function_definition
  name: (identifier) @function)

(identifier) @variable
(attribute attribute: (identifier) @property)
(type (identifier) @type)
(parameters
  (identifier) @parameter) 

; Literals

(none) @constant.builtin
(true) @boolean
(false) @boolean
((identifier) @constant.builtin
              (match? @constant.builtin "self"))

(integer) @number
(float) @float

(comment) @comment
(string) @string
(escape_sequence) @escape

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special) @embedded

; Tokens

"-" @operator
"-=" @operator
"!=" @operator
"*" @operator
"**" @operator
"**=" @operator
"*=" @operator
"/" @operator
"//" @operator
"//=" @operator
"/=" @operator
"&" @operator
"%" @operator
"%=" @operator
"^" @operator
"+" @operator
"+=" @operator
"<" @operator
"<<" @operator
"<=" @operator
"<>" @operator
"=" @operator
"==" @operator
">" @operator
">=" @operator
">>" @operator
"|" @operator
"~" @operator
"and" @operator
"in" @operator
"is" @operator
"not" @operator
"or" @operator

; Keywords

"as" @include
"assert" @keyword
"async" @keyword
"await" @keyword
"break" @repeat
"class" @keyword
"continue" @repeat
"def" @keyword
"del" @keyword
"elif" @conditional
"else" @conditional
"except" @keyword
"exec" @keyword
"finally" @keyword
"for" @repeat
"from" @include
"global" @keyword
"if" @conditional
"import" @include
"lambda" @keyword
"nonlocal" @keyword
"pass" @keyword
"print" @keyword
"raise" @keyword
"return" @keyword
"try" @keyword
"while" @repeat
"with" @keyword
"yield" @keyword

; Additions for nvim-treesitter
"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket

"," @punctuation.delimiter
"." @punctuation.delimiter
":" @punctuation.delimiter

(class_definition
  name: (identifier) @type)

(attribute
    attribute: (identifier) @field)

((attribute
    attribute: (identifier) @constant)
    (match? @constant "^[A-Z][A-Z_]*$"))

((attribute
    attribute: (identifier) @type)
    (match? @type "^[A-Z][a-z_]+"))

(class_definition
  body: (block
          (expression_statement
            (assignment
              left: (expression_list
                      (identifier) @field)))))

((class_definition
  body: (block
          (expression_statement
            (assignment
              left: (expression_list
                      (identifier) @constant)))))
  (match? @constant "^[A-Z][A-Z_]*$"))

;; Error
(ERROR) @error
