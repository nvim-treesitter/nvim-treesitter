((comment) @injection.content
  (#set! injection.language "comment"))

(heredoc_body
  (heredoc_content) @injection.content
  (heredoc_end) @injection.language
  (#downcase! @injection.language))

(regex
  (string_content) @injection.content
  (#set! injection.language "regex"))

((call
  receiver: (identifier) @_receiver
  method: (identifier) @_method
  arguments: (argument_list
    (pair
      key: (hash_key_symbol)
      value: (string
        (string_content) @injection.content))))
  (#eq? @_receiver "binding")
  (#any-of? @_method "b" "break")
  (#set! injection.self))
