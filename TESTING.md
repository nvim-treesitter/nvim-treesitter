# Testing with `nvim-treesitter`

This document aims to provide some basic information on writing and running the `nvim-treesitter` test suite.

## Running tests

### Setup

The only required dependency to run `nvim-treesitter` tests is `plenary.nvim`: https://github.com/nvim-lua/plenary.nvim

#### Installing plenary.nvim using packer

TODO: I'm not sure how to set this up.

#### Installing plenary.nvim using vim-plug

These instrunctions assume you have `vim-plug` configured, and are using it as your package manager. If not, follow the [installation instructions](https://github.com/junegunn/vim-plug#installation) to get started.

First, install the `plenary.nvim` module if you don't already have it. See the [`vim-plug` usage section](https://github.com/junegunn/vim-plug#usage) for installation instructions.

Next, copy your local version of `plenary.vim` to the `nvim-treesitter/plugin/` directory. You will probably be able to find this file at `~/.local/share/nvim/plugged/plenary.nvim/plugin/plenary.vim`, though it might elsewhere for earlier versions of `vim-plug`.

```
cp ~/.local/share/nvim/plugged/plenary.nvim/plugin/plenary.vim plugin/
```

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

### Highlighting tests

TODO: I don't know how to write these.

### Injection tests

TODO: I don't know how to write these.

### Indentation tests

Indentation tests belong in the `nvim-treesitter/tests/indent/` directory.

For the sake of this guide, let's imagine we'd like to make a test to ensure that JavaScript function bodies are properly indented. We'll use the namespace "js" for our example, though in reality you'd most likely want to use the existing "ecma"/"javascript" namespaces.

```javascript
function doSomething() {
  | <-- make sure cursor is here by default
}
```

First, create a file `nvim-treesitter/tests/indent/js/simple_function.js` with the test function.

```javascript
function doSomething() {
}
```

Next, create a Lua spec file at `nvim-treesitter/tests/indent/js_spec.lua`. Add the following content.

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

