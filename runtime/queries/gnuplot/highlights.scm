(comment) @comment @spell

"variable" @variable.parameter

; built-in named values (palette presets, special color names)
[
  "viridis"
  "black"
  "bgnd"
  "background"
] @variable.parameter.builtin

(identifier) @variable

[
  "["
  "]"
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

(operator) @operator

; separators and range/assign operators (anonymous tokens)
[
  "="
  ","
  ":"
] @operator

(keyword_op) @keyword.operator

(ternary_op) @keyword.conditional.ternary

[
  "for"
  "in"
  "do"
  "while"
] @keyword.repeat

; -----------------------------------------------------------------------
; Commands
"cmd" @keyword

[
  "newhistogram"
  "newspiderplot"
  "keyentry"
] @keyword

[
  "inverse"
  "sample"
  "kw_fn"
] @keyword.function

"kw_cond" @keyword.conditional

[
  "front"
  "back"
  "depthorder"
  "clip"
  "font"
  "filled"
  "nofilled"
  "coord"
] @keyword.directive

; on/off toggle flags ({no}X) — alias "flag"
"flag" @keyword.modifier

; enumerated VALUES / modes (alias "mod")
"mod" @keyword.modifier

; plot/splot ELEMENT modifiers (alias "attr") — @property
; (title/notitle/with/using/index/every/axes/smooth in a plot command;
;  distinct from set-option names which are @variable.member)
"attr" @property

; -----------------------------------------------------------------------
; Terminal output path
"name" @variable.member

; -----------------------------------------------------------------------
; Style attribute shorthands (K constants + datafile keywords)
[
  "sa"
  "dt"
  "fc"
  "fs"
  "lc"
  "lt"
  "ps"
  "pt"
  "tc"
  "skip"
  "expand"
  "title"
] @variable.member

; set/show argument keywords (all key("...", n, "arg") aliases)
"arg" @variable.member

; -----------------------------------------------------------------------
; Option keywords
[
  ; coordinate systems / axes
  "units_opt"
  "axes_opts"
  (columnheader)
  ; smooth subtypes
  "closed"
  "between"
  "above"
  "below"
  ; plot / datafile misc
  "pixels"
  "whiskerbars"
  "beginning"
  "long"
  ; positioning / key
  "base"
  "begin"
  "center"
  "end"
  ; pm3d / 3d options
  "clip1in"
  "clip4in"
  "c2c"
  "retrace"
  ; data separators
  "whitespace"
  "tab"
  "comma"
  ; palette stack
  "push"
  "pop"
  ; flip binary axes
  "flipx"
  "flipy"
  "flipz"
  ; binary datafile modifiers
  "binary"
  "format"
  "filetype"
  "record"
  "array"
  "origin"
  "dx"
  "dy"
  "level"
  "matrix"
  "nonuniform"
  "sparse"
  "volatile"
  "noautoscale"
  "zsort"
  "mask"
  "transpose"
  ; endian options (binary)
  "endian"
  "little"
  "big"
  "swap"
  "swab"
  "middle"
  "pdp"
  ; fit modifiers
  "unitweights"
  "errors"
  ; pause endconditions
  "mouse"
  "keypress"
  "button1"
  "button2"
  "button3"
  "close"
  "any"
  ; history command options
  "append"
  "quiet"
  "numbers"
  "trim"
  "full"
  ; coordinate system prefixes (position context)
  "axis"
  ; position direction aliases
  "cen"
  "lef"
  "rig"
  ; geometry / arrow options
  "angle"
  "length"
  "head"
  ; offset / scale
  "offset"
  "scale"
  ; contour / palette / axis
  "range"
  "missing"
  "interpolate"
  ; rotation
  "rotate"
  ; border / extend / range modifiers
  "restore"
  ; pm3d scan order
  "scanorder"
  ; fill pattern
  "pattern"
  ; 3d / surface
  "s"
  ; data / fit extras
  "variables"
  "datablocks"
  "commentschars"
  "functions"
  ; colorspec
  "rgbcolor"
  ; set fit
  "default"
  ; set view
  "map"
  ; palette model / presets / cubehelix options
  "model"
  ; pm3d / lighting
  "corners2color"
  "primary"
  "specular"
  "spec2"
  ; smooth / dgrid3d subtypes
  ; tics axes / modifiers
  ; fill / size style
  "empty"
  ; layout / spacing / multiplot
  "layout"
  "spacing"
  "frac"
  ; color names in style contexts
  "cb"
  ; filledcurves axis coordinate (x1, x2, y1, y2 etc.)
  "coordinate"
  ; watch-label / surface options
  "point"
  ; tics keyword (grid / paxis — covers xtics, ytics, ztics contexts)
  "tics"
  ; paxis label keyword (key("label",3) with default aka="label")
  ; watchpoint style subcommand (key("labels",-1) covers singular "label" too)
  "label"
  ; ellipses style
  "units"
  ; stats output prefix
  "prefix"
  ; pm3d z-clip
  "z"
  ; textbox / multiplot margins (anonymous "margins" string)
  "margins"
  ; datafile lc/fc palette shorthand
  "palette"
] @variable.member

(columnheader) @variable.member

; -----------------------------------------------------------------------
; Presentation / style attributes
[
  "size"
  "monochrome"
  "color"
  "transparent"
  ; colorspace
  "RGB"
  "CMY"
  "HSV"
  "background"
  "nobackground"
  "separator"
  (hull)
  "units_opt"
  ; fill / line style modes
  "solid"
  ; terminal options
  "animate"
  "input"
  ; point type names (ps/tikz terminals)
  "st_opt"
  "plt_st"
] @attribute

; binary filetype= value (png/jpg/gif/bin parsed as identifier in field)
(binary_options
  filetype: (identifier) @attribute)

; -----------------------------------------------------------------------
; Macro / datablock identifiers
(macro) @function.macro

(datablock) @module

[
  (datablock_start)
  (datablock_end)
] @label

; -----------------------------------------------------------------------
; Functions
(function
  name: (identifier) @function)

((function
  name: (identifier) @function.builtin)
  (#any-of? @function.builtin
    "abs" "acos" "acosh" "airy" "arg" "asin" "asinh" "atan" "atan2" "atanh" "besj0" "besj1" "besjn"
    "besy0" "besy1" "besyn" "besi0" "besi1" "besin" "cbrt" "ceil" "conj" "cos" "cosh" "EllipticK"
    "EllipticE" "EllipticPi" "erf" "erfc" "exp" "expint" "floor" "gamma" "ibeta" "inverf" "igamma"
    "imag" "int" "invnorm" "invibeta" "invigamma" "LambertW" "lambertw" "lgamma" "lnGamma" "log"
    "log10" "norm" "rand" "real" "round" "sgn" "sin" "sinh" "sqrt" "SynchrotronF" "tan" "tanh"
    "uigamma" "voigt" "zeta" "cerf" "cdawson" "faddeva" "erfi" "FresnelC" "FresnelS" "VP" "VP_fwhm"
    "Ai" "Bi" "BesselH1" "BesselH2" "BesselJ" "BesselY" "BesselI" "BesselK" "gprintf" "sprintf"
    "strlen" "strstrt" "substr" "strptime" "srtftime" "system" "trim" "word" "words" "time"
    "timecolumn" "tm_hour" "tm_mday" "tm_min" "tm_mon" "tm_sec" "tm_wday" "tm_week" "tm_yday"
    "tm_year" "weekday_iso" "weekday_cdc" "column" "columnhead" "exists" "hsv2rgb" "index" "palette"
    "rgbcolor" "stringcolumn" "valid" "value" "voxel"))

; -----------------------------------------------------------------------
; Built-in variables (stats output, GPVAL_*, etc.)
((identifier) @variable.builtin
  (#match? @variable.builtin
    "^\\w+_(records|headers|outofrange|invalid|blank|blocks|columns|column_header|index_(min|max)(_x|_y)?|(min|max)(_x|_y)?|mean(_err)?(_x|_y)?|stddev(_err)?(_x|_y)?)$"))

((identifier) @variable.builtin
  (#match? @variable.builtin
    "^\\w+_(sdd(_x|_y)?|(lo|up)_quartile(_x|_y)?|median(_x|_y)?|sum(sq)?(_x|_y)?|skewness(_err)?(_x|_y)?)$"))

((identifier) @variable.builtin
  (#match? @variable.builtin
    "^\\w+_(kurtosis(_err)?(_x|_y)?|adev(_x|_y)?|correlation|slope(_err)?|intercept(_err)?|sumxy|pos_(min|max)_y|size(_x|_y))$"))

((identifier) @variable.builtin
  (#match? @variable.builtin
    "^((GPVAL|MOUSE|FIT)_\\w+|GNUTERM|NaN|VoxelDistance|GridDistance|pi|ARG\\w+)$"))

; -----------------------------------------------------------------------
; Array definitions
(def_array
  "array" @keyword.function)

(array
  (identifier) @function)

; -----------------------------------------------------------------------
; Literals
(number) @number

(string_literal) @string

(escape_sequence) @string.escape

(format_specifier) @string.special
