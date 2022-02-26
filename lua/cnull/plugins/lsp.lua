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

  local function set_keymaps(bufnr)
    -- LSP Keymaps
    nmap('<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { bufnr = bufnr })
    nmap('<Leader>ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', { bufnr = bufnr })
    nmap('<Leader>le', '<Cmd>lua vim.diagnostic.setloclist()<CR>', { bufnr = bufnr })
    nmap('<Leader>lf', '<Cmd>lua vim.lsp.buf.formatting()<CR>', { bufnr = bufnr })
    nmap('<Leader>lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', { bufnr = bufnr })
    nmap('<Leader>lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', { bufnr = bufnr })

    local diagopts = '{ width = 80, border = "rounded" }'
    nmap(
      '<Leader>lw',
      string.format('<Cmd>lua vim.diagnostic.open_float(%d, %s)<CR>', bufnr, diagopts),
      { bufnr = bufnr }
    )
  end

  local function on_attach(_, bufnr)
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
