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
  ","
  ":"
] @operator

; assignment = (anonymous; eventual grammar.js refactor will make it (operator))
"=" @operator

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
  "via"
  "inverse"
  "sample"
  "sum"
  "at"
  "from"
  "to_rto"
  "by"
  "smooth"
] @keyword.function

[
  "if"
  "else"
] @keyword.conditional

[
  "front"
  "back"
  "behind"
  "depthorder"
  "clip"
  "noclip"
  "opaque"
  "font"
  "filled"
  "nofilled"
  "parallel"
  "reverse"
  "invert"
  "extend"
] @keyword.directive

; -----------------------------------------------------------------------
; Terminal output path
"name" @variable.member

; -----------------------------------------------------------------------
; Style attribute shorthands (K constants + datafile keywords)
[
  "as"
  "dl"
  "dt"
  "fc"
  "fs"
  "lc"
  "ls"
  "lt"
  "lw"
  "pi"
  "pn"
  "ps"
  "pt"
  "tc"
  "skip"
  "every"
  "index"
  "using"
  "with"
  "expand"
] @variable.member

; set/show argument keywords (all key("...", n, "arg") aliases)
"arg" @variable.member

; -----------------------------------------------------------------------
; Option keywords
[
  ; coordinate systems / axes
  "unit"
  "units_opt"
  "plane"
  "viewaxis"
  "axes_opts"
  (columnheader)
  ; time units (set xdata time / timefmt)
  "seconds"
  "minutes"
  "hours"
  "days"
  "weeks"
  "months"
  "years"
  ; smooth subtypes
  "discrete"
  "incremental"
  "unique"
  "frequency"
  "fnormal"
  "cumulative"
  "cnormal"
  "csplines"
  "acsplines"
  "mcsplines"
  "bezier"
  "sbezier"
  "path"
  "kdensity"
  "bandwidth"
  "period"
  "closed"
  "between"
  "above"
  "below"
  "unwrap"
  "grid"
  ; plot / datafile misc
  "pixels"
  "whiskerbars"
  "beginning"
  "long"
  "nogrid"
  ; colorspace
  "RGB"
  "CMY"
  "HSV"
  ; positioning / key
  "base"
  "begin"
  "center"
  "end"
  "keywidth"
  "samplen"
  "columns"
  ; pm3d / 3d options
  "ftriangles"
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
  "dz"
  "width"
  "height"
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
  ; pixmap
  "colormap"
  ; coordinate system prefixes (position context)
  "first"
  "second"
  "graph"
  "screen"
  "character"
  "axis"
  ; position direction aliases
  "bot"
  "cen"
  "lef"
  "rig"
  "top"
  ; geometry / arrow options
  "angle"
  "radius"
  "length"
  "head"
  "inout"
  "polardistance"
  ; offset / scale
  "offset"
  "nooffset"
  "scale"
  "relative"
  "absolute"
  ; orientation
  "vertical"
  "horizontal"
  ; angle units
  "degrees"
  "radians"
  "radial"
  ; contour / palette / axis
  "levels"
  "range"
  "defined"
  "missing"
  "interpolate"
  "autofreq"
  "autojustify"
  "overlap"
  ; rotation
  "rotate"
  "norotate"
  ; border / extend / range modifiers
  "border"
  "noborder"
  "noextend"
  "writeback"
  "restore"
  ; pm3d scan order
  "scanorder"
  ; histogram subtypes
  "clustered"
  "rowstacked"
  "columnstacked"
  "mixed"
  "order"
  "nokeyseparators"
  ; smooth additions
  "bspline"
  "cubicspline"
  ; key/label placement
  "inside"
  "outside"
  ; fill pattern
  "pattern"
  ; 3d / surface
  "triangles"
  "surface"
  "nosurface"
  "s"
  ; data / fit extras
  "variables"
  "logfile"
  "nologfile"
  "datablocks"
  "commentschars"
  "functions"
  ; misc
  "both"
  "positive"
  "negative"
  "one"
  "two"
  "user"
  "sorted"
  "timedate"
  "maxrows"
  "maxcolors"
  ; axes aliases / coordinate planes / walls
  "xy"
  "wall"
  "version"
  ; colorspec
  "rgbcolor"
  ; tics
  "mirror"
  ; set size
  "equal"
  "ratio"
  ; set fit
  "covariancevariables"
  "errorvariables"
  "maxiter"
  "default"
  ; label / style
  "boxed"
  ; set view
  "azimuth"
  "map"
  "projection"
  ; set theta direction
  "theta_dir"
  ; palette model / presets / cubehelix options
  "cubehelix"
  "model"
  "start"
  "gamma"
  "cycles"
  "saturation"
  ; pm3d / lighting
  "corners2color"
  "lighting"
  "primary"
  "specular"
  "spec2"
  ; smooth / dgrid3d subtypes
  "gauss"
  "splines"
  ; contour / cntrparam
  "onecolor"
  "interval"
  "firstlinetype"
  ; tics axes / modifiers
  "ztics"
  "cbtics"
  "add"
  "rangelimited"
  ; text / font / encoding
  "fontscale"
  "utf8"
  "noboxed"
  ; fill / size style
  "empty"
  "square"
  ; layout / spacing / multiplot
  "layout"
  "spacing"
  "frac"
  ; color names in style contexts
  "cb"
  ; filledcurves axis coordinate (x1, x2, y1, y2 etc.)
  "coordinate"
  ; numeric format type
  "numeric"
  ; watch-label / surface options
  "point"
  "nohidden3d"
  ; tics keyword (grid / paxis — covers xtics, ytics, ztics contexts)
  "tics"
  ; histogram fill style
  "errorbars"
  ; jitter options
  "spread"
  "swarm"
  ; key command options
  "box"
  "auto"
  ; paxis label keyword (key("label",3) with default aka="label")
  ; watchpoint style subcommand (key("labels",-1) covers singular "label" too)
  "label"
  "labels"
  ; polar coordinate system and grid option
  "polar"
  ; polar grid axis ranges
  "theta"
  "r"
  ; ellipses style
  "units"
  ; stats output prefix
  "prefix"
  ; palette formula option
  "rgbformulae"
  ; pm3d z-clip
  "z"
  ; grid mode
  "spiderplot"
  ; binary filetype
  "png"
  ; datafile option
  "columnheaders"
  ; textbox / multiplot margins (anonymous "margins" string)
  "margins"
  ; datafile lc/fc palette shorthand
  "palette"
] @variable.member

; -----------------------------------------------------------------------
; Presentation / style attributes
[
  "size"
  "monochrome"
  "color"
  "transparent"
  "enhanced"
  "background"
  "nobackground"
  "separator"
  (hull)
  "title"
  "notitle"
  "rectangle"
  "circle"
  "ellipse"
  "polygon"
  ; fill / line style modes
  "solid"
  "dashed"
  "rounded"
  ; page orientation
  "landscape"
  "portrait"
  "eps"
  "pdf"
  ; terminal options
  "animate"
  "noanimate"
  "standalone"
  "input"
  "colortext"
  "blacktext"
  "duplex"
  ; point type names (ps/tikz terminals)
  "texpoints"
  "normalpoints"
  "mpoints"
  "smallpoints"
  "tinypoints"
  "pspoints"
  "nopspoints"
  ; text formatting
  "textnormal"
  "defaultplex"
  ; key alignment (capitalised)
  "Left"
  "Right"
  ; layer / style misc
  "layerdefault"
  "st_opt"
  "output"
] @attribute

"plt_st" @attribute

[
  (auto)
  (autotitle)
  (columnheader)
  (maxcols)
] @variable.member

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
