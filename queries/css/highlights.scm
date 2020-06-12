"@media" @keyword
"@import" @include
"@charset" @keyword
"@namespace" @keyword
"@supports" @keyword
"@keyframes" @keyword
(at_keyword) @keyword
(to) @keyword
(from) @keyword
(important) @keyword

(comment) @comment

(tag_name) @type
(nesting_selector) @type
(universal_selector) @type

(function_name) @function

"~" @operator
">" @operator
"+" @operator
"-" @operator
"*" @operator
"/" @operator
"=" @operator
"^=" @operator
"|=" @operator
"~=" @operator
"$=" @operator
"*=" @operator

"and" @operator
"or" @operator
"not" @operator
"only" @operator

(attribute_selector (plain_value) @string)
(pseudo_element_selector (tag_name) @property)
(pseudo_class_selector (class_name) @property)

(class_name) @property
(id_name) @property
(namespace_name) @property
(property_name) @property
(feature_name) @property
(attribute_name) @property


((property_name) @type
 (#match? @type "^--"))
((plain_value) @type
 (#match? @type "^--"))

(string_value) @string
(color_value) @string
(identifier) @string

(integer_value) @number
(float_value) @number
(unit) @string

"#" @punctuation.delimiter
"," @punctuation.delimiter
"." @punctuation.delimiter
":" @punctuation.delimiter
"::" @punctuation.delimiter
";" @punctuation.delimiter
"{" @punctuation.bracket
")" @punctuation.bracket
"(" @punctuation.bracket
"}" @punctuation.bracket
