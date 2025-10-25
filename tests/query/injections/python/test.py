import re

re_test = re.compile(r"^(?P<year>\d{4}) (?P<day>\d) \w\s{,3}$")
#                                    ^ @regex
re_test = re.compile(
    # comment
    # ^ @comment
    r"^(?P<year>\d{4}) "
    # comment
    # ^ @comment
    r"(?P<day>\d) \w\s{,3}$"
    # ^ @regex
    # comment
    # comment
    # ^ @comment
)
print("foo %s bar %d" % ("arg1", 2))
#          ^ @printf
