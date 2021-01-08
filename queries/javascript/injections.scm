((comment) @jsdoc)

((regex_pattern) @regex)

(call_expression
	function: ((identifier) @_name
		(#eq? @_name "gql"))
	arguments: ((template_string) @graphql))
