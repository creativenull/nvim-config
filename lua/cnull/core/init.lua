local M = {}

local errmsg_pkg_required = 'not installed, install via OS pkg manager (required)'
local errmsg_pkg_optional = 'not installed, install via OS pkg manager (optional)'

-- Perform pre-requisite checks before setting any nvim config
local function prereq_checks()
  if vim.fn.executable('python3') == 0 then
    error(string.format('%q %s', 'python3', errmsg_pkg_required))
  end

  if vim.fn.executable('rg') == 0 then
    error(string.format('%q %s', 'ripgrep', errmsg_pkg_required))
  end

  if vim.fn.executable('bat') == 0 then
    vim.api.nvim_err_writeln(string.format('%q %s', 'bat', errmsg_pkg_optional))
  end
end

-- Set some defaults not needed for this config
-- @param cfg table
local function set_defaults(cfg)
  vim.g.loaded_gzip = true
  vim.g.loaded_matchit = true
  vim.g.loaded_matchparen = true
  vim.g.loaded_netrw = true
  vim.g.loaded_netrwPlugin = true
  vim.g.loaded_tarPlugin= true
  vim.g.loaded_tar = true
  vim.g.loaded_zipPlugin= true
  vim.g.loaded_zip = true

  vim.g.loaded_python_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_perl_provider = 0

  -- Python3 plugins support
  vim.g.python3_host_prog = vim.fn.exepath('python3')

  -- Leader mappings
  vim.g.mapleader = cfg.leader
  vim.g.maplocalleader = cfg.localleader
end

-- Initial core setup
-- @param cfg table
function M.setup(opts)
  local colorscheme = require('cnull.core.colorscheme')
  local command = require('cnull.core.command')
  local config = require('cnull.core.config')
  local plugin = require('cnull.core.plugin')
  local reload = require('cnull.core.reload')

  -- Pre-requisites
  prereq_checks()

  -- Default config
  local cfg = config.init(opts.config)

  -- Set defaults
  set_defaults(cfg)

  -- Before core setup
  if opts.on_before then
    opts.on_before(cfg)
  else
    error('core: before() is required!')
  end

  -- Plugins
  if cfg.plugins then
    plugin.setup(cfg)
  end

  -- Color Scheme
  colorscheme.setup(cfg)

  -- Reload command
  command('Config', [[edit $MYVIMRC]])
  command('ConfigReload', reload)

  -- After core setup
  if opts.on_after then
    opts.on_after(cfg)
  else
    error('core: after() is required!')
  end
end

return M
