local M = {
  on_attach = nil,
  capabilities = nil,
}

---Set the default diagnostic settings from all sources
---@return nil
local function set_default_diagnostic_config()
  vim.diagnostic.config({
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  })
end

---Set the defaults border settings for LSP floating windows
---@param opts table Similar to nvim_open_win()
---@return nil
local function set_lsp_borders(opts)
  -- Hover window settings
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, opts)

  -- Signature help window settings
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, opts)
end

---Set autocompletion capabilities for each lsp server
---@return nil
local function set_lsp_completion_capabilities()
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
end

---Initialize default nvim-lsp settings
---@param opts table
---@return nil
function M.init(opts)
  if opts == nil or opts == {} then
    opts = { debug = false }
  end

  set_default_diagnostic_config()

  set_lsp_borders({ width = 80, border = 'rounded' })

  set_lsp_completion_capabilities()

  -- Turn on debug mode for nvim LSP client
  if opts.debug then
    vim.lsp.set_log_level('debug')
  end
end

---Setup lsp server, given name and nvim-lsp configuration
---@param lspname string
---@param lspopts table
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
