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

(c_fit
  "fit" @keyword
  (_)+
  "via" @keyword)

(c_help "help" @keyword)

[
 "if"
 "else"
 ] @conditional

(c_load "load" @keyword)

(c_lower "lower" @keyword)

(c_pause "pause" @keyword "mouse" @field _? @attribute ("," _ @attribute)?)

(c_plot
  "plot" @keyword
  "sample"? @keyword)

(plot_element
  [
   ("axes" ["x1y1" "x2y2" "x1y2" "x2y1"] @attribute)
   "nogrid" ; NOTE: splot only option
   ]* @field)

(datafile_modifiers
  [
   "binary" ; TODO: complete
   ; matrix: [["nonuniform" "sparce"]? "matrix"] @attribute; TODO: check
   ("skip" (_))
   "smooth"
   ; TODO: add bins
   "mask" "convexhull" "concavehull" "volatile" "zsort"
   ]* @attribute)

(smooth_options) @property

(c_print "print" @keyword)

(c_replot) @keyword

(c_reread) @keyword

(c_reset "reset" @keyword ["bind" "errors" "session"]? @attribute)

(c_set "cmd" @keyword "arg" @field)

(angles) @attribute
(arrow
  [
   ("from" "to_rto" @attribute)
   ("from" "length" @attribute "angle" @attribute)
   ]* @attribute)
(autoscale ["axes" "fix" "keepfix" "noextend"] @attribute)
(border ["front" "back" "behind" "polar"]? @attribute)
(boxwidth ["absolute" "relative"] @attribute)
(boxdepth "square" @attribute)
(colormap "new" @attribute)
(colorsequence) @attribute
(clip) @attribute
(cntrlabel ["format" "start" "interval" "onecolor"] @attribute)
(cntrparam
  [
   "linear" "cubicspline" "bspline" "points" "order"
   ("levels" ["auto" "discrete" "incremental"]? @property "sorted"? @attribute "firstlinetype"? @attribute)
   ]* @attribute)
(colorbox
  [
   "vertical"
   "horizontal"
   "invert"
   ("origin" (_))
   ("size" (_))
   "fb"
   "noborder"
   "bdefault"
   ("border" (_))
   ("cbtics" (_))
   ]+ @attribute)
(contour) @attribute
(contourfill
  [
   ("auto" (_))
   "ztics"
   "cbtics"
   "palette"
   ("firstlinetype" (_))
   ]+ @attribute)
(datafile
  [
   "columnheaders"
   "fortran"
   "nofpe_trap"
   "missing"
   ("separator" ["whitespace" "tab" "comma"] @property)
   "commentschars"
   ]? @attribute)
(decimalsign "locale" @attribute)
(dgrid3d [
          "splines" "qnorm"
          (["gauss" "cauchy" "exp" "box" "hann"] "kdensity"? @property)
          ]+ @attribute)
(encoding) @attribute
; (errorbars)
(fit
  [
   "nologfile"
   ("logfile" ["default" (_)])
   "fit_out"
   "errorvariables"
   "covariancevariables"
   "errorscaling"
   "prescale"
   ("maxiter" ["default" (_)])
   ("limit" ["default" (_)])
   ("limit_abs" ["default" (_)])
   ("start-lambda" ["default" (_)])
   ("lambda-factor" ["default" (_)])
   ("script" ["default" (_)])
   "version"
   ]+ @attribute)
(format _? @attribute (_) _? @attribute)
(grid
  [
   "tics"
   "polar"
   "layerdefault" "front" "back"
   "vertical"
   ]+ @attribute)
(hidden3d
  [
   "defaults"
   "fb"
   "offset"
   "trianglepattern"
   "undefined"
   "noundefined"
   "altdiagonal"
   "bentover"
   ]? @attribute)
; (hystory)
(isosurface ["mixed" "triangles" "noinsidecolor" ("insidecolor" (_))] @attribute)
(jitter ["overlap" "spread" "wrap" "swarm" "square" "vertical"] @attribute)
(key
  [
   "on" "off"
   ("a" "columnheader"? @property)
   "box"
   "opaque"
   ("width" (_))
   ("height" (_))
   "vertical"
   "horizontal"
   ("maxcols" ["auto"]?)
   ("maxrows" ["auto"]?)
   ("columns")
   ("keywidth" ["screen" "graph"])
   "lr"
   "reverse"
   ("samplen" (_))
   ("spacing" (_))
   "inside"
   "outside"
   "fixed"
   "margin"
   ("at" (_))
   "cen" "lef" "rig" "top" "bot"
   ]+ @attribute)
(linetype "cycle" @attribute)
(link
  [
   "x2" "y2"
   ("via" "inverse" @attribute)
   ] @attribute) ; TODO: check highlight
(logscale "axis" @attribute)
(mapping) @attribute
(margin
  [
   ("at" "screen" @attribute) ; TODO: check if correct
   "screen"
   "margins"
   ]? @attribute)
; (mouse) ; TODO: complete
(multiplot
  [
   ("layout" rows: (_) cols: (_))
   "rowsfirst" "columnsfirst"
   "downwards" "upwards"
   ("scale" (_))
   ("offset" (_))
   ("margins" lm: (_) rm: (_) bm: (_) tm: (_))
   ("spacing" (_))
   "prevnext"
   ]+ @attribute)
(mxtics
  [
   ("time" ["seconds" "minutes" "hours" "days" "weeks" "months" "years"] @property)
   ]* @attribute)
(palette
  [
   "gray"
   "color"
   ("gamma" (_))
   ("rgbformulae" (_) (_)? (_)?)
   ("defined" ("(" (_)+ "," (_)+ ")")?)
   "file"
   "colormap"
   ("functions" (_) (_) (_))
   ("cubehelix" [("start" (_)) ("cycles" (_)) ("saturation" (_))]? @property)
   "viridis"
   ("model" ["RGB" "CMY" ("HSV" ("start" (_))? @property)]? @property)
   "positive"
   "negative"
   "nops_allcF"
   "ps_allcF"
   ("maxcolors" (_))
   ]+ @attribute)
(paxis ; TODO: check
  [
   ("range" (_) ["reverse" "writeback" "extend" "restore"]* @property)
   ("tics" (_))
   ("label" (_) (_)?)
   ("offset" (_))
   ]+ @attribute)
; (pixmap)
(pm3d
  [
   ("at" (_))
   ("interpolate" steps: (_) "," between: (_))
   "scanorder" ("depthorder" "base"? @property) "hidden3d"
   ("flush" ["begin""center""end"] @property)
   "ftriangles"
   ("clip" "z"? @property) "clip1in" "clip4in"
   "clipcb"
   ("corners2color" "c2c" @property)
   ("lighting" [("primary" (_))? ("specular" (_))? ("spec2" (_))?] @property)
   ("border" "retrace"? @property)
   "implicit" "explicit"
   "map"
   ]+ @attribute)
(size
  [
   "square"
   "ratio"
   "noratio"
   ]+ @attribute)
(style
  [
   ("arrow" ["defaults" @attribute (_)])
   "boxplot"
   ("data" [(_) "spiderplot" @attribute])
   "fs"
   "function"
   "line"
   "circle"
   "rectangle"
   "ellipse"
   ("parallelaxis" "fb"? @attribute)
   ; (spiderplot) ; TODO: complete
   "textbox"
   ("watchpoint" "labels" @attribute (_)?)
   ] @property)
(surface ["implicit" "explicit"] @attribute)
; (table)
(terminal ["name" "push" "pop"] @property)
(t_cairolatex
  [
   "eps" "pdf" "png" "standalone" "input" "blacktext" "colortext" "colourtext" ("header"(_)) "mono" "color"
   "background" "fontscale" "rounded" "butt" "square"
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

(canvas_size
  "size" @attribute
  x:((_) ["cm" "in"]? @property)
  ","
  y:((_) ["cm" "in"]? @property))

(font_spec "font" @attribute)

(termoption "fontscale" @attribute)
(theta) @attribute
; (timestamp)
(title "offset" @attribute)
(vgrid ("size" @attribute)?)
(view
  [
   ("map" "scale"? @property)
   ("projection" ["xy" "xz" "yz"]? @property)
   ("equal" ["xy" "xyz"]? @property)
   "azimuth"
   ]+ @attribute)
(walls "wall" @attribute)
(xdata) @attribute
(xlabel
  [
   ("offset" (_))
   ("rotate" [("by" (_)) "parallel"]? @attribute)
   ]+ @attribute)
(xrange ["reverse" "writeback" "extend" "restore"]+ @attribute)
(xyplane ["at" "relative"]? @attribute)

(c_show "show" @keyword); TODO: complete

(c_splot "splot" @keyword "sample"? @keyword)

(c_stats
  "stats" @keyword
  "matrix"? @field
  [
   ("name" (_))
   "prefix"
   "output"
   ]* @field)

(c_test "test" @keyword ["palette" "terminal"]? @field)

(c_undefine "undefine" @keyword)

(c_vfill "vfill" @keyword "sample"? @field)

(plot_style
  [
   "lines" "points" "lp" "financebars" "dots" "impulses"
   "labels"
   "surface" "steps" "fsteps" "histeps" "arrows"
   "vectors"
   "sectors" "contourfill" "errorbar" "errorlines" "parallelaxes" "boxes" "boxerrorbars"
   "boxxyerror" "isosurface" "boxplot" "candlesticks" "circles" "zerrorfill"
   "ellipses"
   ("filledcurves"
    [
     "closed"
     "between"
     (["above" "below"]? ["x1""x2""y1""y2""y""r"] @attribute)
     ]? @property)
   ("fillsteps" ["above" "below"]? @property "y"? @attribute)
   "histograms" ("image" "pixels"? @property)
   "pm3d" "rgbalpha" "rgbimage" "polygons" "table" "mask"
   ] @attribute)

[
 "tc"
 "fc" "fs"
 "lc" "ls" "lw" "lt"
 "pt" "ps" "pi" "pn"
 "dt" "as"
 "title" "notitle"
 "every" "index" "using" "with"
 ] @field

[
 "enhanced"
 "matrix"
 "border"
 "black"
 "bgnd"
 "nodraw"
 "variable"
 ] @attribute

"default" @property

(fill_style
  [
   "empty"
   "solid"
   ("transparent"? "solid" @attribute)
   "pattern"
   ("transparent"? "pattern" @attribute)
   "border"
   ] @attribute)

(line_style ["palette"]? @field) ; TODO: check

(colorspec
  [
   ("rgbcolor" "variable"? @property)
   ("palette" ["frac" "cb" "z"]? @property)
   ] @attribute)

(arrow_opts
  [
   "head"
   "size"
   "fixed" "filled" "empty" "nofilled" "noborder" "front" "back"
   ]+ @attribute)

(dash_opts "solid" @attribute)

(tics_opts
  [
   "axis"
   "mirror"
   "inout"
   ("scale" ["default" ((_) (_)?)]?)
   ("rotate" "by" @attribute (_))
   "norotate"
   ("offset" (_))
   "nooffset"
   "align"
   "add"
   "autofreq"
   "format"
   ("format" (_))
   "log"
   "rangelimited"
   ]+ @attribute)

(label_opts
  [
   "norotate"
   ("rotate" "by"? @attribute (_))
   "fb"
   ("offset" (_))
   "align"
   ("at" (_))
   "nopoint"
   ("point" (_))
   "boxed"
   "noboxed"
   "hypertext"
   ]* @attribute)

(style_opts
  [
   "nohidden3d"
   "nocontours"
   "nosurface"
   "palette"
   ]+ @field)

(system) @attribute

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
