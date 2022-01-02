local M = {
  on_attach = nil,
  capabilities = nil,
}

-- Initialize default nvim-lsp settings
function M.init(opts)
  if opts == nil then
    opts = { debug = false }
  end

  -- Global diagnostic settings
  vim.diagnostic.config({
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  })

  -- Hover window settings
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { width = 80, border = 'rounded' })

  -- LSP Default Capabilities
  M.capabilities = vim.lsp.protocol.make_client_capabilities()

  -- nvim-cmp Config
  -- ---
  local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_ok then
    M.capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  else
    M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    M.capabilities.textDocument.completion.completionItem.preselectSupport = true
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
