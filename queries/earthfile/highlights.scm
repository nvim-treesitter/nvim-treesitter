(string_array
  "," @punctuation.delimiter)

(string_array
  [
    "["
    "]"
  ] @punctuation.bracket)

[
  "ARG"
  "AS LOCAL"
  "BUILD"
  "CACHE"
  "CMD"
  "COPY"
  "DO"
  "ENTRYPOINT"
  "ENV"
  "EXPOSE"
  "FROM DOCKERFILE"
  "FROM"
  "FUNCTION"
  "GIT CLONE"
  "HOST"
  "IMPORT"
  "LABEL"
  "LET"
  "PROJECT"
  "RUN"
  "SAVE ARTIFACT"
  "SAVE IMAGE"
  "SET"
  "USER"
  "VERSION"
  "VOLUME"
  "WORKDIR"
] @keyword

(for_command
  [
    "FOR"
    "IN"
    "END"
  ] @keyword.repeat)

(if_command
  [
    "IF"
    "END"
  ] @keyword.conditional)

(elif_block
  "ELSE IF" @keyword.conditional)

(else_block
  "ELSE" @keyword.conditional)

(import_command
  [
    "IMPORT"
    "AS"
  ] @keyword.import)

(try_command
  [
    "TRY"
    "FINALLY"
    "END"
  ] @keyword.exception)

(wait_command
  [
    "WAIT"
    "END"
  ] @keyword)

(with_docker_command
  [
    "WITH DOCKER"
    "END"
  ] @keyword)

[
  (comment)
  (line_continuation_comment)
] @comment @spell

[
  (target_ref)
  (target_artifact)
  (function_ref)
] @function

(target
  (identifier) @function)

[
  (double_quoted_string)
  (single_quoted_string)
] @string

(unquoted_string) @string.special

(escape_sequence) @string.escape

(variable) @variable

(expansion
  [
    "$"
    "{"
    "}"
    "("
    ")"
  ] @punctuation.special)

(build_arg
  [
    "--"
    (variable)
  ] @variable.parameter)

(options
  (_) @property)

"=" @operator

(line_continuation) @operator
