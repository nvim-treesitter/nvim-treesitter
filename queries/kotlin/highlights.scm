;;; Kotlin

(simple_identifier) @variable
; Reset some
(navigation_suffix (simple_identifier) @none)
(import_header (identifier (simple_identifier) @none))
(package_header (identifier (simple_identifier) @none))


;; Strings
(line_string_literal) @string
(multi_line_string_literal) @string
; Interpolated
(interpolated_identifier) @variable
(interpolated_expression) @none


;; Suffixes
(navigation_expression (navigation_suffix (simple_identifier) @property ))
; Reset some
(assignment (navigation_expression (navigation_suffix (simple_identifier) @none )))
(call_expression (navigation_expression (navigation_suffix (simple_identifier) @none )))
(navigation_expression (navigation_expression (navigation_suffix (simple_identifier) @none )))



;; Variables/fields
; attribute in data classes etc.
(class_parameter (simple_identifier) @field)
; variable in normal classes
(property_declaration (variable_declaration (simple_identifier) @variable))
; accessed field in blocks. `logger` in `logger.info("")`
(statements (call_expression (navigation_expression (simple_identifier) @variable)))
(indexing_expression (call_expression (navigation_expression (simple_identifier) @variable)))
; `classProp` in `classProp.lastIndex`
(statements (navigation_expression (simple_identifier) @variable))
; `variable` in `variable = car.doors`
(directly_assignable_expression (simple_identifier) @variable)


;; Constants
; Assume all-caps names are constants
((simple_identifier) @constant
 (#match? @constant "^[A-Z][A-Z_0-9]+$"))
((interpolated_identifier) @constant
 (#vim-match? @constant "^[A-Z][A-Z_0-9]+$"))


(lambda_parameters) @parameter


;; Builtin functions
((simple_identifier) @function.macro
 (#vim-match? @function.macro "^(commonPrefixWith|commonSuffixWith|endsWith|findAnyOf|findLastAnyOf|hasSurrogatePairAt|ifBlank|ifEmpty|indexOf|indexOfAny|isEmpty|isNotBlank|isNotEmpty|isNullOrBlank|isNullOrEmpty|lastIndexOf|lastIndexOfAny|lineSequence|lines|orEmpty|padEnd|padStart|removePrefix|removeRange|removeSuffix|removeSurrounding|replace|replaceAfter|replaceAfterLast|replaceBefore|replaceBeforeLast|replaceFirst|replaceRange|split|splitToSequence|startsWith|subSequence|substring|substringAfter|substringAfterLast|substringBefore|substringBeforeLast|trim|trimEnd|trimStart|containsKey|containsValue|filter|filterKeys|filterNot|filterNotTo|filterTo|filterValues|getOrElse|getOrPut|getValue|ifEmpty|isNotEmpty|isNullOrEmpty|mapKeys|mapKeysTo|mapValues|mapValuesTo|orEmpty|putAll|remove|toMap|toMutableMap|toPair|also|apply|let|run|takeIf|takeUnless|prependIndent|replaceIndent|replaceIndentByMargin|trimIndent|trimMargin|all|any|asIterable|asSequence|associate|associateBy|associateByTo|associateTo|associateWith|associateWithTo|chunked|chunkedSequence|count|drop|dropLast|dropLastWhile|dropWhile|elementAtOrElse|elementAtOrNull|filter|filterIndexed|filterIndexedTo|filterNot|filterNotTo|filterTo|find|findLast|first|firstOrNull|flatMap|flatMapIndexed|flatMapIndexedTo|flatMapTo|fold|foldIndexed|foldRight|foldRightIndexed|forEach|forEachIndexed|getOrElse|getOrNull|groupBy|groupByTo|groupingBy|indexOfFirst|indexOfLast|last|lastOrNull|map|mapIndexed|mapIndexedNotNull|mapIndexedNotNullTo|mapIndexedTo|mapNotNull|mapNotNullTo|mapTo|max|maxBy|maxByOrNull|maxOf|maxOfOrNull|maxOfWith|maxOfWithOrNull|maxOrNull|maxWith|maxWithOrNull|min|minBy|minByOrNull|minOf|minOfOrNull|minOfWith|minOfWithOrNull|minOrNull|minWith|minWithOrNull|none|onEach|onEachIndexed|partition|random|randomOrNull|reduce|reduceIndexed|reduceIndexedOrNull|reduceOrNull|reduceRight|reduceRightIndexed|reduceRightIndexedOrNull|reduceRightOrNull|reversed|runningFold|runningFoldIndexed|runningReduce|runningReduceIndexed|scan|scanIndexed|scanReduce|scanReduceIndexed|single|singleOrNull|slice|sumBy|sumByDouble|sumOf|take|takeLast|takeLastWhile|takeWhile|toCollection|toHashSet|toList|toMutableList|toSet|windowed|windowedSequence|withIndex|zip|zipWithNext)$"))

(call_expression
   (simple_identifier) @function)

((simple_identifier) @function.builtin
 (#vim-match? @function.builtin "^(print|println|buildMap|emptyMap|hashMapOf|linkedMapOf|mapOf|mutableMapOf|buildSet|emptySet|hashSetOf|linkedSetOf|mutableSetOf|setOf|setOfNotNull|TODO|repeat|run|with)$"))


;; Numbers
(integer_literal) @number

;; Booleans
(boolean_literal) @boolean

;; Types
(type_identifier) @type

;; Annotations
(annotation (single_annotation) @attribute)
(single_annotation (user_type (type_identifier) @attribute))
(single_annotation (constructor_invocation (user_type (type_identifier) @attribute)))


;; it
(indexing_expression (simple_identifier) @variable.builtin
  (#vim-match? @variable.builtin "^it$"))


;; Operators
[
"="
"-"
"->"
"+"
"++"
"--"
"*"
] @operator

;; Keyword operators
[
"in"
] @keyword.operator

((simple_identifier) @keyword.operator
 (#vim-match? @keyword.operator "^to$"))


;; Keywords
[
 "this"
 "override"
 "enum"
 "as"
 "class"
 "object"
 "data"
 "val"
 "init"
 "private"
 "var"
 "break"
 "by"
 "fun"
 "companion"
 "return"
 "constructor"
 "throw"
] @keyword

(null_literal) @keyword

; const etc.
(property_modifier) @keyword


;; Conditionals
[
"if"
"is"
"else"
"when"
] @conditional


;; Loops
[
"for"
"while"
] @repeat


;; Includes

"import" @include
"package" @include


;; Punctuation

[
"::"
";"
"."
","
] @punctuation.delimiter

[
"$"
"${"
"}"
] @none

[
"["
"]"
"{"
"}"
"("
")"
] @punctuation.bracket

[
"$"
] @punctuation.special

;; Comments
(comment) @comment

; Functions
(function_declaration (simple_identifier) @function)


(ERROR) @error

; TODO parameter
