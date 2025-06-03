(_
  lhs: (linker) @comment
  target: (linker) @markup.strong @diff.plus
  rhs: (linker) @comment)

(linker
  target: (link_name) @markup.strong @diff.minus) @comment

((identifier) @variable
  (#set! priority 95))

((identifier) @constant
  (#set! priority 103)
  (#match? @constant "^[A-Z0-9_\\-]+$"))

((identifier) @constant
  (#set! priority 103)
  (#match? @constant "args"))

(comment) @comment

[
  "auto"
  "extrn"
] @keyword.type

"return" @keyword.return

"while" @keyword.repeat

(goto_statement
  token: "goto" @keyword
  name: (rvalue) @label)

(label_statement
  name: (_) @label)

[
  "if"
  "else"
  "case"
  "switch"
] @keyword.conditional

[
  (op_binary)
  (op_unary)
  (op_assign)
  (op_incdec)
] @keyword.operator

(rune_literal) @character

(string_literal) @string

(number_literal) @number

(define_function
  name: (identifier) @function.method)

(call
  name: (identifier) @function.method @function.method.call)

; Standard libraries
((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "char" "chdir" "chmod" "chown" "close" "creat" "ctime" "execl" "execv" "exit" "fork" "fstat"
    "getchar" "getuid" "gtty" "lchar" "link" "mkdir" "open" "printf" "printn" "putchar" "read"
    "setuid" "stat" "stty" "unlink" "wait" "write" "main"))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin "assert")
  (#has-ancestor? @function.builtin program_c_assert_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "isalnum" "isalpha" "isascii4" "isblank" "iscntrl" "isdigit" "isgraph" "islower" "isprint"
    "ispunct" "isspace" "isupper" "toascii" "tolower" "toupper")
  (#has-ancestor? @function.builtin program_c_ctype_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin "nl_langinfo4")
  (#has-ancestor? @function.builtin program_c_langinfo_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "acos" "asin" "atan" "atan2" "ceil" "cos" "cosh" "erf" "erfc" "exp" "fabs" "floor" "fmod"
    "frexp" "gamma" "hypot" "j0" "j1" "jn" "ldexp" "log" "log10" "modf" "nextafter" "nextafterl"
    "nexttoward" "nexttowardl" "pow" "quantexpd32" "quantexpd64" "quantexpd128" "quantized32"
    "quantized64" "quantized128" "samequantumd32" "samequantumd64" "samequantumd128" "sin" "sinh"
    "sqrt" "tan" "tanh" "y0" "y1" "yn")
  (#has-ancestor? @function.builtin program_c_math_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin "catclose6" "catgets6" "catopen6")
  (#has-ancestor? @function.builtin program_c_nl_types_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin "regcomp" "regerror" "regexec" "regfree")
  (#has-ancestor? @function.builtin program_c_regex_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin "longjmp" "setjmp")
  (#has-ancestor? @function.builtin program_c_setjmp_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin "raise" "signal")
  (#has-ancestor? @function.builtin program_c_signal_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "va_arg" "va_copy" "va_end" "va_start" "vfprintf" "vfscanf" "vfwprintf6" "vfwscanf" "vprintf"
    "vscanf" "vsprintf" "vsscanf" "vswprintf" "vwprintf6" "wctob")
  (#has-ancestor? @function.builtin program_c_stdarg_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "btowc" "clearerr" "fclose" "fdopen5" "feof" "ferror" "fflush1" "fgetc1" "fgetpos1" "fgets1"
    "fgetwc6" "fgetws6" "fileno5" "fopen" "fprintf" "fputc1" "fputs1" "fputwc6" "fputws6" "fread"
    "freopen" "fscanf" "fseek1" "fsetpos1" "ftell1" "fwide6" "fwprintf6" "fwrite" "fwscanf6" "getc1"
    "getchar1" "gets" "getwc6" "perror" "printf" "putc1" "putchar1" "puts" "putwc6" "remove"
    "rename" "rewind1" "scanf" "setbuf" "setvbuf" "snprintf" "sprintf" "sscanf" "tmpfile" "tmpnam"
    "ungetc1" "ungetwc6" "vfprintf" "vfscanf" "vfwprintf6" "vfwscanf" "vprintf" "vscanf" "vsprintf"
    "vsnprintf" "vsscanf" "vswscanf" "vwscanf")
  (#has-ancestor? @function.builtin program_c_stdio_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "abort" "abs" "atexit" "atof" "atoi" "atol" "bsearch" "calloc" "div" "exit" "free" "getenv"
    "labs" "ldiv" "malloc" "mblen" "mbstowcs" "mbtowc" "putenv" "qsort" "rand" "rand_r" "realloc"
    "srand" "strtod" "strtod32" "strtod64" "strtod128" "strtof" "strtol" "strtold" "strtoul"
    "system" "wcstombs" "wctomb")
  (#has-ancestor? @function.builtin program_c_stdlib_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "memchr" "memcmp" "memcpy" "memmove" "memset" "strcat" "strchr" "strcmp" "strcoll" "strcpy"
    "strcspn" "strerror" "strlen" "strncat" "strncmp" "strncpy" "strpbrk" "strrchr" "strspn"
    "strstr" "strtok" "strtok_r" "strxfrm")
  (#has-ancestor? @function.builtin program_c_string_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin "strcasecmp" "strncasecmp")
  (#has-ancestor? @function.builtin program_c_strings_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "asctime" "asctime_r" "clock" "ctime" "ctime64" "ctime_r" "ctime64_r" "difftime" "difftime64"
    "gmtime" "gmtime64" "gmtime_r" "gmtime64_r" "localtime" "localtime64" "localtime_r"
    "localtime64_r" "mktime" "mktime64" "strftime" "strptime4" "time" "time64")
  (#has-ancestor? @function.builtin program_c_time_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "btowc" "fgetwc6" "fgetws6" "fputwc6" "fputws6" "fwide6" "fwprintf6" "fwscanf6" "getwc6"
    "getwchar6" "mbrlen4" "mbrtowc4" "mbsinit4" "mbsrtowcs4" "putwc6" "putwchar6" "strfmon4"
    "swprintf" "swscanf" "ungetwc6" "vfwprintf6" "vswprintf" "vswscanf" "vwprintf6" "vwscanf"
    "wcrtomb4" "wcscat" "wcschr" "wcscmp" "wcscoll4" "wcscpy" "wcscspn" "wcsftime" "wcslen"
    "wcsncat" "wcsncmp" "wcsncpy" "wcspbrk" "wcsptime" "wcsrchr" "wcsrtombs4" "wcsspn" "wcsstr"
    "wcstod" "wcstod32" "wcstod64" "wcstod128" "wcstof" "wcstok" "wcstol" "wcstold" "wcstoul"
    "wcsxfrm4" "wctob" "wctype4" "wcwidth" "wmemchr" "wmemcmp" "wmemcpy" "wmemmove" "wmemset"
    "wprintf6" "wscanf6")
  (#has-ancestor? @function.builtin program_c_wchar_h))

((identifier) @function.builtin
  (#set! priority 105)
  (#any-of? @function.builtin
    "iswalnum4" "iswalpha4" "iswblank4" "iswcntrl4" "iswctype4" "iswdigit4" "iswgraph4" "iswlower4"
    "iswprint4" "iswpunct4" "iswspace4" "iswupper4" "iswxdigit4" "isxdigit4" "towctrans" "towlower4"
    "towupper4" "wctrans")
  (#has-ancestor? @function.builtin program_c_wctype_h))
