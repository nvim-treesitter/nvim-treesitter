[
    (block_comment)
    (comment)
] @comment
((note) @comment.note)
((test) @comment.test)

((date) @number.date)
((effective_date) @number.date.effective)
((time) @number.time)
((interval) @number.interval)
((quantity) @number.quantity)
((negative_quantity) @number.negative.quantity)

((account) @field.account)
((commodity) @text.literal.commodity)
((option) @text.literal.option)
((option_value) @text.literal.option_value)

((check_in) @text.literal.check_in)
(check_in . (date) @number.date.check_in)
(check_in . (date) . (time) @number.time.check_in)
((check_out) @text.literal.check_out)
(check_out . (date) @number.date.check_out)
(check_out . (date) . (time) @number.time.check_out)

"include" @include

[
    "account"
    "alias"
    "assert"
    "check"
    "commodity"
    "comment"
    "def"
    "default"
    "end"
    "eval"
    "format"
    "nomarket"
    "note"
    "payee"
    "test"
    "A"
    "Y"
    "N"
    "D"
    "C"
    "P"
] @keyword
