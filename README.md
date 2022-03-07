# My neovim config in lua

This is my neovim config in lua, I use this to test out different lua plugins or test out new neovim features.

## Screenshots

![image](https://user-images.githubusercontent.com/3767728/157122035-28a021e2-9eab-4b8b-9026-01996cc92e92.png)

![image](https://user-images.githubusercontent.com/3767728/157122242-9058909a-2af3-42c5-b8aa-5550c1012358.png)

![image](https://user-images.githubusercontent.com/3767728/157122392-3a15ae65-f58b-491d-a5b5-db4fcb098cac.png)

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
