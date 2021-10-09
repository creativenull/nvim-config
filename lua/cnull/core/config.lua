local api = vim.api
local fn = vim.fn
local M = {}

local errmsg_pkg_required = 'not installed, install via OS pkg manager (required)'
local errmsg_pkg_optional = 'not installed, install via OS pkg manager (optional)'

-- Perform pre-requisite checks before setting any nvim config
local function prereq_checks()
  if fn.executable('python3') == 0 or vim.env.PYTHON3_HOST_PROG == nil then
    error(string.format('%q %s', 'python3', errmsg_pkg_required))
  end

  if fn.executable('rg') == 0 then
    error(string.format('%q %s', 'ripgrep', errmsg_pkg_required))
  end

  if fn.has('win32') == 0 then
    if fn.executable('nnn') == 0 then
      error(string.format('%q %s', 'nnn', errmsg_pkg_required))
    end
  end

  if fn.executable('bat') == 0 then
    api.nvim_err_writeln(string.format('%q %s', 'bat', errmsg_pkg_optional))
  end
end

-- Setup initial configuration for nvim config
-- @param config table
-- @return table
function M.init(config)
  prereq_checks()
  vim.validate({ config = {config, 'table'} })

  local default_config = {
    userspace = config.userspace or 'nvim',
    runtimepath = config.runtimepath or string.format('%s/lua', fn.stdpath('config')),
    leader = config.leader or ',',
    autocompletion = config.autocompletion or 'cmp',
    snippets = config.snippets or 'luasnip',
    finder = config.finder or 'fzf',
    statusline = config.statusline or 'lualine',
    localleader = config.localleader or [[\]],
    theme = {
      name = config.theme.name or 'default',
      transparent = config.theme.transparent or false,
      on_before = config.theme.on_before or nil,
      on_after = config.theme.on_after or nil,
    },
    plugins = config.plugins or {}
  }

  -- Global State to track config, events, commands, keymaps, etc
  _G.CNull = {
    config = default_config,
    events = {},
    commands = {},
    keymaps = {},
  }

  return _G.CNull.config
end

return M
