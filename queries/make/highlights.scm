;; Names
;; =====
(variable) @variable
(filename) @string
(library)  @string.special
(pattern
 . "%" @operator) @type

(function_expansion
  function: _ @function)

(text) @text
(quote) @string

;; Keywords
;; ========
[
  "include"
  "sinclude"
  "vpath"
] @include

[
  "private"
  "define"
  "undefine"
  "export"
  "unexport"
  "override"
] @keyword

[
  "ifeq"
  "ifneq"
  "ifdef"
  "ifndef"
  "else"
  "endif"
] @conditional

;; Punctuation
;; ===========
[
  "$"
  "$$"
] @punctuation.special

[
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

[
  "\""
  "'"
  ","
] @punctuation.delimiter

[
  ; rule separator
  ":"
  "::"
  "&:"
  "&::"
  "|"
  ";"
  ; assignment operator
  "="
  "?="
  "+="
  ":="
  "::="
  "!="
  ; special prefix
  "+" ; recurse
  "-" ; silent
  "@" ; noerror
] @operator

;; Override
;; --------
(directories                           ":"  @_clean @punctuation.delimiter)
(variable_reference     [ "(" ")" "{" "}" ] @_clean @punctuation.special)
(substitution_reference [ "(" ")" "{" "}" ] @_clean @punctuation.special)
(function_expansion     [ "(" ")" "{" "}" ] @_clean @punctuation.special)

;; Others
;; ------
(recipeprefix) @character

;; Variables
;; =========

;; Special assignment
;; ------------------
(variable_assignment
   name: ((variable) @_c (#eq? @_c ".RECIPEPREFIX"))
  value: (text) @character)

;; Naming convention
;; -----------------
((variable) @_clean @constant
   (#match? @_clean "^(LINT|COMPILE|LINK|PREPROCESS|OBJ|CHECKOUT)[.,]"))

((variable) @_clean @constant
   (#match? @_clean "FLAGS$"))

((variable) @_clean @constant
   (#match? @_clean "^CMAKE_"))

((variable) @constant
  (#any-of? @constant
      "INSTALL"
      "INSTALL_PROGRAM"
      "INSTALL_DATA"
      "DESTDIR"
      "prefix"
      "exec_prefix"
      "bindir"
      "sbindir"
      "libexecdir"
      "datarootdir"
      "datadir"
      "sysconfdir"
      "sharedstatedir"
      "localstatedir"
      "runstatedir"
      "includedir"
      "oldincludedir"
      "docdir"
      "infodir"
      "htmldir"
      "dvidir"
      "pdfdir"
      "psdir"
      "libdir"
      "lispdir"
      "localedir"
      "mandir"
      "man1dir"
      "man2dir"
      "manext"
      "man1ext"
      "man2ext"
      "srcdir"))

;; Special variables
;; -----------------
((variable) @_clean @constant.macro
  (#any-of? @_clean
      ;; automatic variables
      "@" "@D" "@F"
      "%" "%D" "%F"
      "*" "*D" "*F"
      "<" "<D" "<F"
      "?" "?D" "?F"
      "^" "^D" "^F"
      "+" "+D" "+F"
      "^" "|"  "_"
      ;;
      "VPATH"
      ;;
      ".DEFAULT_GOAL"
      ".RECIPEPREFIX"
      ".VARIABLES"
      ".FEATURES"
      ".INCLUDE_DIRS"
      ".EXTRA_PREREQS"
      ".LOADED"
      ".SHELLFLAGS"
      ".SHELLSTATUS"
      ".LIBPATTERNS"))

;; Built-ins variables
;; -------------------
((variable) @_clean @constant.builtin
  (#any-of? @_clean
      "VPATH"
      "CURDIR"
      "SUFFIXES"
      "SHELL"
      "MAKESHELL"
      "COMSPEC"
      "MAKE"
      "MAKE_COMMAND"
      "MAKE_VERSION"
      "MAKEFLAGS"
      "MAKEFILES"
      "MAKEFILE_LIST"
      "MAKE_HOST"
      "MAKE_RESTARTS"
      "MAKE_TERMOUT"
      "MAKE_TERMERR"
      "MAKELEVEL"
      "MAKELEVEL_NAME"
      "GNUMAKEFLAGS"
      "MAKECMDGOALS"
      "MAKEOVERRIDES"
      ;;
      "RM"
      "LD"
      ;; compilers
      "AR"
      "AS"
      "CO"
      "CC"
      "CPP"
      "CXX"
      "FC"
      "F77"
      "GET"
      "LEX"
      "LINT" 
      "M2C"
      "OBJC"
      "PC"
      "MAKEINFO"
      "TEX"
      "TEXI2DVI"
      "YACC" 
      "TANGLE"
      "CTANGLE"
      "WEAVE"
      "CWEAVE"
      ;;
      "LINK.c"
      "LINK.C"
      "LINK.cc"
      "LINK.cpp"
      "LINK.f"
      "LINK.F"
      "LINK.m"
      "LINK.o"
      "LINK.p"
      "LINK.r"
      "LINK.s"
      "LINK.S"
      ;; flags
      "ARFLAGS"
      "ASFLAGS"
      "CFLAGS"
      "COFLAGS"
      "CPPFLAGS"
      "CXXFLAGS"
      "DEFFLAGS"
      "F77FLAGS"
      "FFLAGS"
      "GFLAGS"
      "GNUMAKEFLAGS"
      "LDFLAGS"
      "LFLAGS"
      "LINTFLAGS"
      "M2FLAGS"
      "MAKEFLAGS"
      "MFLAGS"
      "MODFLAGS"
      "OBJCFLAGS"
      "PFLAGS"
      "RFLAGS"
      "YFLAGS"
      "TEXI2DVI_FLAGS"
      "MAKEINFO_FLAGS"
      ;;
      "OUTPUT_OPTION"
      "SCCS_OUTPUT_OPTION"
      ;;
      "COMPILE.c"
      "COMPILE.C"
      "COMPILE.cc"
      "COMPILE.cpp"
      "COMPILE.def"
      "COMPILE.f"
      "COMPILE.F"
      "COMPILE.m"
      "COMPILE.mod"
      "COMPILE.p"
      "COMPILE.r"
      "COMPILE.s"
      "COMPILE.S"
      "CHECKOUT,v"
      "YACC.y"
      "YACC.m"
      "LEX.l"
      "LEX.m"
      "LINT.c"
      ;;
      "PREPROCESS.S"
      "PREPROCESS.F"
      "PREPROCESS.r"
      ;;
      "LOADLIBES"
      "LDLIBS"
      ;;
      "TARGET_ARCH"
      "TARGET_MACH"))

;; Targets
;; =======

;; Naming convention
;; -----------------
(targets
  (filename) @_clean @symbol
   (#any-of? @_clean
      "all"
      "install"
      "install-html"
      "install-dvi"
      "install-pdf"
      "install-ps"
      "uninstall"
      "install-strip"
      "clean"
      "distclean"
      "mostlyclean"
      "maintainer-clean"
      "TAGS"
      "info"
      "dvi"
      "html"
      "pdf"
      "ps"
      "dist"
      "check"
      "installcheck"
      "installdirs"))


;; Special targets
;; ---------------
(targets
  (filename) @_clean @string.special
   (#any-of? @_clean
      ".SUFFIXES"
      ".PRECIOUS"
      ".LOW_RESOLUTION_TIME"
      ".PHONY"
      ".INTERMEDIATE"
      ".SECONDARY"
      ".EXPORT_ALL_VARIABLES"
      ".IGNORE"
      ".SILENT"
      ".NOTPARALLEL"
      ".DELETE_ON_ERROR"
      ".POSIX"
      ".SECONDEXPANSION"
      ".ONESHELL"
      ".DEFAULT"))

;; Functions
;; =========
(function_expansion
  function: (name) @_fn (#eq? @_fn "info")
            (arguments) @text.note)

(function_expansion
  function: (name) @_fn (#eq? @_fn "warning")
            (arguments) @text.warning)

(function_expansion
  function: (name) @_fn (#eq? @_fn "error")
            (arguments) @text.danger)

;; Others
;; =====
[
  (comment)
  (split)
] @comment

(ERROR) @error
