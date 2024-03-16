(field_identifier
  (identifier) @variable.member)

(field_identifier
  (dotted_identifier
    (identifier) @variable.member))

(type_of_clause
  (identifier) @variable.member)

(when_expression
  (identifier) @type)

(when_expression
  (field_list
    (identifier) @variable.member))

(when_expression
  (field_list
    (dotted_identifier
      (identifier) @variable.member)))

(else_expression
  (field_list
    (identifier) @variable.member))

(else_expression
  (field_list
    (dotted_identifier
      (identifier) @variable.member)))

(alias_expression
  (identifier) @label)

(storage_identifier) @keyword.modifier

(_
  function_name: (identifier) @function)

(date_literal) @string.special

[
  ","
  "."
  ":"
  "?"
  "("
  ")"
] @punctuation.delimiter

[
  "AND"
  "OR"
  "NOT"
  "LIKE"
  "NOT_IN"
  "INCLUDES"
  "EXCLUDES"
] @keyword.operator

[
  "="
  "!="
  "<="
  ">="
] @operator

(value_comparison_operator
  [
    "<"
    ">"
  ] @operator)

(set_comparison_operator
  "IN" @keyword.operator)

[
  (int)
  (decimal)
  (currency_literal)
] @number

(string_literal) @string

[
  (date)
  (date_time)
] @string.special

[
  "TRUE"
  "FALSE"
] @boolean

(null_literal) @constant.builtin

[
  "ABOVE"
  "ABOVE_OR_BELOW"
  "ALL_ROWS"
  "ALL"
  "AS"
  "ASC"
  "AT"
  "BELOW"
  "CUSTOM"
  "DATA_CATEGORY"
  "DESC"
  "END"
  "FIELDS"
  "FOR"
  "FROM"
  "GROUP_BY"
  "HAVING"
  "LIMIT"
  "NULLS_FIRST"
  "NULLS_LAST"
  "OFFSET"
  "ORDER_BY"
  "REFERENCE"
  "SELECT"
  "STANDARD"
  "TRACKING"
  "TYPEOF"
  "UPDATE"
  "USING_SCOPE"
  "VIEW"
  "VIEWSTAT"
  "WITH"
] @keyword

[
  "WHERE"
  "WHEN"
  "ELSE"
  "THEN"
] @keyword.conditional

; Using Scope
[
  "delegated"
  "everything"
  "mine"
  "mine_and_my_groups"
  "my_territory"
  "my_team_territory"
  "team"
] @keyword

; With
[
  "maxDescriptorPerRecord"
  "RecordVisibilityContext"
  "Security_Enforced"
  "supportsDomains"
  "supportsDelegates"
  "System_Mode"
  "User_Mode"
  "UserId"
] @keyword
