; let bindings
(let (bind . (attrpath) @definition.var)) @scope

; rec attrsets
(rec_attrset_expression (binding. (attrpath) @definition.field)) @scope

; functions and parameters
(function_expression . [
    (identifier) @definition.parameter
    (formals (formal . (identifier) @definition.parameter))
]) @scope
((formals) "@" (identifier) @definition.parameter) ; I couldn't get this to work properly inside the (function)

; some identifiers can't be references, but @reference doesn't seem to have an inverse like @none
(identifier) @reference
