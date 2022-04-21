vim.cmd('packadd vim-abolish')
vim.cmd('packadd vim-repeat')
vim.cmd('packadd vim-surround')

vim.cmd('packadd indent-blankline.nvim')
require('cnull.plugins.ui.indent_blankline')

vim.cmd('packadd todo-comments.nvim')
require('todo-comments').setup()
