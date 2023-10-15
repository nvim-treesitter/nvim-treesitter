([
  (line_comment)
  (block_comment)
  (comment_environment)
 ] @injection.content
 (#set! injection.language "comment"))

(pycode_environment
  code: 
  (source_code) @injection.content 
  (#set! injection.language "python"))

(sagesilent_environment
  code: 
  (source_code) @injection.content 
  (#set! injection.language "python"))

(sageblock_environment
  code: 
  (source_code) @injection.content 
  (#set! injection.language "python"))

(minted_environment
  (begin
    language: (curly_group_text
               (text) @injection.language))
  (source_code) @injection.content)

((generic_environment
  (begin
   name: (curly_group_text
           (text) @_env))) @injection.content
   (#set! injection.language "c")
   (#any-of? @_env "asy" "asydef"))

