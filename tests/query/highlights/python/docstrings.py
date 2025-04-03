# Docstrings according to PEP 257 (https://peps.python.org/pep-0257/)
# <- @comment

"""Module docstring assigned to `__doc__`..."""
# <- @string.documentation
"""
... with an addtional docstring, not part of `__doc__`.
"""
# <- @string.documentation

"""
Some random docstring in the middle if nowhere...
"""
# <- @string.documentation
"""
... also with not one ...
"""
# <- @string.documentation
"""
... but two addtional docstrings.
"""
# <- @string.documentation

oneline_string_assignment = "not detected as docstring"
#                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^ @string
#                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^ !@string.documentation
"""Module attribute docstring."""
# <- @string.documentation

multiline_string_assignment = """
                              also not detected as docstring
                              """
#                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ @string
#                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ !@string.documentation

looks_like_implicit_string_concatenation = "abc"
#                                          ^^^^^ @string 
"def"
# <- @string.documentation

single_line_implicit_string_concatenation = "abc" "def"
#                                           ^^^^^ @string 
#                                                 ^^^^^ @string 
#                                                 ^^^^^ !@string.documentation 

multiline_implicit_string_concatenation = (
    "not "
    # <- @string
    # <- !@string.documentation
    "detected "
    # <- @string
    # <- !@string.documentation
    "as docstring, "
    # <- @string
    # <- !@string.documentation
    "either."
    # <- @string
    # <- !@string.documentation
)


class A:
    """
    Class docstring, assigned to `__doc__`.
    """
    # <- @string.documentation

    """
    Some random docstring again, ...
    """
    # <- @string.documentation
    """
    ... with an "additional" docstring. Again.
    """
    # <- @string.documentation

    foo = "class attribute"
    #     ^^^^^^^^^^^^^^^^^ @string
    #     ^^^^^^^^^^^^^^^^^ !@string.documentation
    """
    Class attribute docstring, but an attribute 
    does not have a `__doc__` attribute itself.
    """
    # <- @string.documentation

    bar: int
    """Class attribute docstring, type annotation only."""
    # <- @string.documentation

    baz: str = "type annotated class attribute"
    #          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ @string
    #          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ !@string.documentation
    """Class attribute docstring, type annotation and assignment."""
    # <- @string.documentation

    def __init__(self):
        """Method docstring."""
        # <- @string.documentation

        self.quux = "instance attribute"
        #           ^^^^^^^^^^^^^^^^^^^^ @string
        #           ^^^^^^^^^^^^^^^^^^^^ !@string.documentation
        """Instance attribute docstring."""
        # <- @string.documentation


def f(x):
    """Function docstring."""
    # <- @string.documentation
    """Addtional function docstring."""
    # <- @string.documentation
    return x**2


f.a = 1
"""Function attribute docstring."""
# <- @string.documentation


"Random docstring with single quotes - legal, but far off standard and confusing."
# <- @string.documentation
