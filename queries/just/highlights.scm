
(assignment (NAME) @variable)
(alias (NAME) @variable)
(value (NAME) @variable)
(parameter (NAME) @variable)
(setting (NAME) @keyword)
(setting "shell" @keyword)

(call (NAME) @function)
(dependency (NAME) @function)
(depcall (NAME) @function)
(recipeheader (NAME) @function)

(depcall (expression) @parameter)
(parameter) @parameter
(variadic_parameters) @parameter

["if" "else"] @conditional

(string) @string

(boolean ["true" "false"]) @boolean

(comment) @comment

(recipe
  (body) @text.literal.block (#set! "priority" 90))

(shebang_recipe
  (shebang interpreter: (TEXT) @keyword) @comment
  (shebang_body) @text.literal.block (#set! "priority" 90))

["export" "alias" "set"] @keyword

["@" "==" "!=" "+" ":="] @operator

[ "(" ")" "[" "]" "{{" "}}" "{" "}"] @punctuation.bracket

(ERROR) @error
