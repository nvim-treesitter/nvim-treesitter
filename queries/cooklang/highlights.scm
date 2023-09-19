(metadata) @comment

(ingredient
  "@" @tag
  (name)? @text.title
	(amount
	  (quantity)? @number
		(units)? @tag.attribute)?)

(timer
  "~" @tag
  (name)? @text.title
	(amount
	  (quantity)? @number
		(units)? @tag.attribute)?)

(cookware
  "#" @tag
  (name)? @text.title
	(amount
	  (quantity)? @number
		(units)? @tag.attribute)?)

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
