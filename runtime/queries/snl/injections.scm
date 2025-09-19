((comment) @injection.content
  (#set! injection.language "comment"))

((c_code) @injection.content
  (#set! injection.language "c"))

((preproc_arg) @injection.content
  (#set! injection.self))

((call_expression
  function: (identifier) @_function
  (args
    .
    [
      (string_literal
        (string_content) @injection.content)
      (concatenated_string
        (string_literal
          (string_content) @injection.content))
    ]))
  ; format-ignore
  (#any-of? @_function 
    "printf" "printf_s"
    "vprintf" "vprintf_s"
    "scanf" "scanf_s"
    "vscanf" "vscanf_s"
    "wprintf" "wprintf_s"
    "vwprintf" "vwprintf_s"
    "wscanf" "wscanf_s"
    "vwscanf" "vwscanf_s"
    "cscanf" "_cscanf"
    "printw"
    "scanw")
  (#set! injection.language "printf"))

((call_expression
  function: (identifier) @_function
  (args
    (_)
    .
    [
      (string_literal
        (string_content) @injection.content)
      (concatenated_string
        (string_literal
          (string_content) @injection.content))
    ]))
  ; format-ignore
  (#any-of? @_function 
    "fprintf" "fprintf_s"
    "sprintf"
    "dprintf"
    "fscanf" "fscanf_s"
    "sscanf" "sscanf_s"
    "vsscanf" "vsscanf_s"
    "vfprintf" "vfprintf_s"
    "vsprintf"
    "vdprintf"
    "fwprintf" "fwprintf_s"
    "vfwprintf" "vfwprintf_s"
    "fwscanf" "fwscanf_s"
    "swscanf" "swscanf_s"
    "vswscanf" "vswscanf_s"
    "vfscanf" "vfscanf_s"
    "vfwscanf" "vfwscanf_s"
    "wprintw"
    "vw_printw" "vwprintw"
    "wscanw"
    "vw_scanw" "vwscanw")
  (#set! injection.language "printf"))

((call_expression
  function: (identifier) @_function
  (args
    (_)
    .
    (_)
    .
    [
      (string_literal
        (string_content) @injection.content)
      (concatenated_string
        (string_literal
          (string_content) @injection.content))
    ]))
  ; format-ignore
  (#any-of? @_function 
    "sprintf_s"
    "snprintf" "snprintf_s"
    "vsprintf_s"
    "vsnprintf" "vsnprintf_s"
    "swprintf" "swprintf_s"
    "snwprintf_s"
    "vswprintf" "vswprintf_s"
    "vsnwprintf_s"
    "mvprintw"
    "mvscanw")
  (#set! injection.language "printf"))

((call_expression
  function: (identifier) @_function
  (args
    (_)
    .
    (_)
    .
    (_)
    .
    [
      (string_literal
        (string_content) @injection.content)
      (concatenated_string
        (string_literal
          (string_content) @injection.content))
    ]))
  (#any-of? @_function "mvwprintw" "mvwscanw")
  (#set! injection.language "printf"))
