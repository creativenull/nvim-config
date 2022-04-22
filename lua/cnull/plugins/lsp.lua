local M = {
  plugins = {
    { 'neovim/nvim-lspconfig' },
    { 'creativenull/diagnosticls-configs-nvim' },
    { 'creativenull/efmls-configs-nvim' },
    { 'onsails/lspkind-nvim' },
  },
}

function M.after()
  local augroup = require('cnull.core.event').augroup
  local nmap = require('cnull.core.keymap').nmap

  ---Set keymaps when an LSP server attaches to the nvim client
  ---@param bufnr number
  ---@return nil
  local custom_keymaps = function(bufnr)
    nmap('<Leader>la', vim.lsp.buf.code_action, { bufnr = bufnr, desc = 'LSP Code Action' })
    nmap('<Leader>ld', vim.lsp.buf.definition, { bufnr = bufnr, desc = 'LSP Go-to Definition' })
    nmap('<Leader>lh', vim.lsp.buf.hover, { bufnr = bufnr, desc = 'LSP Hover Documentation' })
    nmap('<Leader>lr', vim.lsp.buf.rename, { bufnr = bufnr, desc = 'LSP Rename' })
    nmap('<Leader>le', vim.diagnostic.setloclist, { bufnr = bufnr, desc = 'LSP Diagnostics in Location List' })

    nmap('<Leader>lw', function()
      vim.diagnostic.open_float(bufnr, { width = 80, border = 'rounded' })
    end, {
      bufnr = bufnr,
      desc = 'LSP Diagnostic in Float Window',
    })
  end

  ---Only call the formatting request for the given servers
  ---Ref: https://github.com/neovim/nvim-lspconfig/wiki/Multiple-language-servers-FAQ
  ---@param client table
  ---@patam bufnr number
  ---@return nil
  local custom_lsp_fmt = function(client, bufnr)
    local servers = { 'diagnosticls', 'efm', 'null-ls' }

    local fmt_fn = function()
      local fmt_params = vim.lsp.util.make_formatting_params({})
      client.request('textDocument/formatting', fmt_params, nil, bufnr)
    end

    if vim.tbl_contains(servers, client.name) then
      nmap('<Leader>lf', fmt_fn, { bufnr = bufnr, desc = string.format('LSP Formatting w/ %s', client.name) })
    end
  end

  ---LSP on_attach to set configurations that are specific to the each LSP
  ---server
  ---@param client any
  ---@param bufnr number
  ---@return nil
  local on_attach = function(client, bufnr)
    custom_keymaps(bufnr)
    custom_lsp_fmt(client, bufnr)
  end

  -- Intialize lspconfig, to be used with nvimlsp.setup()
  local nvimlsp = require('cnull.core.lsp')
  nvimlsp.init({
    on_attach = on_attach,
    -- debug = true,
  })

  -- Example to setup lsp servers after nvimlsp.init()
  -- I don't use this because I use projectlocal below
  -- nvimlsp.setup({ 'lua', 'tsserverr' })

  -- projectlocal Config
  -- ---
  require('projectlocal.lsp').setup({
    on_attach = on_attach,
    capabilities = nvimlsp.capabilities,
  })

  -- diagnosticls-configs Config
  -- ---
  require('diagnosticls-configs').init({ on_attach = on_attach })

  -- Generic LSP info
  nmap('<Leader>li', '<Cmd>LspInfo<CR>')

  augroup('nvimlsp_user_events', {
    -- Show line diagnostic on cursor hover
    {
      event = { 'CursorHold', 'CursorHoldI' },
      exec = function()
        vim.diagnostic.open_float(nil, { width = 80, border = 'rounded', focus = false, scope = 'cursor' })
      end,
    },
  })
end

return M
