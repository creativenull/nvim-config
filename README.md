# My neovim config in lua

This is my neovim config in lua, I use this to test out different lua plugins or test out new neovim features.

## Screenshots

![image](https://user-images.githubusercontent.com/3767728/147891186-b5f8cfd9-8b59-4269-8b2c-5ce0a788c352.png)

![image](https://user-images.githubusercontent.com/3767728/147891209-b65dc245-f0bc-49f5-bcba-afc810b2d316.png)

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
