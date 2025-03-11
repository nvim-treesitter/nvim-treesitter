def func() -> None: ...

_ = func()
#   ^^^^ @function.call

"{}".format(1)
#    ^^^^^^ @function.method.call

class Foo:
    def method(self) -> None: ...

Foo().method()
#     ^^^^^^ @function.method.call

@pytest.mark.filterwarnings("ignore::DeprecationWarning")
#^^^^^^ @variable
#       ^^^^ @variable.member
#            ^^^^^^^^^^^^^^ @function.method.call
def test_func():
    pass
