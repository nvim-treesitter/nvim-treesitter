(unit
    (identifier) @variable)
(string
    (identifier) @variable)

(escape_sequence) @string.escape

(block
    (unit
       (identifier) @namespace))

(func
    (identifier) @function)

(number) @number

((identifier) @boolean
  (#any-of? @boolean "true" "false" "True" "False"))

((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

((identifier) @type.definition
  (#any-of? @type.definition
    "string"
    "String"
    "void"
    "id"
    "version"
    "apply"
    "implementation"
    "testImplementation"
    "androidTestImplementation"
    "debugImplementation"))

((identifier) @keyword
  (#any-of? @keyword
    "static"
    "class"
    "def"
    "import"
    "new"))

(string) @string

(comment) @comment

(operators) @operator
(leading_key) @operator

["(" ")" "[" "]" "{" "}"]  @punctuation.bracket
