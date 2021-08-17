local fn = vim.fn
local api = vim.api

local exec = 'luals'
if fn.executable(exec) == 0 then
  api.nvim_err_writeln(string.format('lsp: %q is not installed', exec))
  return
end

local lua_rtp = vim.split(package.path, ';')
table.insert(lua_rtp, 'lua/?.lua')
table.insert(lua_rtp, 'lua/?/init.lua')

local config = {
  cmd = {'luals'},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = lua_rtp,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'coq'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.schedule(function()
  if coq then
    require('cnull.core.lsp').setup('sumneko_lua', coq.lsp_ensure_capabilities(config))
  else
    require('cnull.core.lsp').setup('sumneko_lua', config)
  end
end)
