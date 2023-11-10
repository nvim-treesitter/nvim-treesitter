; highlights.scm

(comment) @comment @spell

(identifier) @variable

(unary_expression
  _? @operator
  (_)
  _? @operator)

(binary_expression
  (_)
  _ @operator
  (_))

(ternary_expression
  condition: (_)
  "?" @conditional.ternary
  true: (_)
  ":" @conditional.ternary
  false: (_))

"=" @operator

"sum" @function.builtin

[
 "for"
 "in"
 "do"
 "while"
 ] @repeat

(c_break) @keyword

(c_cd) @keyword

(c_clear) @keyword

(c_eval "evaluate" @keyword (_))

[
 "fit"
 "via"
 "inverse"
 ] @keyword

(c_help "help" @keyword)

[
 "if"
 "else"
 ] @conditional

(c_load "load" @keyword)

(c_lower "lower" @keyword)

(c_pause "pause" @keyword "mouse" @field _? @attribute ("," _ @attribute)?)

(c_plot "plot" @keyword "sample"? @keyword)

(plot_element "axes"? @field)

(datafile_modifiers
  [
   "binary" ; TODO: complete
   ("skip" (_))
   ; TODO: add bins
   ]* @attribute)

(smooth_options) @property

(c_print "print" @keyword)

(c_replot) @keyword

(c_reread) @keyword

(c_reset "reset" @keyword)

(c_set "cmd" @keyword)

(angles) @attribute
(colorsequence) @attribute
(clip) @attribute
(cntrparam "auto"? @property)
(contour) @attribute
(contourfill ("auto" (_)) @field)
(encoding) @attribute
; (errorbars)
(format _? @attribute (_) _? @attribute)
; (hystory)
(key "auto"? @property)
(mapping) @attribute
; (mouse) ; TODO: complete
; (pixmap)
(pm3d "clip" "z"? @property)
(style ; TODO: complete
  [
   "arrow"
   "boxplot"
   ("data" [(_) "spiderplot" @attribute])
   "fs"
   "function"
   "line"
   "circle"
   "rectangle"
   "ellipse"
   "parallelaxis"
   ; (spiderplot) ; TODO: complete
   "textbox"
   ("watchpoint" "labels" @attribute (_)?)
   ] @property)
; (table)
(terminal "name" @property)
; TODO: complete terminals in grammar and then simplify its options here
(t_cairolatex
  [
   "eps" "pdf" "png" "standalone" "input" "blacktext" "colortext" "colourtext" ("header"(_)) "mono" "color"
   "background" "rounded" "butt"
   ]* @attribute)
; (t_canvas)
; (t_cgm)
; (t_context)
; (t_domterm)
; (t_dumb)
; (t_dxf)
; (t_emf)
; (t_epscairo)
; (t_epslatex)
; (t_fig)
; (t_gif)
; (t_hpgl)
; (t_jpeg)
; (t_lua)
; (t_pc15)
; (t_pdfcairo)
; (t_png)
; (t_pngcairo)
; (t_postscript)
; (t_pslatex)
; (t_pstricks)
; (t_qt)
; (t_sixelgd)
; (t_svg [(font_spec)]* @attribute)
; (t_tek4xxx)
; (t_texdraw)
; (t_tikz)
; (t_tkcanvas)

(theta) @attribute
; (timestamp)
(walls "wall" @attribute)
(xdata) @attribute

(c_show "show" @keyword "plot"? @attribute)

(c_splot "splot" @keyword "sample"? @keyword)

(c_stats "stats" @keyword ("name" (_))? @field)

(c_test "test" @keyword)

(c_undefine "undefine" @keyword)

(c_vfill "vfill" @keyword "sample"? @field)

(plot_style
  [
   "lines" "points" "lp" "financebars" "dots" "impulses" "labels"
   "surface" "steps" "fsteps" "histeps" "arrows" "vectors"
   "sectors" "contourfill" "errorbar" "errorlines" "parallelaxes" "boxes" "boxerrorbars"
   "boxxyerror" "isosurface" "boxplot" "candlesticks" "circles" "zerrorfill"
   "ellipses" "filledcurves" "fillsteps" "histograms" "image"
   "pm3d" "rgbalpha" "rgbimage" "polygons" "table" "mask"
   ] @attribute)

[
 "tc" "fc" "fs" "lc" "ls" "lw" "lt" "pt" "ps" "pi" "pn" "dt" "as"
 "scale"
 "start" "cycles" "saturation" "interval" "format"
 "layout" "margins" "spacing"
 "keywidth" "samplen" "columns"
 "title" "notitle"
 "every" "index" "using" "with"
 "frac"
 "arg"
 "prefix" "output"
 "primary" "specular" "spec2"
 "firstlinetype"
 "width" "height"
 ] @field

[
 "on" "off" "opaque" "inside" "outside" "margin" "cen" "lef" "rig" "top" "bot" "lr" "a" "maxcols" "maxrows"
 "overlap" "spread" "wrap" "swarm"
 "range" "label"
 "mixed" "triangles" "insidecolor" "noinsidecolor"
 "cycle"
 "x1" "x2" "y1" "y2" "y" "r"
 "xy" "xz" "yz" "xyz"
 "x1y1" "x2y2" "x1y2" "x2y1"
 "tics" "ztics" "cbtics"
 "bdefault" "origin"
 "time"
 "palette"
 "terminal"
 "onecolor"
 "invert" "reverse" "writeback" "extend" "restore"
 "linear" "cubicspline" "bspline" "points" "order" "levels" "sorted"
 "autofreq" "add" "inout" "axis" "mirror" "type"
 "rowsfirst" "columnsfirst" "downwards" "upwards" "prevnext"
 "gray" "color" "gamma" "defined" "cubehelix" "model" "maxcolors" "file" "colormap" "rgbformulae" "viridis" "positive" "negative" "nops_allcF" "ps_allcF"
 "bind" "errors" "session"
 "behind" "polar" "layerdefault"
 "front" "back"
 "locale"
 "axes" "fix" "keepfix" "noextend"
 "head" "fixed" "filled" "nofilled"
 "absolute" "at" "relative"
 "enhanced"
 "mask" "convexhull" "concavehull" "volatile" "zsort"
 "smooth" "nonuniform" "sparce" "matrix"
 "border" "noborder"
 "rgbcolor" "empty" "black" "bgnd"
 "nodraw"
 "size"
 "new"
 "first" "second" "screen" "graph" "character"
 "trianglepattern" "undefined" "noundefined" "altdiagonal" "bentover"
 "vertical" "horizontal"
 "square" "ratio" "noratio"
 "solid" "transparent" "pattern"
 "from" "to_rto" "length" "angle"
 "columnheaders" "fortran" "nofpe_trap" "missing" "separator" "commentschars"
 "align"
 "log" "rangelimited"
 "offset" "nooffset"
 "font"
 "point" "nopoint" "boxed" "noboxed" "hypertext"
 "defaults"
 "keyentry"
 "splines" "qnorm" "gauss" "cauchy" "exp" "box" "hann"
 "implicit" "explicit"
 "rotate" "by" "parallel" "norotate"
 "map" "projection" "equal" "azimuth"
 "nohidden3d" "nocontours" "nosurface"
 "colornames" "functions" "variables" "version"
 "nologfile" "logfile" "fit_out" "errorvariables" "covariancevariables" "errorscaling" "prescale" "maxiter" "limit" "limit_abs" "start-lambda" "lambda-factor" "script" "clip"
 "fontscale"
 ] @attribute

[
 "columnheader"
 "seconds" "minutes" "hours" "days" "weeks" "months" "years"
 "cm" "in"
 "discrete" "incremental"
 "default"
 "long"
 "nogrid"
 "kdensity"
 "closed" "between" "above" "below"
 "variable"
 "pixels"
 "RGB" "CMY" "HSV"
 "base" "begin" "center" "end" "lighting" "interpolate" "scanorder" "depthorder" "hidden3d" "flush" "ftriangles" "clip1in" "clip4in" "clipcb" "corners2color" "c2c" "retrace"
 "whitespace" "tab" "comma"
 "push" "pop"
 ] @property

(colorspec [["cb" "z"] @field "palette" @attribute])

(macro) @function.macro
(datablock) @function.macro

(function name: (identifier) @function)
((function name: (identifier) @function.builtin)
 (#any-of? @function.builtin
  "abs""acos""acosh""airy""arg""asin""asinh""atan""atan2""atanh""besj0""besj1""besjn""besy0""besy1""besyn""besi0""besi1""besin""cbrt""ceil""conj""cos""cosh""EllipticK""EllipticE""EllipticPi""erf""erfc""exp""expint""floor""gamma""ibeta""inverf""igamma""imag""int""invnorm""invibeta""invigamma""LambertW""lambertw""lgamma""lnGamma""log""log10""norm""rand""real""round""sgn""sin""sinh""sqrt""SynchrotronF""tan""tanh""uigamma""voigt""zeta""cerf""cdawson""faddeva""erfi""FresnelC""FresnelS""VP""VP_fwhm""Ai""Bi""BesselH1""BesselH2""BesselJ""BesselY""BesselI""BesselK""gprintf""sprintf""strlen""strstrt""substr""strptime""srtftime""system""trim""word""words""time""timecolumn""tm_hour""tm_mday""tm_min""tm_mon""tm_sec""tm_wday""tm_week""tm_yday""tm_year""weekday_iso""weekday_cdc""column""columnhead""exists""hsv2rgb""index""palette""rgbcolor""stringcolumn""valid""value""voxel"))

((identifier) @variable.builtin
  (#match? @variable.builtin
   "^\\w+_(records|headers|outofrange|invalid|blank|blocks|columns|column_header|index_(min|max)(_x|_y)?|(min|max)(_x|_y)?|mean(_err)?(_x|_y)?|stddev(_err)?(_x|_y)?)$"))
((identifier) @variable.builtin
  (#match? @variable.builtin
   "^\\w+_(sdd(_x|_y)?|(lo|up)_quartile(_x|_y)?|median(_x|_y)?|sum(sq)?(_x|_y)?|skewness(_err)?(_x|_y)?)$"))
((identifier) @variable.builtin
  (#match? @variable.builtin
   "^\\w+_(kurtosis(_err)?(_x|_y)?|adev(_x|_y)?|correlation|slope(_err)?|intercept(_err)?|sumxy|pos(_min|_max)_y|size(_x|_y))$"))

((identifier) @variable.builtin
  (#match? @variable.builtin "^((GPVAL|MOUSE|FIT)_\\w+|GNUTERM|NaN|VoxelDistance|GridDistance|pi)$"))

(array_def "array" @keyword.function)
(array (identifier) @function)

(number) @number

(string_literal) @string
