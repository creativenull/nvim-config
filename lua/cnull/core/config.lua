local M = {}

-- Setup initial configuration for nvim config
-- @param config table
-- @return table
function M.init(config)
  vim.validate({ config = { config, 'table' } })

  local default_config = {
    userspace = config.userspace or 'nvim',
    runtimepath = config.runtimepath or string.format('%s/lua', vim.fn.stdpath('config')),
    leader = config.leader or ',',
    localleader = config.localleader or [[\]],
    theme = {
      name = config.theme.name or 'default',
      transparent = config.theme.transparent or false,
      on_before = config.theme.on_before or nil,
      on_after = config.theme.on_after or nil,
    },
    plugins = config.plugins or {},
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
