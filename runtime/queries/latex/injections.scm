([
  (line_comment)
  (block_comment)
  (comment_environment)
] @injection.content
  (#set! injection.language "comment"))

(pycode_environment
  code: (source_code) @injection.content
  (#set! injection.language "python"))

(sagesilent_environment
  code: (source_code) @injection.content
  (#set! injection.language "python"))

(sageblock_environment
  code: (source_code) @injection.content
  (#set! injection.language "python"))

(luacode_environment
  code: (source_code) @injection.content
  (#set! injection.language "lua"))

(asy_environment
  code: (source_code) @injection.content
  (#set! injection.language "c"))

(asydef_environment
  code: (source_code) @injection.content
  (#set! injection.language "c"))

(minted_environment
  (begin
    language: (curly_group_text
      (text) @injection.language))
  (source_code) @injection.content)
