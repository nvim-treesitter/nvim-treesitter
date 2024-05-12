# fittencode.nvim

Fitten Code AI Programming Assistant for Neovim, helps you to use AI for automatic completion in Neovim, with support for functions like login, logout, shortcut key completion.

![fittencode-KMP-demo](https://github.com/luozhiya/fittencode.nvim/assets/90168447/d6fa4c66-f64b-4880-b7a9-4245226be0ac)

## ✨ Features

- 🚀 Fast completion thanks to `Fitten Code`
- 🐛 Asynchronous I/O for improved performance
- 🐣 Support for `Actions`
  - 1️⃣ Document code
  - 2️⃣ Edit code
  - 3️⃣ Explain code
  - 4️⃣ Find bugs
  - 5️⃣ Generate unit test
  - 6️⃣ Implement features
  - 7️⃣ Improve code
  - 8️⃣ Refactor code
  - 9️⃣ Start chat
- ⭐️ Accept all suggestions with `Tab`
- 🧪 Accept line with `Ctrl + ⬇️`
- 🔎 Accept word with `Ctrl + ➡️`
- ❄️ Undo accepted text
- 🧨 Automatic scrolling when previewing or completing code
- 🍭 Multiple HTTP/REST backends such as `curl`, `libcurl` (WIP)
- 🛰️ Run as a `coc.nvim` (WIP) source or `nvim-cmp` source

## ⚡️ Requirements

- Neovim >= 0.8.0
- curl

## 📦 Installation

Install the plugin with your preferred package manager:

#### For example with `lazy.nvim`:

```lua
{
  'luozhiya/fittencode.nvim',
  config = function()
    require('fittencode').setup()
  end,
}
```

#### For example with `packer.nvim`:

```lua
use {
  'luozhiya/fittencode.nvim',
  config = function()
    require('fittencode').setup()
  end,
}
```

## ⚙️ Configuration

### `defaults`

**fittencode.nvim** comes with the following defaults:

```lua
{
  action = {
    document_code = {
      -- Show "Fitten Code - Document Code" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    edit_code = {
      -- Show "Fitten Code - Edit Code" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    explain_code = {
      -- Show "Fitten Code - Explain Code" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    find_bugs = {
      -- Show "Fitten Code - Find Bugs" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    generate_unit_test = {
      -- Show "Fitten Code - Generate UnitTest" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    start_chat = {
      -- Show "Fitten Code - Start Chat" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
  },  
  disable_specific_inline_completion = {
    -- Disable auto-completion for some specific file suffixes by entering them below
    -- For example, `suffixes = {'lua', 'cpp'}`
    suffixes = {},
  },
  inline_completion = {
    -- Enable inline code completion.
    ---@type boolean
    enable = true,
    -- Disable auto completion when the cursor is within the line.
    ---@type boolean
    disable_completion_within_the_line = false,
    -- Disable auto completion when pressing Backspace or Delete.
    ---@type boolean
    disable_completion_when_delete = false,
  },
  delay_completion = {
    -- Delay time for inline completion (in milliseconds).
    ---@type integer
    delaytime = 0,
  },
  -- Enable/Disable the default keymaps in inline completion.
  use_default_keymaps = true,
  -- Setting for source completion.
  source_completion = {
    -- Enable source completion.
    enable = true,
  },
  -- Set the mode of the completion.
  -- Available options:
  -- - 'inline' (default)
  -- - 'source'
  completion_mode = 'inline',
  ---@class LogOptions
  log = {
    level = vim.log.levels.WARN,
  },
}
```

### `inline` mode

Set `updatetime` to a lower value to improve performance:

```lua
-- Neovim default updatetime is 4000
vim.opt.updatetime = 200
```

### `source` mode

```lua
require('fittencode').setup({
  completion_mode ='source',
})
require('cmp').setup({
  sources = { name = 'fittencode', group_index = 1 },
  mapping = {
    ['<cr>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false }),
  }
})
```

## 🚀 Usage

### Account Commands

| Command           | Description                                                        |
|-------------------|--------------------------------------------------------------------|
| `Fitten register` | If you haven't registered yet, please run the command to register. |
| `Fitten login`    | Try the command `Fitten login <user> <password>` to login.         |
| `Fitten logout`   | Logout account                                                     |

### Action Commands

| Command                     | Description                                                                                                                                                  |
|-----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Fitten document_code`      | Document code                                                                                                                                                |
| `Fitten edit_code`          | Edit code                                                                                                                                                    |
| `Fitten explain_code`       | Explain code                                                                                                                                                 |
| `Fitten find_bugs`          | Find bugs                                                                                                                                                    |
| `Fitten generate_unit_test` | Generate unit test. Try the command `Fitten generate_unit_test <language> <test_framework>` to generate unit test with specific test framework and language. |
| `Fitten implement_features` | Implement features                                                                                                                                           |
| `Fitten improve_code`       | Improve code                                                                                                                                                 |
| `Fitten refactor_code`      | Refactor code                                                                                                                                                |
| `Fitten start_chat`         | Start chat                                                                                                                                                   |

### Default Mappings

| Mappings    | Action                 |
|-------------|------------------------|
| `Tab`       | Accept all suggestions |
| `Ctrl + ⬇️` | Accept line            |
| `Ctrl + ➡️` | Accept word            |

## ✏️ APIs

`fittencode.nvim` provides a set of APIs to help you integrate it with other plugins or scripts.

| API                      | Description                            |
|--------------------------|----------------------------------------|
| `login`                  | Login to Fitten                        |
| `logout`                 | Logout from Fitten                     |
| `register`               | Register to Fitten                     |
| `set_log_level`          | Set the log level                      |
| `get_current_status`     | Get the current status of the `Engine` |
| `has_suggestion`         | Check if there is a suggestion         |
| `accept_all_suggestions` | Accept all suggestions                 |
| `accept_line`            | Accept line                            |
| `accept_word`            | Accept word                            |
| `document_code`          | Document code                          |
| `edit_code`              | Edit code                              |
| `explain_code`           | Explain code                           |
| `find_bugs`              | Find bugs                              |
| `generate_unit_test`     | Generate unit test                     |
| `implement_features`     | Implement features                     |
| `improve_code`           | Improve code                           |
| `refactor_code`          | Refactor code                          |
| `start_chat`             | Start chat                             |
| `stop_eval`              | Stop the evaluation                    |

## 🎉 Special Thanks

- https://github.com/FittenTech/fittencode.vim
