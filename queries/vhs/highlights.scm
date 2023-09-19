[
  "Output"
  "Backspace"
  "Down"
  "Enter"
  "Escape"
  "Left"
  "Right"
  "Space"
  "Tab"
  "Up"
  "Set"
  "Type"
  "Sleep"
  "Hide"
  "Show" ] @keyword

[ "Shell"
  "FontFamily"
  "FontSize"
  "Framerate"
  "PlaybackSpeed"
  "Height"
  "LetterSpacing"
  "TypingSpeed"
  "LineHeight"
  "Padding"
  "Theme"
  "LoopOffset"
  "Width" ] @type

[ "@" ] @operator
(control) @function.macro
(float) @float
(integer) @number
(comment) @comment @spell
[(path) (string) (json)] @string
(time) @symbol

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
