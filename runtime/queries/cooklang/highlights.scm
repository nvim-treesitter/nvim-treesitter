(metadata) @comment

(ingredient
  "@" @tag
  (name)? @markup.heading
  (amount
    (quantity)? @number
    (units)? @tag.attribute)?)

(timer
  "~" @tag
  (name)? @markup.heading
  (amount
    (quantity)? @number
    (units)? @tag.attribute)?)

(cookware
  "#" @tag
  (name)? @markup.heading
  (amount
    (quantity)? @number
    (units)? @tag.attribute)?)
