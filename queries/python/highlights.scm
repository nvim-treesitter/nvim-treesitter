;; From tree-sitter-python licensed under MIT License
; Copyright (c) 2016 Max Brunsfeld

; Reset highlighing in f-string interpolations
(interpolation) @Normal

; Identifier naming conventions
((identifier) @type
 (match? @type "^[A-Z]"))
((identifier) @constant
 (match? @constant "^[A-Z][A-Z_0-9]*$"))

((identifier) @constant.builtin
 (match? @constant.builtin "^__[a-zA-Z0-9_]*__$"))

((attribute
    attribute: (identifier) @field)
 (match? @field "^([A-Z])@!.*$"))

; Function calls

(decorator) @function
((decorator (dotted_name (identifier) @function))
 (match? @function "^([A-Z])@!.*$"))

(call
  function: (identifier) @function)

(call
  function: (attribute
              attribute: (identifier) @method))

((call
   function: (identifier) @constructor)
 (match? @constructor "^[A-Z]"))

((call
  function: (attribute
              attribute: (identifier) @constructor))
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

((function_definition
   name: (identifier) @method
   parameters: (parameters
                 (identifier) @self) )
 (eq? @self "self"))

((function_definition
   name: (identifier) @constructor
   parameters: (parameters
                 (identifier) @self) )
 (eq? @self "self")
 (match? @constructor "(__new__|__init__)"))

(type (identifier) @type)
(type
  (subscript
    (identifier) @type)) ; type subscript: Tuple[int]

((call
  function: (identifier) @isinstance
  arguments: (argument_list
    (*)
    (identifier) @type))
 (eq? @isinstance "isinstance"))

; Normal parameters
(parameters
  (identifier) @parameter)
; Lambda parameters
(lambda_parameters
  (identifier) @parameter)
(lambda_parameters
  (tuple
    (identifier) @parameter ))
; Default parameters
(keyword_argument
  name: (identifier) @parameter)
; Naming parameters on call-site
(default_parameter
  name: (identifier) @parameter)
(typed_parameter
  (identifier) @parameter)
(typed_default_parameter
  (identifier) @parameter)
; Variadic parameters *args, **kwargs
(parameters
  (list_splat ; *args
    (identifier) @parameter))
(parameters
  (dictionary_splat ; **kwargs
    (identifier) @parameter))


; Literals

(none) @constant.builtin
[(true) (false)] @boolean
((identifier) @constant.builtin
              (match? @constant.builtin "self"))

(integer) @number
(float) @float

(comment) @comment
(string) @string
(escape_sequence) @string.escape

; Tokens

[
  "-"
  "-="
  ":="
  "!="
  "*"
  "**"
  "**="
  "*="
  "/"
  "//"
  "//="
  "/="
  "&"
  "%"
  "%="
  "^"
  "+"
  "+="
  "<"
  "<<"
  "<="
  "<>"
  "="
  "=="
  ">"
  ">="
  ">>"
  "|"
  "~"
  "and"
  "in"
  "is"
  "not"
  "or"
  "->"
] @operator

; Keywords

[
  "assert"
  "async"
  "await"
  "class"
  "def"
  "del"
  "except"
  "exec"
  "finally"
  "global"
  "lambda"
  "nonlocal"
  "pass"
  "print"
  "raise"
  "return"
  "try"
  "with"
  "yield"
] @keyword

[ "as" "from" "import"] @include

[ "if" "elif" "else" ] @conditional

[ "for" "while" "break" "continue" ] @repeat

[ "(" ")" "[" "]" "{" "}"] @punctuation.bracket

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special) @embedded

[ "," "." ":" (ellipsis) ] @punctuation.delimiter

; Class definitions

(class_definition
  name: (identifier) @type)
(class_definition
  superclasses: (argument_list
    (identifier) @type))

((class_definition
  body: (block
          (expression_statement
            (assignment
              left: (expression_list
                      (identifier) @field)))))
 (match? @field "^([A-Z])@!.*$"))

;; Error
(ERROR) @error
