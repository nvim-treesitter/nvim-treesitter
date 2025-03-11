def func() -> None: ...

_ = func()
#   ^^^^ @function.call

class Foo:
    def method(self) -> None: ...

Foo().method()
#     ^^^^^^ @function.method.call
