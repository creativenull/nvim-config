local M = {
  plugins = {
    { 'neovim/nvim-lspconfig' },
    { 'creativenull/diagnosticls-configs-nvim' },
    { 'creativenull/efmls-configs-nvim' },
    { 'onsails/lspkind-nvim' },
  },
}

function M.after()
  local nmap = require('cnull.core.keymap').nmap

  ---Set keymaps when an LSP server attaches to the nvim client
  ---@param bufnr number
  ---@return nil
  local function set_keymaps(bufnr)
    nmap('<Leader>la', vim.lsp.buf.code_action, { bufnr = bufnr })
    nmap('<Leader>ld', vim.lsp.buf.definition, { bufnr = bufnr })
    nmap('<Leader>le', vim.diagnostic.setloclist, { bufnr = bufnr })
    nmap('<Leader>lf', vim.lsp.buf.formatting, { bufnr = bufnr })
    nmap('<Leader>lh', vim.lsp.buf.hover, { bufnr = bufnr })
    nmap('<Leader>lr', vim.lsp.buf.rename, { bufnr = bufnr })

    nmap('<Leader>lw', function()
      vim.diagnostic.open_float(bufnr, { width = 80, border = 'rounded' })
    end, {
      bufnr = bufnr,
    })
  end

  ---Disable formatting from some servers
  ---@param client any
  ---@return nil
  local function modify_server(client)
    local servers = { 'tsserver', 'sumneko_lua' }

    for _, server in pairs(servers) do
      if client.name == server and client.resolved_capabilities.document_formatting then
        client.resolved_capabilities.document_formatting = false
      end
    end
  end

  ---LSP on_attach to set configurations that are specific to the each LSP
  ---server
  ---@param client any
  ---@param bufnr number
  ---@return nil
  local function on_attach(client, bufnr)
    modify_server(client)
    set_keymaps(bufnr)
  end

  -- LSP info keymap
  nmap('<Leader>li', '<Cmd>LspInfo<CR>')

  local nvimlsp = require('cnull.core.lsp')
  nvimlsp.init({
    -- debug = true,
  })
  nvimlsp.on_attach = on_attach

  -- projectlocal Config
  -- ---
  require('projectlocal.lsp').setup({
    on_attach = on_attach,
    capabilities = nvimlsp.capabilities,
  })

  -- diagnosticls-configs Config
  -- ---
  require('diagnosticls-configs').init({ on_attach = on_attach })
end

return M
