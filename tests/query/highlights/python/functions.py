def func() -> None: ...

_ = func()
#   ^^^^ @function.method.call

class Foo:
    def method(self) -> None: ...

Foo().method()
#     ^^^^^^ @function.method.call
