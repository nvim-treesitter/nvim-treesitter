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
  (package_name)
  (module_name)
] @type

[
  "="
  ","
] @punctuation.delimiter

; Field values
(string_value) @string

(boolean_value) @constant.builtin

; Version numbers and ranges
(version_number) @number

(version_range_op) @operator

; Comments
(comment) @comment
