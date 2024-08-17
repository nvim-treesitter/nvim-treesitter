; Keywords
[
  (keyword_select)
  (keyword_from)
  (keyword_let)
  (keyword_else)
  (keyword_end)
  (keyword_only)
  (keyword_value)
  (keyword_as)
  (keyword_omit)
  (keyword_explain)
  (keyword_full)
  (keyword_parallel)
  (keyword_timeout)
  (keyword_fetch)
  (keyword_start_at)
  (keyword_limit)
  (keyword_by)
  (keyword_rand)
  (keyword_collate)
  (keyword_numeric)
  (keyword_asc)
  (keyword_desc)
  (keyword_order)
  (keyword_with)
  (keyword_index)
  (keyword_no_index)
  (keyword_where)
  (keyword_split)
  (keyword_at)
  (keyword_group)
  (keyword_all)
  (keyword_begin)
  (keyword_cancel)
  (keyword_commit)
  (keyword_transaction)
  (keyword_and)
  (keyword_or)
  (keyword_is)
  (keyword_not)
  (keyword_contains)
  (keyword_contains_not)
  (keyword_contains_all)
  (keyword_contains_any)
  (keyword_contains_none)
  (keyword_inside)
  (keyword_in)
  (keyword_not_inside)
  (keyword_all_inside)
  (keyword_any_inside)
  (keyword_none_inside)
  (keyword_outside)
  (keyword_intersects)
  (keyword_chebyshev)
  (keyword_cosine)
  (keyword_euclidean)
  (keyword_hamming)
  (keyword_jaccard)
  (keyword_manhattan)
  (keyword_minkowski)
  (keyword_pearson)
  (keyword_define)
  (keyword_analyzer)
  (keyword_event)
  (keyword_field)
  (keyword_function)
  (keyword_namespace)
  (keyword_param)
  (keyword_scope)
  (keyword_drop)
  (keyword_schemafull)
  (keyword_schemaless)
  (keyword_live)
  (keyword_diff)
  (keyword_flexible)
  (keyword_readonly)
  (keyword_jwks)
  (keyword_eddsa)
  (keyword_es256)
  (keyword_es384)
  (keyword_es512)
  (keyword_ps256)
  (keyword_ps384)
  (keyword_ps512)
  (keyword_rs256)
  (keyword_rs384)
  (keyword_rs512)
  (keyword_bm25)
  (keyword_doc_ids_cache)
  (keyword_doc_ids_order)
  (keyword_doc_lengths_cache)
  (keyword_doc_lengths_order)
  (keyword_postings_cache)
  (keyword_postings_order)
  (keyword_terms_cache)
  (keyword_terms_order)
  (keyword_highlights)
  (keyword_any)
  (keyword_normal)
  (keyword_relation)
  (keyword_out)
  (keyword_to)
  (keyword_changefeed)
  (keyword_content)
  (keyword_merge)
  (keyword_patch)
  (keyword_before)
  (keyword_after)
  (keyword_table)
  (keyword_root)
  (keyword_token)
  (keyword_use)
  (keyword_ns)
  (keyword_db)
  (keyword_on)
  (keyword_user)
  (keyword_roles)
  (keyword_remove)
  (keyword_create)
  (keyword_delete)
  (keyword_update)
  (keyword_insert)
  (keyword_into)
  (keyword_tokenizers)
  (keyword_filters)
  (keyword_when)
  (keyword_then)
  (keyword_type)
  (keyword_default)
  (keyword_assert)
  (keyword_permissions)
  (keyword_relate)
  (keyword_ignore)
  (keyword_values)
  (keyword_for)
  (keyword_comment)
  (keyword_fields)
  (keyword_columns)
  (keyword_unique)
  (keyword_search)
  (keyword_session)
  (keyword_signin)
  (keyword_signup)
  (keyword_if)
  (keyword_exists)
  (keyword_database)
  (keyword_password)
  (keyword_password_hash)
  (keyword_on_duplicate_key_update)
  (keyword_count)
  (keyword_set)
  (keyword_unset)
  (keyword_return)
  (keyword_dimension)
  (keyword_mtree)
  (keyword_dist)
] @keyword

; Operators
[
  (binary_operator)
  (operator)
] @operator

; Literals
[
  (string)
  (prefixed_string)
] @string
[
  (int)
  (float)
  (decimal)
  (duration)
] @number

[
  (keyword_true)
  (keyword_false)
] @boolean

[
  (keyword_none)
  (keyword_null)
] @constant.builtin

; Identifiers
(identifier) @variable
(variable_name) @variable.builtin
[
  (custom_function_name)
  (function_name)
] @function

; Comments
(comment) @comment

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket
"," @punctuation.delimiter

; Types
[
  (type)
  (type_name)
  (parameterized_type)
  (record_id)
] @type

; Special
(graph_path) @operator

; Errors
(ERROR) @error
