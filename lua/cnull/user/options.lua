local augroup = require('cnull.core.event').augroup

-- Windows specific
if vim.fn.has('win32') == 1 then
  local shellcmdflag = {
    '-NoLogo',
    '-NoProfile',
    '-ExecutionPolicy RemoteSigned',
    '-Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
  }

  vim.opt.shell = 'pwsh'
  vim.opt.shellcmdflag = table.concat(shellcmdflag, ' ')
  vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end

-- Ensure undo directory is created
local undodir = vim.fn.stdpath('cache') .. '/undo'

if vim.fn.isdirectory(undodir) == 0 then
  if vim.fn.has('win32') == 1 then
    vim.fn.system({ 'mkdir', undodir })
  else
    vim.fn.system({ 'mkdir', '-p', undodir })
  end
end

-- Completion options
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.shortmess:append('c')

-- Search
vim.opt.ignorecase = false
vim.opt.smartcase = true

-- Editor
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmatch = true
vim.opt.wrap = false
vim.opt.colorcolumn = '120'
vim.opt.scrolloff = 5
vim.opt.lazyredraw = true
vim.opt.spell = false

-- System
vim.opt.encoding = 'utf-8'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.updatetime = 250
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.undolevels = 10000
vim.opt.history = 10000
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.ttimeoutlen = 50
vim.opt.wildignorecase = true

if vim.fn.has('wsl') == 0 then
  vim.opt.mouse = 'nv'
end

-- UI
vim.opt.hidden = true
vim.opt.signcolumn = 'yes'
vim.opt.cmdheight = 2
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.guicursor = { 'n-v-c-sm:block', 'i-ci-ve:block', 'r-cr-o:hor20' }
vim.opt.foldenable = false

-- Built-in find and grep
augroup('custom_finder_user_events', {
  {
    event = { 'BufNew', 'BufEnter' },

    exec = function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(bufnr, 'path', '**')
    end,
  },
})
