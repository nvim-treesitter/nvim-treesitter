(tag_name) @attribute @nospell

(tag
  (tag_name) @_tag
  (#eq? @_tag "@param")
  (variable_name) @variable.parameter)

(tag
  (tag_name) @_tag
  (#eq? @_tag "@property")
  (variable_name) @variable.member)

(tag
  (tag_name) @_tag
  (#eq? @_tag "@var")
  (variable_name) @variable)

(tag
  (tag_name) @_tag
  (#eq? @_tag "@function.method")
  (name) @function.method)

(parameter
  (variable_name) @variable.parameter)

(union_type
  [
    (array_type)
    (primitive_type)
    (named_type)
    (optional_type)
  ] @type)

(union_type) @nospell

(variable_name) @nospell

(tag
  (description
    (text) @none @spell))

(tag
  [
    (author_name)
    (version)
  ] @none)

(tag
  (email_address) @string.special.url)

(union_type
  "|" @keyword)

(variable_name
  "$" @keyword)

(tag
  (tag_name) @_tag_name
  [
    "<"
    ">"
  ] @keyword
  (#eq? @_tag_name "@author"))

(text) @spell
