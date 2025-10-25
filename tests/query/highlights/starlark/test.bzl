# split
# ^ @comment
assert_eq('foo bar'.split(' '), ['foo', 'bar'])
# ^ @keyword
#        ^ @punctuation.bracket
#          ^ @string
#                  ^ @punctuation.delimiter
assert_eq('foo bar foo'.rsplit(' ', 1), ['foo bar', 'foo'])
#                                   ^ @number
assert_eq("foo %s bar %d" % ("arg1", 2), "foo arg1 bar 2")
#              ^ @character
