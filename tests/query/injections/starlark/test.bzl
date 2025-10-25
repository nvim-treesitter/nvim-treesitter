# split
# ^ @comment
assert_eq('foo bar'.split(' '), ['foo', 'bar'])
assert_eq("foo %s bar %d" % ("arg1", 2), "foo arg1 bar 2")
#              ^ @printf
