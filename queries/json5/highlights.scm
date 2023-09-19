[
    "true"
    "false"
] @boolean

"null" @constant

(string) @string

(number) @number

(comment) @comment @spell

(member
    name: (_) @keyword)

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
