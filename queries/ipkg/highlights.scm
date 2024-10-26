; Keywords
[
  "package"
  "authors"
  "maintainers"
  "license"
  "brief"
  "readme"
  "homepage"
  "sourceloc"
  "bugtracker"
  "opts"
  "sourcedir"
  "builddir"
  "outputdir"
  "prebuild"
  "postbuild"
  "preinstall"
  "postinstall"
  "preclean"
  "postclean"
  "version"
  "langversion"
  "modules"
  "main"
  "executable"
  "depends"
] @keyword

[
  "="
  ","
] @punctuation.delimiter

; Field values
(string_value) @string

(boolean_value) @constant.builtin

; Version numbers and ranges
(version_number) @number

(version_range_op) @keyword.operator

; Comments
(comment) @comment
