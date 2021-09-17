[
    (comment)
    (shebang)
] @comment

[
    ":"
    ","
    "."
] @punctuation.delimiter

[
    "("
    ")"
    "{"
    "}"
] @punctuation.bracket

[
    "class"
    "object"
    "fun"
    "var"
    "val"
    "try"
    "catch"
    "finally"
] @keyword

"import" @include

"return" @keyword.return

(package_stmt
    "package" @include)
(package_path
    (identifier) @namespace)

(return_expr
    "return@" @keyword.return
    label: (identifier) @label)
(break_expr
    "break@" @keyword
    label: (identifier) @label)

(label
    name: (identifier) @label) @constant

[
    "for"
    "do"
    "while"
] @repeat

[
    "||"
    "&&"
    "!="
    "!=="
    "=="
    "==="
    "<"
    ">"
    "<="
    ">="
    ".."
    "+"
    "-"
    "%"
    "*"
    "/"
] @operator

[
    "as"
    "as?"
    "in"
] @keyword.operator

(class_decl
    name: (identifier) @type)
(class_decl
    super: (_) @type)
(object_decl
    name: (identifier) @type)

(class_param
    name: (identifier) @parameter
    type: (_) @type)

(type_constraints
    "where" @keyword
    (type_constraint
        type:  (identifier) @type
        super: (_) @type))

(property
    name: (identifier) @property)
(property
    type: (_) @type)

(enum_entry
    name: (identifier) @constant)

(func_decl
    name: (identifier) @function)
(func_decl
    return: (_) @type)

(param_decl
    name: (identifier) @parameter
    type: (_) @type)

(type_param
    name: (identifier) @type)

(call
    function: (identifier) @function)
(call
    function: (selector
        field: (identifier) @function))

(getter
    "get" @function.builtin)
(setter
    "set" @function.builtin)

((identifier) @function.builtin
    (#any-of? @function.builtin
        "arrayOf"
        "arrayOfNulls"
        "assert"
        "booleanArrayOf"
        "byteArrayOf"
        "Char"
        "charArrayOf"
        "check"
        "checkNotNull"
        "doubleArrayOf"
        "emptyArray"
        "enumValueOf"
        "enumValues"
        "error"
        "floatArrayOf"
        "intArrayOf"
        "lazy"
        "lazyOf"
        "longArrayOf"
        "repeat"
        "require"
        "requireNotNull"
        "run"
        "runCatching"
        "shortArrayOf"
        "suspend"
        "synchronized"
        "TODO"
        "ubyteArrayOf"
        "UintArray"
        "uintArrayOf"
        "ULongArray"
        "ulongArrayOf"
        "UShortArray"
        "ushortArrayOf"
        "with"
        "print"
        "println"
        "readLine"))
((identifier) @constant.builtin
    (#eq? @constant.builtin "it"))

(lambda
    args: (var_decl
        name: (identifier) @parameter))
(lambda
    args: (var_decl
        type: (_) @type ))

(binary_expr
    operator: (identifier) @keyword.operator)

(ERROR) @error

(integer) @number
(float) @float

(string) @string

"null" @constant

[
    "true"
    "false"
] @boolean

