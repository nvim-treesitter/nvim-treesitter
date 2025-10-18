import re

re_test = re.compile(r"^(?P<year>\d{4}) (?P<day>\d) \w\s{,3}$")
#                                    ^ @string.regexp
re_test = re.compile(
    r"^(?P<year>\d{4}) "
    # ^ @string.regexp
    r"(?P<day>\d) \w\s{,3}"
    # ^ @string.regexp
)
