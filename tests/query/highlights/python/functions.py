def func() -> None: ...

_ = func()
#   ^^^^ @function.call

"{}".format(1)
#    ^^^^^^ @function.method.call

class Foo:
    def method(self) -> None: ...
#              ^^^^ @variable.builtin

    @classmethod
    def clsmethod(cls) -> None: ...
#                 ^^^ @variable.builtin

Foo().method()
#     ^^^^^^ @function.method.call

print()
# ^ @function.builtin
