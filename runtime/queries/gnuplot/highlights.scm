; highlights.scm
(comment) @comment @spell

"variable" @variable.parameter

; built-in named values (palette presets, special colour names).
; `bgnd` and `background` are gnuplot synonyms for the same colour; both are
; separate literals in the grammar, so both need naming here.
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

[
  "="
  ","
  ":"
  ; datablock heredoc (`$data << EOD`) and the left-shift operator share one
  ; token, so this capture covers both roles
  "<<"
] @operator

; open range end — `set xrange [*:*]`, `array A[*]`: a wildcard, not a product
"*" @character.special

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

; pseudo plot-elements: they fill an element slot but name no data source
[
  "newhistogram"
  "newspiderplot"
  "keyentry"
] @keyword

; connector words. `kw_fn` is the alias tier (at/via/from/to/by); `inverse`
; (set link) and `sample` (plot sample) read the same way in their clause.
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
  "zclip"
  "filled"
  "nofilled"
  ; coordinate systems (first/second/graph/screen/character/polar) — alias "coord"
  "coord"
] @keyword.directive

; on/off toggle flags ({no}X) — alias "flag"
"flag" @keyword.directive

; enumerated VALUES / modes (alias "mod")
"mod" @constant

; binary rotate= angle-unit suffixes (rotate=90deg / rotate=0.5 pi);
; the attached form 0.5pi folds into the number token instead
[
  "degrees"
  "pi"
] @constant

; plot/splot ELEMENT modifiers (alias "attr") — @property
; (title/notitle/with/using/index/every/axes/smooth in a plot command;
;  distinct from set-option names which are @variable.member)
"attr" @property

; -----------------------------------------------------------------------
[
  ; Terminal output path
  "name"
  ; Style attribute shorthands (K constants + datafile keywords)
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
  ; set/show/unset option heads (alias "opt") and option-body suboption
  ; keywords (alias "arg") — distinct clause families, same visual group
  "opt"
  "arg"
] @variable.member

; -----------------------------------------------------------------------
; Option keywords
[
  ; coordinate systems / axes
  "axes_opts"
  ; time units (set xdata time / timefmt)
  ; smooth subtypes still emitted as own token (value-modes csplines/bezier/… → "mod")
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
  "columnheaders"
  "rowheaders"
  "nonuniform"
  "sparse"
  "volatile"
  "noautoscale"
  "zsort"
  "mask"
  "sharpen"
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
  ; command-argument keywords (exit forms, pause mouse)
  ; the `pause` end conditions themselves are `mod` tier
  "message"
  "status"
  "mouse"
  ; history command options
  "append"
  "quiet"
  "numbers"
  "trim"
  "full"
  ; pixmap
  ; coordinate axis-family prefix (the coord systems first/second/graph/screen/
  ; character/polar are aliased to (coord) -> @keyword.directive below)
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
  ; orientation
  ; angle units
  ; contour / palette / axis
  "range"
  "missing"
  "interpolate"
  ; rotation
  "rotate"
  ; border / extend / range modifiers
  "restore"
  ; pm3d
  "scanorder"
  "position"
  ; histogram subtypes
  ; smooth additions
  ; key/label placement
  ; fill pattern
  "pattern"
  ; data / fit extras
  "variables"
  "datablocks"
  "commentschars"
  "functions"
  ; save changes
  "changes"
  ; misc
  ; coordinate planes / walls
  ; colorspec
  "rgbcolor"
  ; tics
  ; set size
  ; set fit
  "default"
  ; label / style
  ; set view
  "map"
  ; set theta direction
  ; palette model / presets / cubehelix options
  "model"
  ; pm3d / lighting
  "corners2color"
  "primary"
  "specular"
  "spec2"
  "rot_x"
  "rot_z"
  "Phong"
  ; dgrid3d subtype (gauss/… value-modes → "mod")
  ; contour / cntrparam
  ; tics axes / modifiers
  ; text / font / encoding
  ; fill / size style
  "empty"
  ; layout / spacing / multiplot
  "layout"
  "spacing"
  "frac"
  ; watch-label / surface options
  "point"
  ; tics keyword (grid / paxis — covers xtics, ytics, ztics contexts)
  "tics"
  ; histogram fill style
  ; jitter options
  ; key command options
  ; paxis label keyword (key("label",3) with default aka="label")
  "label"
  ; polar coordinate system and grid option
  ; polar grid axis ranges
  ; ellipses style
  "units"
  ; stats output prefix
  "prefix"
  ; palette formula option
  ; grid mode
  ; datafile option
  ; textbox / multiplot margins (anonymous "margins" string)
  "margins"
  ; datafile lc/fc palette shorthand
  "palette"
  ; set fit quiet / results / verbose / brief
] @variable.member

; -----------------------------------------------------------------------
; Presentation / style attributes
[
  "size"
  "monochrome"
  "color"
  "transparent"
  ; palette colour models (set palette model)
  "RGB"
  "CMY"
  "HSV"
  "nobackground"
  "separator"
  (hull)
  "units_opt"
  ; fill / line style modes
  "solid"
  ; page orientation
  ; terminal options
  "animate"
  "input"
  ; point type names (ps/tikz terminals)
  ; key alignment (capitalised)
  ; layer / style misc
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
  name: (identifier) @function.call)

(def_func
  .
  (function
    name: (identifier) @function))

((function
  name: (identifier) @function.builtin)
  (#any-of? @function.builtin
    ; real / complex math
    "abs" "acos" "acosh" "airy" "arg" "asin" "asinh" "atan" "atan2" "atanh" "besj0" "besj1" "besjn"
    "besy0" "besy1" "besyn" "besi0" "besi1" "besin" "cbrt" "ceil" "conj" "cos" "cosh" "exp" "floor"
    "imag" "int" "log" "log10" "norm" "rand" "real" "round" "sgn" "sin" "sinh" "sqrt" "tan" "tanh"
    ; special functions
    "EllipticK" "EllipticE" "EllipticPi" "erf" "erfc" "expint" "gamma" "ibeta" "igamma" "inverf"
    "invibeta" "invigamma" "invnorm" "LambertW" "lgamma" "lnGamma" "SynchrotronF" "uigamma" "voigt"
    "zeta"
    ; libcerf
    "cerf" "cdawson" "faddeeva" "erfi" "FresnelC" "FresnelS" "VP" "VP_fwhm"
    ; libamos — complex Airy / Bessel
    "Ai" "Bi" "BesselH1" "BesselH2" "BesselJ" "BesselY" "BesselI" "BesselK"
    ; strings
    "gprintf" "sprintf" "strlen" "strstrt" "substr" "split" "join" "trim" "word" "words" "system"
    ; arrays
    "index"
    ; time
    "time" "timecolumn" "strftime" "strptime" "tm_hour" "tm_mday" "tm_min" "tm_mon" "tm_sec"
    "tm_wday" "tm_week" "tm_yday" "tm_year" "weekdate_iso" "weekdate_cdc"
    ; using-specifier / plotting
    "column" "columnhead" "stringcolumn" "strcol" "exists" "valid" "value" "hsv2rgb" "palette"
    "rgbcolor" "voxel"))

; bare `title columnheader` (the called form `columnheader(N)` is a (function)
; and matches the builtin list above)
(columnheader) @function.builtin

; -----------------------------------------------------------------------
; Built-in constants
((identifier) @constant.builtin
  (#any-of? @constant.builtin "pi" "NaN" "Inf"))

; -----------------------------------------------------------------------
; Built-in variables (stats output, GPVAL_*, ARG*, vfill loop vars)
((identifier) @variable.builtin
  (#match? @variable.builtin "^\\w+_(mean|stddev|skewness|kurtosis)(_err)?(_x|_y)?$"))

; stats: distribution summaries (+_x/_y)
((identifier) @variable.builtin
  (#match? @variable.builtin "^\\w+_(min|max|sdd|adev|median|sum(sq)?|(lo|up)_quartile)(_x|_y)?$"))

; stats: regression, extents, counts, column metadata
((identifier) @variable.builtin
  (#match? @variable.builtin
    "^\\w+_((slope|intercept)(_err)?|size(_x|_y)|column(s|_header)|records|headers|outofrange|invalid|blank|blocks|correlation|sumxy)$"))

; GPVAL_* / MOUSE_* / FIT_* / ARG*
((identifier) @variable.builtin
  (#match? @variable.builtin "^((GPVAL|MOUSE|FIT)_|ARG)\\w+$"))

; fixed-name built-ins — plain string comparison, never reaches a regex engine
((identifier) @variable.builtin
  (#any-of? @variable.builtin "GNUTERM" "VoxelDistance" "GridDistance"))

; -----------------------------------------------------------------------
; Array definitions
(def_array
  "array" @keyword.function)

(array
  (identifier) @function)

; -----------------------------------------------------------------------
; Literals
"NaN" @constant.builtin

(number) @number

(string_literal) @string

(escape_sequence) @string.escape

(format_specifier) @string.special

; watchpoint target (`watch y=50`): the axis/expression name being watched
(plot_element
  target: (identifier) @variable.member)
