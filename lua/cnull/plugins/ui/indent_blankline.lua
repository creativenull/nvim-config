local synIDattr = vim.fn.synIDattr
local synIDtrans = vim.fn.synIDtrans
local hlID = vim.fn.hlID
local bg = synIDattr(synIDtrans(hlID('Normal')), 'bg')
local indent_hi = '#aaaaaa'

if _G.CNull.config.theme.transparent then
  bg = 'NONE'
end

if bg == '' then
  bg = 'NONE'
end

vim.cmd(string.format('highlight IndentBlanklineHighlight guifg=%s guibg=%s', indent_hi, bg))

vim.g.indent_blankline_char = '│'
vim.g.indent_blankline_filetype_exclude = {'help', 'markdown'}
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_char_highlight_list = {'IndentBlanklineHighlight'}
