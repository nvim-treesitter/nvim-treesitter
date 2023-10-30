; highlights.scm
; FIX: "tc" "fc" "lc" highlight

(comment) @comment

(unary_expression
  _? @operator
  (_) @variable
  _? @operator)

(binary_expression
  (_) @variable
  _ @operator
  (_) @variable)

(ternary_expression
  condition: (_) @variable
  "?" @conditional.ternary
  true: (_) @variable
  ":" @conditional.ternary
  false: (_) @variable)

(func_def (function) "=" @operator)
(var_def var: (identifier) "=" @operator)
(array_def "array"
           [
            ((array) ("=" @operator)?)
            ((identifier) "[" (_) "]" "=" @operator)
            ])

(sum_block "sum" @repeat)

(for_block "for" @repeat "in"? @repeat)

(c_clear) @keyword

(c_do "do" @repeat (for_block))

(c_eval "evaluate" @keyword (_))

(c_fit
  "fit" @keyword
  (range_block)*
  (_)+
  "via" @keyword)

(c_help "help" @keyword)

(c_if
  "if" @conditional
  (parenthesized_expression)
  [
   (_)+
   ("{" (_)* "}"
   ("else" @conditional "if" @conditional (parenthesized_expression)+ "{" (_)* "}")*
   ("else" @conditional "{" (_)* "}"))
   ]
  )

(c_load "load" @keyword (_))

(c_lower "lower" @keyword)

(c_pause "pause" @keyword "mouse" @field _? @attribute ("," _ @attribute)?)

(c_plot
  "plot" @keyword
  "sample"? @keyword)

(plot_element
  (range_block)*
  (for_block)?
  [
   ("axes" ["x1y1" "x2y2" "x1y2" "x2y1"] @attribute)
   ("title" title: (_))
   ("notitle" title: (_)?)
   "nogrid" ; NOTE: splot only option
   ("with" with: (plot_style) (style_opts)?)
   ]* @field)

(datafile_modifiers
  [
   "binary" ; TODO: complete
   matrix: (["nonuniform" "sparce"]? "matrix" @attribute) ; TODO: complete
   ("skip" N_lines: (_))
   ("smooth" (smooth_options)?)
   ; TODO: add bins
   "mask" "convexhull" "volatile" "zsort"
   ]* @attribute
  [
   index: ("index" m: (_) (":" n: (_))? (":" p: (_))?)
   ("every" point_incr: (_)? (":" block_incr: (_)?)? (":" start_point: (_)?)? (":" start_block: (_)?)? (":" end_point: (_)?)? (":" end_block: (_)?)? )
   using: ("using" (_) (":" (_))*)
   ]* @field)

(smooth_options) @property

(c_print "print" @keyword)

(c_replot) @keyword

(c_reread) @keyword

(c_reset "reset" @keyword ["bind" "errors" "session"]? @attribute)

(c_set "cmd" @keyword (for_block)? "arg" @field)

(angles) @attribute
(arrow
  tag: (_)?
  [
   (("from" (position))? "to_rto" @attribute (position))
   ("from" (position) "length" length: (_) "angle" angle: (_))
   ]* @attribute)
(autoscale ["axes" "fix" "keepfix" "noextend"] @attribute)
(border (_)? ["front" "back" "behind" (style_opts) "polar"]? @attribute)
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
   "default"
   ("origin" (position))
   ("size" (position))
   "fb"
   "noborder"
   "bdefault"
   ("border" (line_style))
   ("cbtics" (line_style))
   ]+ @attribute) ; TODO: complete
(contour) @attribute
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
   ("logfile" "default"? @property)
   "fit_out"
   "errorvariables"
   "covariancevariables"
   "errorscaling"
   "prescale"
   ("maxiter" "default"? @property)
   ("limit" "default"? @property)
   ("limit_abs" "default"? @property)
   ("start-lambda" "default"? @property)
   ("lambda-factor" "default"? @property)
   ("script" "default"? @property)
   "version"
   ]+ @attribute)
; (format "axes"? @attribute fmt_str: (_) _? @attribute) ; TODO: check
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
; (hystory) ; TODO: complete
(isosurface ["mixed" "triangles" "noinsidecolor" ("insidecolor" (_))] @attribute)
(jitter ["overlap" "spread" "wrap" "swarm" "square" "vertical"] @attribute)
(key
  [
   "on" "off"
   "default"
   "enhanced"
   ("a" "columnheader"? @property)
   "box"
   ("opaque"("fc" @property (colorspec))?)
   ("width" increment: (_))
   ("height" increment: (_))
   "layout"
   ("maxcols" ["auto"]?)
   ("maxrows" ["auto"]?)
   ("columns" )
   ("keywidth" ["screen" "graph"] )
   "lr"
   "reverse"
   ("samplen" length: (_))
   ("spacing" spacing: (_))
   ("title" "enhanced"? @attribute(position)? @attribute)
   (font_spec)
   ("tc" (colorspec))
   "placement"
   "margin"
   ("at" (position))
   "hor"
   "vert"
   ]+ @attribute)
(linetype "cycle" @attribute)
(link
  [
   "x2" "y2"
   ("via" (_) "inverse" @attribute (_))
   ] @attribute) ; NOTE: maybe change highlight
(logscale "axis" @attribute)
(mapping) @attribute
(margin
  [
   ("at" "screen" @attribute(_)) ; TODO: check if correct
   ("screen" @attribute(_))
   ("margins" lm: (_) "," rm: (_) "," bm: (_) "," tm: (_))
   ]? @attribute)
; (mouse) ; TODO: complete
(multiplot
  [
   ("title" title: (_) (font_spec)? "enhanced"? @property)
   ("layout" rows: (_) "," cols: (_))
   "rowsfirst" "columnsfirst"
   "downwards" "upwards"
   ("scale" xscale: (_) ("," yscale: (_))?)
   "offset"
   ("margins" lm: (_) "," rm: (_) "," bm: (_) "," tm: (_))
   ("spacing" xspacing: (_) ("," yspacing: (_))?)
   "pn"
   ]+ @attribute)
(mxtics
  [
   "default"
   ["seconds" "minutes" "hours" "days" "weeks" "months" "years"]
   ]* @attribute)
(palette
  [
   "gray" "color"
   ("gamma" gamma: (_))
   ("rgbformulae" r: (_) ("," g: (_))? ("," b: (_))?)
   ("defined" ("(" gray: (_) color: (_) ("," gray: (_) color: (_))* ")")?)
   ("file" filename: (_)(datafile_modifiers)?)
   ("colormap" colormap_name: (_))
   ("functions" R: (_) "," G: (_) "," B: (_))
   ("cubehelix" ("start" val: (_))? @property ("cycles" val: (_))? @property ("saturation" val: (_))? @property)
   "viridis"
   ("model" (["RGB" "CMY" ("HSV" ("start" radians: (_))? @attribute)])? @property )
   "pn"
   "nops_allcF" "ps_allcF"
   ("maxcolors" maxcolors: (_))
   ]+ @attribute)
(paxis
  [
   ("range" (range_block) ["reverse" "writeback" "extend" "restore"]* @property)
   ("tics" (tics_opts)?)
   ("label" label: (_)? (label_opts)?)
   ("offset" offset: (position))
   ]+ @attribute)
; (pixmap)
(pm3d
  [
   ("at" (position))
   ("interpolate" steps: (_) "," between: (_))
   "scanorder" ("depthorder" "base"? @property) "hidden3d"
   ("flush" ["begin""center""end"] @property)
   "ftriangles"
   ("clip" "z"? @property) "clip1in" "clip4in"
   "clipcb"
   ("corners2color" "c2c" @property)
   ("lighting" ("primary" fraction: (_))? @property ("specular" fraction: (_))? @property("spec2" fraction: (_))? @property )
   ("border" "retrace"? @property (style_opts)?)
   "implicit" "explicit"
   "map"
   ] @attribute)
(size
  [
   "square"
   "ratio"
   "noratio"
   ]+ @attribute)
(style
  [
   ("arrow" index:(_)? ["defaults" @attribute (arrow_opts)])
   ("boxplot") ; TODO: complete
   ("data" [(plot_style) "spiderplot" @attribute])
   ("fs" (fill_style))
   ("function" (plot_style))
   ("line" (line_style))
   ("circle") ; TODO: complete
   ("rectangle") ; TODO: complete
   ("ellipse") ; TODO: complete
   ("parallelaxis" "fb"? @attribute (style_opts)?)
   ; ((spiderplot)) ; TODO: complete
   ("textbox") ; TODO: complete
   ] @property )
(surface ["implicit" "explicit"] @attribute)
; (table)
(terminal ["name" "push" "pop"] @property)
(t_cairolatex
  [
   "eps" "pdf" "png" "standalone" "input" "blacktext" "colortext" "colourtext" ("header"(_)) "mono" "color"
   ("background" (_)) (font_spec) ("fontscale" (_)) "rounded" "butt" "square"
   ]* @attribute )
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

(canvas_size "size" @attribute
             x:((_) ["cm" "in"]? @property)
             ","
             y:((_) ["cm" "in"]? @property))

(font_spec "font" @attribute)

(termoption
  [
   "enhanced" @attribute
   (font_spec)
   ("fontscale" @attribute (_))
   ("lw" @field (_))
   ])
(theta) @attribute
; (timestamp)
(title title: (_)?
  [
   offset: ("offset" (position))
   (font_spec)
   ("tc" [(colorspec) ("lt" @field (_))])
   "enhanced"
   ]+ @attribute)
(vgrid ("size" @attribute (_))?)
(view
  [
   ("map" "scale"?)
   ("projection" ["xy" "xz" "yz"]? @property)
   ("equal" ["xy" "xyz"]? @property)
   ("azimuth")
   ]+ @attribute)
(walls
  [
   "wall" @attribute
   ("fs" @field (fill_style))
   ("fc" @field (colorspec))
   ]+)
(xdata) @attribute
(xlabel
  label: (_)?
  [
   ("offset" (position))
   ("rotate" [("by" angle: (_)) "parallel"]? @attribute)
   ("tc" [(colorspec) ("lt" @field (_))])
   (font_spec)
   "enhanced"
   ]+ @attribute)
(xrange ["reverse" "writeback" "extend" "restore"]+ @attribute)
(xyplane [("at" zval: (_))("relative" val: (_))]? @attribute)

(c_show "show" @keyword); TODO: complete

(c_splot "splot" @keyword "sample"? @keyword (range_block)* (plot_element) ("," (plot_element))*)

(c_stats
  "stats" @keyword
  (range_block)*
  filename: (_)
  [
   "matrix"? @field
   [
    index: ("index" m: (_) (":" n: (_))? (":" p: (_))?)
    ("every" point_incr: (_)? (":" block_incr: (_)?)? (":" start_point: (_)?)? (":" start_block: (_)?)? (":" end_point: (_)?)? (":" end_block: (_)?)? )
    using: ("using" (_) (":" (_))*)
    "zsort"
    ]* @field]
  [
   (["name" "prefix"] @field (_))
   "output" @field
   ; ("vgridname" ("name" (name))?)
   ]*)

(c_test)

(c_undefine)

(c_vfill "vfill" @keyword "sample"? @field)

(c_while "while" @repeat (parenthesized_expression) "{" _* "}" )

(plot_style
  ["lines" "points" "lp" "financebars" "dots" "impulses"
   ("labels" (label_opts)*)
   "surface" "steps" "fsteps" "histeps" "arrows"
   ("vectors"(arrow_opts)*)
   "sectors" "contourfill" "errorbar" "errorlines" "parallelaxes" "boxes" "boxerrorbars"
   "boxxyerror" "isosurface" "boxplot" "candlesticks" "circles" "zerrorfill"
   "ellipses"
   ("filledcurves"
    [
     "closed"
     "between"
     (["above" "below"]? @property ["x1""x2""y1""y2""y""r"]? @attribute) ; FIX: above below highlight
     ]? @property)
   ("fillsteps" ["above" "below"]? @property ("y" "=" @operator (_))?)
   "histograms" ("image" "pixels"? @property)
   ("pm3d" (pm3d)?) "rgbalpha" "rgbimage" "polygons" "table" "mask"
   ] @attribute)

(fill_style
  [
   "empty"
   "solid"
   ("transparent"? "solid" @attribute density: (_)?)
   ("pattern" n: (_)?)
   ("transparent"? "pattern" @attribute n: (_)?)
   ("border" [("lt"? @field (_)) ("lc" @field [(_) (colorspec)])]?)
  ] @attribute)

(line_style
  [
   "default"
   ("lt" [(_) (colorspec) "black" "bgnd" "nodraw"] @attribute)
   ("lw" (_))
   ("lc" [(_) (colorspec)])
   "dt"
   "pt"
   "ps"
   "pi"
   "pn"
   "palette"]@field)

(colorspec
  [
   ("rgbcolor" [(_) "variable" @property])
   ("palette"
    [
     ("frac" @property val: (_))
     ("cb" @property val: (_))
     "z" @property]?)
    "variable"
    "bgnd"
    "black"] @attribute)

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
   ("scale" ["default" ((_) ("," (_))?)]?)
   ("rotate" "by" @attribute angle: (_))
   "norotate"
   [("offset" (position)) "nooffset"]
   "align"
   "add"
   "autofreq"
   "format"
   "enhanced"
   ("format" (_))
   "log"
   "rangelimited"
   ("tc" [(colorspec) ("lt" (_))])
   ]+ @attribute)

(label_opts
  [
   "norotate"@attribute
   ("rotate" @attribute("by" @attribute degrees: (_))?)
   "enhanced"@attribute
   "fb"@attribute
   ("tc" @field [(colorspec) (["lt" "ls"] @field (_))])
   ("offset" @attribute(position))
   "align"@attribute
   ("at" @attribute (position))
   "nopoint"@attribute
   "point"@attribute
   "boxed"@attribute
   "nobox"@attribute
   "hypertext"@attribute
   ])

(style_opts
  [
   ("ls" (_))
   ("lt" [(_) (colorspec) "black"@attribute "bgnd"@attribute "nodraw"@attribute])
   ("lw" (_))
   ("lc" [(_) (colorspec)])
   "dt"
   "pt"
   ("ps" [(_) "variable" @attribute])
   "pi"
   "pn"
   ("as" (_))
   ("fs" (fill_style))
   ("fc" [(_) ("lt" @field (_)) ("ls" @field (_))])
   "nohidden3d"
   "nocontours"
   ; "nosurface"
   "palette"
   ]+ @field)

(system) @attribute

(macro) @function.macro
(datablock) @function.macro

(function name: (identifier) @function)
((function name: (identifier) @function.builtin)
 (#match? @function.builtin
  "^(abs|acos|acosh|airy|arg|asin|asinh|atan|atan2|atanh|besj0|besj1|besjn|besy0|besy1|besyn|besi0|besi1|besin|cbrt|ceil|conj|cos|cosh|EllipticK|EllipticE|EllipticPi|erf|erfc|exp|expint|floor|gamma|ibeta|inverf|igamma|imag|int|invnorm|invibeta|invigamma|LambertW|lambertw|lgamma|lnGamma|log|log10|norm|rand|real|round|sgn|sin|sinh|sqrt|SynchrotronF|tan|tanh|uigamma|voigt|zeta|cerf|cdawson|faddeva|erfi|FresnelC|FresnelS|VP|VP_fwhm|Ai|Bi|BesselH1|BesselH2|BesselJ|BesselY|BesselI|BesselK|gprintf|sprintf|strlen|strstrt|substr|strptime|srtftime|system|trim|word|words|time|timecolumn|tm_hour|tm_mday|tm_min|tm_mon|tm_sec|tm_wday|tm_week|tm_yday|tm_year|weekday_iso|weekday_cdc|column|columnhead|exists|hsv2rgb|index|palette|rgbcolor|stringcolumn|valid|value|voxel)$"))

((identifier) @variable.builtin
  (#match? @variable.builtin
   "^\\w+_(records|headers|outofrange|invalid|blank|blocks|columns|column_header|index_(min|max)(_x|_y)?|(min|max)(_x|_y)?|mean(_err)?(_x|_y)?|stddev(_err)?(_x|_y)?)$"))
((identifier)@variable.builtin
  (#match? @variable.builtin
   "^\\w+_(sdd(_x|_y)?|(lo|up)_quartile(_x|_y)?|median(_x|_y)?|sum(sq)?(_x|_y)?|skewness(_err)?(_x|_y)?)$"))
((identifier) @variable.builtin
  (#match? @variable.builtin
   "^\\w+_(kurtosis(_err)?(_x|_y)?|adev(_x|_y)?|correlation|slope(_err)?|intercept(_err)?|sumxy|pos(_min|_max)_y|size(_x|_y))$"))

((identifier) @variable.builtin
  (#match? @variable.builtin "^((GPVAL|MOUSE|FIT)_\\w+|GNUTERM|NaN|VoxelDistance|GridDistance|pi)$"))

(array_def "array" @keyword.function (array))
(array (identifier) @function "[" (_) "]")

(number) @number

(string_literal) @string
