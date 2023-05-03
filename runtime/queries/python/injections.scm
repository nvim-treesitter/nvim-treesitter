((call
  function: (attribute
	  object: (identifier) @_re)
  arguments: (argument_list (string) @injection.content))
 (#eq? @_re "re")
 (#lua-match? @injection.content "^r.*")
 (#set! injection.language "regex"))

((comment) @injection.content
 (#set! injection.language "comment"))
