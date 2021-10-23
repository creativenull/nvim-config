local M = {
  on_attach = nil,
  capabilities = nil,
}

-- Initialize default nvim-lsp settings
function M.init(opts)
  if opts == nil then
    opts = { debug = false }
  end

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    width = 80,
    border = 'single',
    focusable = false,
  })

  M.capabilities = vim.lsp.protocol.make_client_capabilities()

  local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_ok then
    M.capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  else
    M.capabilities.textDocument.completion.completionItem.snippetSupport = true
    M.capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      },
    }
  end

  -- Turn on debug mode for nvim LSP client
  if opts.debug then
    vim.lsp.set_log_level('debug')
  end
end

-- Setup lsp server, given name and nvim-lsp configuration
-- @param lspname string
-- @param lspopts table
function M.setup(lspname, lspopts)
  local default_opts = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }

  lspopts = vim.tbl_extend('force', default_opts, lspopts or {})

  local success, lspconfig = pcall(require, 'lspconfig')
  if not success then
    vim.api.nvim_err_writeln('lspconfig: not installed')
    return
  end

  lspconfig[lspname].setup(lspopts)
end

return M
