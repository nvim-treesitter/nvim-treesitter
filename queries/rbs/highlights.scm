["(" ")" "{" "}" "[" "]"] @punctuation.brackets
["," "."]                 @punctuation.delimiter
(method_signatures "|"    @punctuation.special)

["class" "interface" "module" "end" "def" "alias"] @scope

["=" "->" "<" "::"]           @operator
(supertype)                   @operator
(union_type "|")              @operator
(intersection_type "&")       @operator
[":" "?"]                     @operator.special
(splat_parameter "*")         @operator.special
(double_splat_parameter "**") @operator.special

["type" (visibility) (unchecked) (variance)] @keyword

["include" "extend" "prepend"] @include

[(class_name) (constant_name) (module_name) (interface_name)] @type.constant

(builtin_type)  @type.builtin
(type_variable) @type.variable
(alias_name)    @type.alias

[(method_name) (singleton_method_name)] @function
(attribute_type) @function.macro

(var_name)    @variable
(ivar_name)   @variable.instance
(global_name) @variable.global

(singleton_method      "self"  @variable.builtin)
(singleton_method_name "self"  @variable.builtin)
(module_function       "self?" @variable.builtin)

[(symbol_literal) (attribute_name) (hash_key)] @symbol

(string_literal) @string

[(true_literal) (false_literal)] @boolean

(comment) @comment
