"""A docstring."""
#  ^ @string.documentation

"""I am not a docstring."""
#  ^ @string

class Foo:
    """Class docstring.

    allows injection of comment. NOTE: Yeah!"""
#       ^ @string.documentation
#                                ^^^^ @text.note

    def bar(self):
        """Method docstring.          NOTE: injection"""
#          ^ @string.documentation
#                                     ^^^^ @text.note
#                                                   ^ @string.documentation


def baz():
    """Function docstring.           NOTE: injection"""
#      ^ @string.documentation
#                                    ^^^^ @text.note
#                                                  ^ @string.documentation
    pass
