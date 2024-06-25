# Testing with `nvim-treesitter`

This document aims to provide some basic information on writing and running the `nvim-treesitter` test suite.

## Setup

### Install plenary and nvim-treesitter dependencies

You'll need to have modules `plenary.nvim` and `nvim-treesitter` available on your runtime path.

If you cloned the this repository, `nvim-treesitter` should be included on the runtime path by default when you run tests.

You can add `plenary.nvim` to the path however you see fit. One option is to clone the [repository](https://github.com/nvim-lua/plenary.nvim) into your `nvim-treesitter` directory and edit `scripts/minimal_init.lua` to add it to the path.

```lua
vim.opt.runtimepath:append "."
vim.opt.runtimepath:append "./plenary.nvim" -- Add this line.
vim.cmd [[runtime! plugin/plenary.vim]]
```

### Install highlight-assertions 

The [highlight-assertions](https://github.com/theHamsta/highlight-assertions) project is required to test highlighting and injections. The test runners automatically execute the `highlight-assertions` command, so you just need to have the binary available on your path.

If you have a Rust toolchain on your system, you can install the binary with the following command.

```
cargo +nightly install --git https://github.com/theHamsta/highlight-assertions
```

Otherwise, you can download an pre-built binary from the [GitHub release page](https://github.com/theHamsta/highlight-assertions/releases/) and add it to your shell path.

You can check that `highlight-assertions` is properly installed like so.

```
highlight-assertions --version
```

## Running tests

### Run full test suite

```
./scripts/run_tests.sh
```

### Run specific tests

You can supply a test as a second argument to the `run_tests.sh`. The test argument is a path to the test you want to run, starting from the `nvim-treesitter/test/` directory.

For example, here's how we'd run the JavaScript indentation tests.

```
./scripts/run_tests.sh indent/javascript_spec.lua
```

## Writing tests

### Highlighting and injection tests

Highlighting and injection tests follow [Treesitter's unit testing guidelines](https://tree-sitter.github.io/tree-sitter/syntax-highlighting#unit-testing).

In addition, there is a special `!` token that can be used for negative assertions. For example, `^ !javascript` means we expect "javascript" to not appear at this location.

### Indentation tests

Indentation tests belong in the `tests/indent/` directory.

For the sake of this guide, let's imagine we'd like to make a test to ensure that JavaScript function bodies are properly indented. We'll use the namespace "js" for our example, though in reality you'd most likely want to use the existing "ecma"/"javascript" namespaces.

```javascript
function doSomething() {
  | <-- make sure cursor is here by default
}
```

First, create a file `tests/indent/js/simple_function.js` with the test function.

```javascript
function doSomething() {
}
```

Next, create a Lua spec file at `tests/indent/js_spec.lua`. Add the following content.

```lua
local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/js", {
  -- This is the minimal vim configuration.
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent JS:", function()
  -- Check automatic indentation for the whole file at once.
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  -- Check automatic on a line-by-line basis. That is, as if a user were actively typing.
  describe("new line:", function()
    -- In the simple_function.js file, insert a newline at line 1 and write text "var a = 1;".
    -- Afterwards, we expect the indentation of our line to be 2 spaces.
    run:new_line("simple_function.js", { on_line = 1, text = "var a = 1;", indent = 2 })
  end)
end)
```

Run the test to check that it's working as expected.

```
./scripts/run_tests.sh indent/js_spec.lua
```

