local imap = require('cnull.core.keymap').imap

local function get_termcode(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.tab_completion(default_key)
  if vim.fn.pumvisible() == 1 then
    if vim.fn['UltiSnips#CanExpandSnippet']() == 1 then
      return get_termcode('<C-r>=UltiSnips#ExpandSnippet()<CR>')
    else
      return get_termcode('<C-y>')
    end
  else
    return get_termcode(default_key)
  end
end

imap('<Tab>', 'v:lua.tab_completion(\'<Tab>\')', { silent = true, expr = true })
