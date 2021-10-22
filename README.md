# My neovim config in lua

This is my neovim config in lua, I use this to test out different lua plugins or test out new neovim features.

## Screenshots

![image](https://user-images.githubusercontent.com/3767728/138486473-292e0671-b7a0-4118-83ac-4d9c89251a72.png)

![image](https://user-images.githubusercontent.com/3767728/138486579-f4f98ee8-7961-4f86-8e52-ccd94fc68a5d.png)


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
