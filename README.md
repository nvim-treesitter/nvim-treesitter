# fittencode.nvim

Fitten Code AI Programming Assistant for Neovim, helps you to use AI for automatic completion in Neovim, with support for functions like login, logout, shortcut key completion.

![fittencode-KMP-demo](https://github.com/luozhiya/fittencode.nvim/assets/90168447/d6fa4c66-f64b-4880-b7a9-4245226be0ac)

## ✨ Features

- 🚀 Fast completion thanks to `Fitten Code` and `curl`
- 🐛 Asynchronous I/O for improved performance
- ⭐️ Accept all suggestions with `Tab`
- 🧪 Accept line with `Ctrl + ⬇️`
- 🔎 Accept word with `Ctrl + ➡️`
- ❄️ Undo accepted text

## ⚡️ Requirements

- Neovim >= 0.10.0 (with support for inline virtual text)
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

Out of box.

## 🚀 Usage

### Default Command

| Command         | Description                                                |
|-----------------|------------------------------------------------------------|
| `Fitten login`  | Try the command `Fitten login <user> <password>` to login. |
| `Fitten logout` | Logout account                                             |

### Default Mappings

| Mappings    | Action                 |
|-------------|------------------------|
| `Tab`       | Accept all suggestions |
| `Ctrl + ⬇️` | Accept line            |
| `Ctrl + ➡️` | Accept word            |

## 🎉 Special Thanks

- https://github.com/FittenTech/fittencode.vim
