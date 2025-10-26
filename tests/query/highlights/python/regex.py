import re

re_test = re.compile(r"^(?P<year>\d{4}) (?P<day>\d) \w\s{,3}$")
#                                    ^ @string.regexp
re_test = re.compile(
    # comment
    # ^ @comment
    r"^(?P<year>\d{4}){1}"
    # ^ @string.regexp
    # comment
    # ^ @comment
    r"(?P<day>\d) \w\s{,3}"
    # ^ @string.regexp
    # comment
    # ^ @comment
)
# interpolation
print("foo %s bar %d" % ("arg1", 2))
#          ^ @character
