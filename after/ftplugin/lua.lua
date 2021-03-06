vim.cmd('packadd vim-abolish')
vim.cmd('packadd vim-repeat')
vim.cmd('packadd vim-surround')

vim.cmd('packadd indent-blankline.nvim')
require('cnull.plugins.ui.indent_blankline')

vim.cmd('packadd todo-comments.nvim')
require('todo-comments').setup()

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
