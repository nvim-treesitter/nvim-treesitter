;; From tree-sitter-python licensed under MIT License
; Copyright (c) 2016 Max Brunsfeld

; Variables
(identifier) @variable

; Reset highlighing in f-string interpolations
(interpolation) @none

;; Identifier naming conventions
((identifier) @type
 (#match? @type "^[A-Z]"))
((identifier) @constant
 (#match? @constant "^[A-Z][A-Z_0-9]*$"))

((identifier) @constant.builtin
 (#match? @constant.builtin "^__[a-zA-Z0-9_]*__$"))

((identifier) @constant.builtin
 (#vim-match? @constant.builtin
              ;; https://docs.python.org/3/library/constants.html
              "^(NotImplemented|Ellipsis|quit|exit|copyright|credits|license)$"))

((attribute
    attribute: (identifier) @field)
 (#vim-match? @field "^([A-Z])@!.*$"))

((identifier) @type.builtin
 (#vim-match? @type.builtin
              ;; https://docs.python.org/3/library/exceptions.html
              "^(BaseException|Exception|ArithmeticError|BufferError|LookupError|AssertionError|AttributeError|EOFError|FloatingPointError|GeneratorExit|ImportError|ModuleNotFoundError|IndexError|KeyError|KeyboardInterrupt|MemoryError|NameError|NotImplementedError|OSError|OverflowError|RecursionError|ReferenceError|RuntimeError|StopIteration|StopAsyncIteration|SyntaxError|IndentationError|TabError|SystemError|SystemExit|TypeError|UnboundLocalError|UnicodeError|UnicodeEncodeError|UnicodeDecodeError|UnicodeTranslateError|ValueError|ZeroDivisionError|EnvironmentError|IOError|WindowsError|BlockingIOError|ChildProcessError|ConnectionError|BrokenPipeError|ConnectionAbortedError|ConnectionRefusedError|ConnectionResetError|FileExistsError|FileNotFoundError|InterruptedError|IsADirectoryError|NotADirectoryError|PermissionError|ProcessLookupError|TimeoutError|Warning|UserWarning|DeprecationWarning|PendingDeprecationWarning|SyntaxWarning|RuntimeWarning|FutureWarning|ImportWarning|UnicodeWarning|BytesWarning|ResourceWarning)$"))

; Function calls

(decorator) @function
((decorator (attribute (identifier) @function))
 (#vim-match? @function "^([A-Z])@!.*$"))
(decorator) @function
((decorator (identifier) @function)
 (#vim-match? @function "^([A-Z])@!.*$"))

(call
  function: (identifier) @function)

(call
  function: (attribute
              attribute: (identifier) @method))

((call
   function: (identifier) @constructor)
 (#match? @constructor "^[A-Z]"))

((call
  function: (attribute
              attribute: (identifier) @constructor))
 (#match? @constructor "^[A-Z]"))

;; Builtin functions

((call
  function: (identifier) @function.builtin)
 (vim-match? @function.builtin
             "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$"))

;; Function definitions

(function_definition
  name: (identifier) @function)

(type (identifier) @type)
(type
  (subscript
    (identifier) @type)) ; type subscript: Tuple[int]

((call
  function: (identifier) @_isinstance
  arguments: (argument_list
    (_)
    (identifier) @type))
 (#eq? @_isinstance "isinstance"))

;; Normal parameters
(parameters
  (identifier) @parameter)
;; Lambda parameters
(lambda_parameters
  (identifier) @parameter)
(lambda_parameters
  (tuple_pattern
    (identifier) @parameter))
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
  (list_splat_pattern ; *args
    (identifier) @parameter))
(parameters
  (dictionary_splat_pattern ; **kwargs
    (identifier) @parameter))


;; Literals

(none) @constant.builtin
[(true) (false)] @boolean
((identifier) @variable.builtin
 (#match? @variable.builtin "^self$"))

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
  "&="
  "%"
  "%="
  "^"
  "^="
  "+"
  "+="
  "<"
  "<<"
  "<<="
  "<="
  "<>"
  "="
  "=="
  ">"
  ">="
  ">>"
  ">>="
  "@"
  "@="
  "|"
  "|="
  "~"
  "->"
] @operator

; Keywords
[
  "and"
  "in"
  "is"
  "not"
  "or"

  "del"
] @keyword.operator

[
  "assert"
  "async"
  "await"
  "class"
  "def"
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
  "as"
] @keyword

["from" "import"] @include
(aliased_import "as" @include)

["if" "elif" "else"] @conditional

["for" "while" "break" "continue"] @repeat

["(" ")" "[" "]" "{" "}"] @punctuation.bracket

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special)

["," "." ":" (ellipsis)] @punctuation.delimiter

;; Class definitions

(class_definition
  name: (identifier) @type
  body: (block
          (function_definition
            name: (identifier) @method)))

(class_definition
  superclasses: (argument_list
                  (identifier) @type))

((class_definition
  body: (block
          (expression_statement
            (assignment
              left: (identifier) @field))))
 (#vim-match? @field "^([A-Z])@!.*$"))
((class_definition
  body: (block
          (expression_statement
            (assignment
              left: (_ 
                     (identifier) @field)))))
 (#vim-match? @field "^([A-Z])@!.*$"))

((class_definition
  (block
    (function_definition
      name: (identifier) @constructor)))
 (#vim-match? @constructor "^(__new__|__init__)$"))

; First parameter of a method is self or cls.
((class_definition
  body: (block
          (function_definition
            parameters: (parameters . (identifier) @variable.builtin))))
 (#vim-match? @variable.builtin "^(self|obj|cls)$"))

;; Error
(ERROR) @error
