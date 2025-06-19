; Keywords
(kDollar) @keyword
(kInclude) @keyword
(kConst) @keyword
(kVar) @keyword
(kFunc) @keyword
(kIs) @keyword
(kLocal) @keyword
(kBegin) @keyword
(kEndFunc) @keyword
(kIf) @keyword
(kThen) @keyword
(kElsif) @keyword
(kElse) @keyword
(kEndIf) @keyword
(kFor) @keyword
(kRange) @keyword
(kTo) @keyword
(kDo) @keyword
(kEndFor) @keyword
(kRepeat) @keyword
(kUntil) @keyword
(kWhile) @keyword
(kEndWhile) @keyword
(kCase) @keyword
(kOf) @keyword
(kWhen) @keyword ; New
(kOtherwise) @keyword
(kEndCase) @keyword
; Identifiers
(identifier) @variable
(declVar (identifier) @variable)
(declConst (identifier) @constant)
(exprCall (identifier) @function)
(stmtFor (identifier) @variable)
(exprAssign (identifier) @variable)
; Types
(typeProc) @type
(typeString) @type
(typeInteger) @type
; Literals
(string) @string
(integer) @number
; Operators
(kConcat) @operator
(kEq) @operator
(kNeq) @operator
(kLt) @operator
(kGt) @operator
(kLeq) @operator
(kGeq) @operator
(kAssign) @operator
(kPlus) @operator
(kMinus) @operator
(kMult) @operator
(kDiv) @operator
(kRangeOp) @operator ; New
(kSetUnion) @operator ; New
; Punctuation
":" @punctuation.delimiter
";" @punctuation.delimiter
"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket ; New
"}" @punctuation.bracket ; New
(kEndDot) @punctuation.delimiter
; Comments
(comment) @comment
