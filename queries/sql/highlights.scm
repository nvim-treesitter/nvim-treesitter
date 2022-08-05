(invocation
  name: (identifier) @function.call
  parameter: [(field)]? @parameter)

(count
  name: (identifier) @function.call
  parameter: [(field)]? @parameter)

(table_expression
  name: (identifier) @type)

(table_expression
  name: (identifier) @type
  table_alias: (identifier) @variable)

(field
  table_alias: (identifier) @variable
  name: (identifier) @field)

(literal) @string
(comment) @comment

((literal) @number
 (lua-match? @number "^%d+$"))

[
  (keyword_select)
  (keyword_from)
  (keyword_where)
  (keyword_use)
  (keyword_index)
  (keyword_join)
  (keyword_on)
  (keyword_primary)
  (keyword_select)
  (keyword_delete)
  (keyword_create)
  (keyword_insert)
  (keyword_distinct)
  (keyword_replace)
  (keyword_update)
  (keyword_into)
  (keyword_values)
  (keyword_set)
  (keyword_from)
  (keyword_left)
  (keyword_right)
  (keyword_outer)
  (keyword_inner)
  (keyword_join)
  (keyword_on)
  (keyword_where)
  (keyword_order_by)
  (keyword_group_by)
  (keyword_having)
  (keyword_desc)
  (keyword_asc)
  (keyword_as)
  (keyword_limit)
  (keyword_offset)
  (keyword_table)
  (keyword_key)
  (keyword_constraint)
  (keyword_force)
  (keyword_use)
  (keyword_index)
  (keyword_for)
  (keyword_if)
  (keyword_exists)
  (keyword_auto_increment)
  (keyword_default)
  (keyword_max)
  (keyword_min)
  (keyword_avg)
  (keyword_materialized)
  (keyword_column)
  (keyword_cross)
  (keyword_lateral)
  (keyword_alter)
  (keyword_drop)
  (keyword_add)
  (keyword_view)
  (keyword_case)
  (keyword_when)
  (keyword_then)
  (keyword_else)
  (keyword_end)
  (keyword_is)
  (keyword_using)
  (keyword_cascade)
  (double)
  (keyword_with)
  (keyword_no)
  (keyword_data)
  (keyword_type)
  (keyword_rename)
  (keyword_to)
  (keyword_schema)
  (keyword_owner)
  (keyword_temp)
  (keyword_temporary)
  (keyword_union)
  (keyword_all)
  (keyword_except)
  (keyword_intersect)
  (keyword_returning)
  (keyword_begin)
  (keyword_commit)
  (keyword_rollback)
  (keyword_transaction)
  (keyword_null)
  (keyword_true)
  (keyword_false)
  (keyword_boolean)
  (keyword_smallserial)
  (keyword_serial)
  (keyword_bigserial)
  (keyword_smallint)
  (keyword_int)
  (keyword_bigint)
  (keyword_decimal)
  (keyword_numeric)
  (keyword_real)
  (keyword_money)
  (keyword_char)
  (keyword_varchar)
  (keyword_text)
  (keyword_uuid)
  (keyword_json)
  (keyword_jsonb)
  (keyword_xml)
  (keyword_bytea)
  (keyword_date)
  (keyword_datetime)
  (keyword_timestamp)
  (keyword_timestamptz)
  (keyword_geometry)
  (keyword_geography)
  (keyword_box2d)
  (keyword_box3d)
] @keyword

[
  (keyword_in)
  (keyword_and)
  (keyword_or)
  (keyword_not)
] @keyword.operator

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "="
  "<"
  "<="
  "!="
  ">="
  ">"
] @operator

[
  "("
  ")"
] @punctuation.bracket

[
  ";"
  ","
  "."
] @punctuation.delimiter
