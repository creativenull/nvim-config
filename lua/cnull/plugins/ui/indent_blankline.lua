local synIDattr = vim.fn.synIDattr
local synIDtrans = vim.fn.synIDtrans
local hlID = vim.fn.hlID
local bg = synIDattr(synIDtrans(hlID('Normal')), 'bg')
local indent_hi = '#555555'

if _G.CNull.config.theme.transparent then
  bg = 'NONE'
end

if bg == '' then
  bg = 'NONE'
end

vim.cmd(string.format('highlight! IndentBlanklineHighlight guifg=%s guibg=%s', indent_hi, bg))

require('indent_blankline').setup({
  char = '│',
  buftype_exclude = { 'help', 'markdown' },
  char_highlight_list = { 'IndentBlanklineHighlight' },
  show_first_indent_level = false,
})
