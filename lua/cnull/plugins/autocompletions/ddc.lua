local augroup = require('cnull.core.event').augroup
local imap = require('cnull.core.keymap').imap

augroup('ddc_user_events', {
  {
    event = { 'BufEnter', 'BufNew' },
    exec = function()
      local bufnr = vim.fn.bufnr('')
      local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
      if ft == 'TelescopePrompt' then
        vim.call('ddc#disable')
      else
        vim.call('ddc#enable')
      end
    end,
  },
})

vim.call('ddc#custom#patch_global', {
  backspaceCompletion = true,
  autoCompleteDelay = 100,
  sources = { 'nvimlsp', 'around', 'ultisnips' },
  sourceOptions = {
    ['_'] = {
      matchers = { 'matcher_fuzzy' },
      sorters = { 'sorter_rank' },
    },
    ultisnips = {
      mark = 'US',
    },
    ['nvim-lsp'] = {
      mark = 'LSP',
      forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
    },
  },
})

vim.call('ddc_nvim_lsp_doc#enable')

-- Tab completion
local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.user_tab_completion(default_key)
  if vim.fn.pumvisible() == 1 then
    if vim.call('UltiSnips#CanExpandSnippet') == 1 then
      return termcodes('<C-r>=UltiSnips#ExpandSnippet()<CR>')
    else
      return termcodes('<C-y>')
    end
  else
    return termcodes(default_key)
  end
end

imap('<C-y>', 'v:lua.user_tab_completion("<C-y>")', { expr = true })
imap('<C-Space>', 'ddc#manual_complete()', { silent = true, expr = true })
