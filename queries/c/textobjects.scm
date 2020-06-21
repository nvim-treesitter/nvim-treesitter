;; TODO: supported by official Tree-sitter  if (_)* is more than one node
;; Neovim: will only match if (_) is exactly one node
;(function_definition
  ;body:  (compound_statement
                          ;("{" (_)* @function.inner "}"))?) @function.outer

(function_definition
  body:  (compound_statement) @function.inner) @function.outer
