## Quick start (running tests)

1. To run a particular test file:
```bash
make tests TESTS=indent/c_spec.lua
```
2. To run all the tests, you will need to install all language parsers. Run `make parsers` to install them into `.test-deps/nvim-{os}-{arch}/share`. This could take some time.

Then, to run all query tests:
```bash
make tests TESTS=query
```

To run all indent tests:
```bash
make tests TESTS=indent
```
