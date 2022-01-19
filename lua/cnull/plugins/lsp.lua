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
  vim.g.lsp_keymaps_loaded = false

  local function on_attach(_, bufnr)
    local diag_opts = '{ width = 80, border = "rounded" }'

    if not vim.g.lsp_keymaps_loaded then
      vim.g.lsp_keymaps_loaded = true

      -- Load LSP Keymaps once
      nmap('<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { bufnr = bufnr })
      nmap('<Leader>ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', { bufnr = bufnr })
      nmap('<Leader>le', '<Cmd>lua vim.diagnostic.setloclist()<CR>', { bufnr = bufnr })
      nmap('<Leader>lf', '<Cmd>lua vim.lsp.buf.formatting()<CR>', { bufnr = bufnr })
      nmap('<Leader>lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', { bufnr = bufnr })
      nmap('<Leader>lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', { bufnr = bufnr })
      nmap('<Leader>lw', '<Cmd>lua vim.diagnostic.open_float(' .. diag_opts .. ')<CR>', { bufnr = bufnr })
    end

  end

  local nvimlsp = require('cnull.core.lsp')
  nvimlsp.init({
    -- debug = true,
  })
  nvimlsp.on_attach = on_attach

  require('cnull.lsp').setup({ 'javascript', 'json', 'typescript', 'vue', 'lua', 'python' })

  local dlsconfig = require('diagnosticls-configs')
  dlsconfig.init({ on_attach = on_attach })
end

return M
