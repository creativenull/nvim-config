local fn = vim.fn
local api = vim.api

local tsserver_exec = 'typescript-language-server'
if fn.executable(tsserver_exec) == 0 then
  api.nvim_err_writeln(string.format('lsp: %q is not installed', tsserver_exec))
  return
end

local deno_exec = 'deno'
if fn.executable(deno_exec) == 0 then
  api.nvim_err_writeln(string.format('lsp: %q is not installed', deno_exec))
  return
end

local root_pattern = require('lspconfig').util.root_pattern
local filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' }
local node_root = string.format('%s/package.json', fn.getcwd())
local deno_root = string.format('%s/deno.json', fn.getcwd())

local is_node = fn.filereadable(node_root) == 1
local is_deno = fn.filereadable(deno_root) == 1
if is_node then
  -- Run tsserver only on Nodejs projects
  require('cnull.core.lsp').setup('tsserver', {
    filetypes = filetypes,
    root_dir = root_pattern('package.json', 'tsconfig.json'),
    flags = {
      debounce_text_changes = 500,
    },
  })
elseif is_deno then
  -- Run denols only on Deno projects
  require('cnull.core.lsp').setup('denols', {
    filetypes = filetypes,
    root_dir = root_pattern('deno.json', 'deno.jsonc'),
    init_options = {
      enable = true,
      lint = true,
      unstable = true,
      importMap = deno_root,
    },
    flags = {
      debounce_text_changes = 500,
    },
  })
end
