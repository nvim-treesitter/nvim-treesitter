def func() -> None: ...

_ = func()
#   ^^^^ @function.call

"{}".format(1)
#    ^^^^^^ @function.method.call

class Foo:
    def method(self) -> None: ...

Foo().method()
#     ^^^^^^ @function.method.call
