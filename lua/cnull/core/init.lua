local err = require('cnull.core.lib.err')
local M = {}

-- Required tools
local required_externals = { 'deno', 'python3', 'rg', 'git', 'curl' }
local optional_externals = { 'bat' }

-- Error message templates
local errmsg_pkg_required = '(required) not installed, install via OS package manager'
local errmsg_pkg_optional = '(optional) not installed, install via OS package manager'

---Perform pre-requisite checks before setting any nvim config
---@return nil
local function prereq_checks()
  local min = 'nvim-0.7'

  if vim.fn.has(min) == 0 then
    error(string.format('%s nightly and up is required for this config', min))
  end

  -- Required checks
  for _, rbin in pairs(required_externals) do
    if vim.fn.executable(rbin) == 0 then
      error(string.format('%q %s', rbin, errmsg_pkg_required))
    end
  end

  -- Optional checks
  for _, obin in pairs(optional_externals) do
    if vim.fn.executable(obin) == 0 then
      err(string.format('%q %s', obin, errmsg_pkg_optional))
    end
  end
end

---Set some defaults not needed for this config
---@param cfg table
local function set_defaults(cfg)
  vim.g.loaded_gzip = true
  vim.g.loaded_matchit = true
  vim.g.loaded_matchparen = true
  vim.g.loaded_netrw = true
  vim.g.loaded_netrwPlugin = true
  vim.g.loaded_tarPlugin = true
  vim.g.loaded_tar = true
  vim.g.loaded_zipPlugin = true
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

---Initial core setup
---@param opts table
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

  -- Register default augroup
  vim.api.nvim_create_augroup('user_events', { clear = true })

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
