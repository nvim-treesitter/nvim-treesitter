# fittencode.nvim

Fitten Code AI Programming Assistant for Neovim, helps you to use AI for automatic completion in vim, with support for functions like login, logout, shortcut key completion, and single file plugin, convenient for integration into your environment.

## ✨ Features
- 🚀 Fast completion thanks to `Fitten Code` and `curl`
- 🐛 Asynchronous I/O

## ⚡️ Requirements
- Neovim >= 0.9.0
- curl

## 📦 Installation
For example with lazy.nvim:
```
{
  'luozhiya/fittencode.nvim'
  config = function()
    require('fittencode').setup()
  end,
}
```

## ⚙️ Configuration

Will be added in the future.

## 🚀 Usage

| Command             | Description                                                    |
|---------------------|----------------------------------------------------------------|
| `Fittencode login`  | Try the command `Fittencode login <user> <password>` to login. |
| `Fittencode logout` | Logout account                                                 |

### Default Mappings

| Mappings | Action            |
|----------|-------------------|
| `<Tab>`  | Accept completion |

## 🎉 Special Thanks
- https://github.com/FittenTech/fittencode.vim
