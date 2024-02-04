# fittencode.nvim

Fitten Code AI Programming Assistant for Neovim, helps you to use AI for automatic completion in vim, with support for functions like login, logout, shortcut key completion.

![fittencode-KMP-demo](https://github.com/luozhiya/fittencode.nvim/assets/90168447/d6fa4c66-f64b-4880-b7a9-4245226be0ac)

## ✨ Features
- 🚀 Fast completion thanks to `Fitten Code` and `curl`
- 🐛 Asynchronous I/O

## ⚡️ Requirements
- Neovim >= 0.10.0
- curl

## 📦 Installation
For example with lazy.nvim:
```lua
{
  'luozhiya/fittencode.nvim'
  config = function()
    require('fittencode').setup()
  end,
}
```

## ⚙️ Configuration

Out of box.

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
