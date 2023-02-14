(invocation
  name: (identifier) @function.call
  parameter: [(field)]? @parameter)

(keyword_gist) @function.call
(keyword_btree) @function.call
(keyword_hash) @function.call
(keyword_spgist) @function.call
(keyword_gin) @function.call
(keyword_brin) @function.call
(keyword_float) @function.call

(count
  name: (keyword_count) @function.call
  parameter: [(field)]? @parameter)

(table_reference
  name: (identifier) @type)

(relation
  table_alias: (identifier) @variable)

(field
  table_alias: (identifier) @variable
  name: (identifier) @field)

(term
  alias: (identifier) @variable)

((term
   value: (cast
    name: (keyword_cast) @function.call
    parameter: [(literal)]?)))

(literal) @string
(comment) @comment
(marginalia) @comment

((literal) @number
 (#lua-match? @number "^%d+$"))

((literal) @float
(#lua-match? @float "^[-]?%d*\.%d*$"))

(parameter) @parameter

[
 (keyword_true)
 (keyword_false)
] @boolean

[
 (keyword_asc)
 (keyword_desc)
 (keyword_external)
 (keyword_stored)
 (keyword_parquet)
 (keyword_csv)
 (keyword_rcfile)
 (keyword_textfile)
 (keyword_orc)
 (keyword_avro)
 (keyword_jsonfile)
 (keyword_temp)
 (keyword_cached)
 (keyword_uncached)
 (keyword_unlogged)
 (keyword_terminated)
 (keyword_escaped)
 (keyword_partitioned)
 (keyword_location)
 (keyword_lines)
 (keyword_unsigned)
 (keyword_nulls)
 (keyword_last)
 (keyword_materialized)
 (keyword_temp)
 (keyword_temporary)
] @attribute

[
 (keyword_case)
 (keyword_when)
 (keyword_then)
 (keyword_else)
] @conditional

[
  (keyword_select)
  (keyword_from)
  (keyword_where)
  (keyword_index)
  (keyword_join)
  (keyword_on)
  (keyword_primary)
  (keyword_delete)
  (keyword_create)
  (keyword_insert)
  (keyword_distinct)
  (keyword_replace)
  (keyword_update)
  (keyword_into)
  (keyword_values)
  (keyword_set)
  (keyword_left)
  (keyword_right)
  (keyword_outer)
  (keyword_inner)
  (keyword_order)
  (keyword_group)
  (keyword_by)
  (keyword_having)
  (keyword_as)
  (keyword_limit)
  (keyword_offset)
  (keyword_table)
  (keyword_key)
  (keyword_constraint)
  (keyword_force)
  (keyword_use)
  (keyword_for)
  (keyword_if)
  (keyword_exists)
  (keyword_auto_increment)
  (keyword_default)
  (keyword_max)
  (keyword_min)
  (keyword_avg)
  (keyword_column)
  (keyword_cross)
  (keyword_lateral)
  (keyword_alter)
  (keyword_drop)
  (keyword_add)
  (keyword_view)
  (keyword_end)
  (keyword_is)
  (keyword_using)
  (keyword_cascade)
  (keyword_between)
  (keyword_window)
  (keyword_with)
  (keyword_no)
  (keyword_data)
  (keyword_type)
  (keyword_rename)
  (keyword_to)
  (keyword_schema)
  (keyword_owner)
  (keyword_union)
  (keyword_all)
  (keyword_except)
  (keyword_intersect)
  (keyword_returning)
  (keyword_begin)
  (keyword_commit)
  (keyword_rollback)
  (keyword_transaction)
  (keyword_only)
  (keyword_like)
  (keyword_similar)
  (keyword_over)
] @keyword

[
  (keyword_int)
  (keyword_null)
  (keyword_boolean)
  (keyword_smallserial)
  (keyword_serial)
  (keyword_bigserial)
  (keyword_smallint)
  (keyword_bigint)
  (keyword_decimal)
  (keyword_numeric)
  (keyword_real)
  (double)
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
] @type.builtin

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

