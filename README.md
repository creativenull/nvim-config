# My neovim config in lua

This is my neovim config in lua, I use this to test out different lua plugins or test out new neovim features.

## Requirements

+ The nightly version of neovim is required aka [`master` branch](https://github.com/neovim/neovim/tree/master)

## Architecture

```
├── init.lua               (Starting point)
├── after
│   └── ftplugin           (Plugins to be loaded on the 'FileType' event)
├── lua
│   └── cnull
│       ├── core           (Initial setup and utilities called from here)
│       ├── lsp            (Everything LSP related, setup for the built-in LSP)
│       ├── plugins        (Plugins organized by features instead of plugin names)
│       └── user           (My custom user configuration independent of plugins)
```

## Installation/Setup

In a Linux/MacOS machine:

```sh
git clone https://github.com/creativenull/nvim-config $HOME/.config/nvim
```

In Windows (powershell):

```
git clone https://github.com/creativenull/nvim-config $HOME/AppData/Local/nvim
```
