local M = {
  plugins = {
    {'neovim/nvim-lspconfig'},
    {'creativenull/diagnosticls-configs-nvim'},
    {'RishabhRD/popfix'},
    {'RishabhRD/nvim-lsputils'},
  },
}

function M.after()
  local nmap = require('cnull.core.keymap').nmap

  local function on_attach(client, bufnr)
    local success, completion = pcall(require, 'completion')
    if success then
      completion.on_attach(client)
    end

    local diag_opts = '{ width = 80, focusable = false, border = "single" }'

    -- Keymaps
    nmap('<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { bufnr = bufnr })
    nmap('<Leader>ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', { bufnr = bufnr })
    nmap('<Leader>le', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', { bufnr = bufnr })
    nmap('<Leader>lf', '<Cmd>lua vim.lsp.buf.formatting()<CR>', { bufnr = bufnr })
    nmap('<Leader>lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', { bufnr = bufnr })
    nmap('<Leader>lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', { bufnr = bufnr })
    nmap('<Leader>lw', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics('.. diag_opts ..')<CR>', { bufnr = bufnr })
  end

  local corelsp = require('cnull.core.lsp')
  corelsp.init()
  corelsp.on_attach = on_attach

  -- nvim-lsputils Config
  -- ---
  local lsputil_success, lsputil_code_action = pcall(require, 'lsputil.codeAction')
  if lsputil_success then
    if vim.fn.has('nvim-0.6') == 1 then
      vim.lsp.handlers['textDocument/codeAction'] = lsputil_code_action.code_action_handler
    else
      vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
        lsputil_code_action.code_action_handler(nil, actions, nil, nil, nil)
      end
    end
  end

  require('cnull.lsp').setup({'javascript', 'json', 'lua', 'typescript', 'vim'})

  --[[ local dlsconfig = require('diagnosticls-configs')
  dlsconfig.init({ on_attach = on_attach })
  dlsconfig.setup({
    lua = {
      linter = require('diagnosticls-configs.linters.luacheck'),
      formatter = require('diagnosticls-configs.formatters.lua_format'),
    },
    javascript = {
      linter = require('diagnosticls-configs.linters.eslint'),
      formatter = require('diagnosticls-configs.formatters.prettier'),
    },
    javascriptreact = {
      linter = require('diagnosticls-configs.linters.eslint'),
      formatter = require('diagnosticls-configs.formatters.prettier'),
    },
    typescript = {
      linter = require('diagnosticls-configs.linters.eslint'),
      formatter = require('diagnosticls-configs.formatters.prettier'),
    },
    typescriptreact = {
      linter = require('diagnosticls-configs.linters.eslint'),
      formatter = require('diagnosticls-configs.formatters.prettier'),
    },
  }) ]]
end

return M
