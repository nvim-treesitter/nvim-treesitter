public function bar() {}
// ^keyword
//       ^ keyword
//              ^ variable

banana();
// <- variable

banana.bar(foo);
// <- variable
//     ^ variable

banana.foo.bar();

banana.foo.bar(apple);

public function foo(bar) {
	bar = 3;
}
