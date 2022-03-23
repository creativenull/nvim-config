local M = {}

---Validate user config
---@param config table
---@return nil
local function validate_init(config)
  vim.validate({ config = { config, 'table' } })
end

---Merge default config with user provided config
---@param config table
---@return nil
local function merge_config_defaults(config)
  config = config or {}
  config.userspace = config.userspace or 'nvim'
  config.runtimepath = config.runtimepath or string.format('%s/lua', vim.fn.stdpath('config'))
  config.leader = config.leader or ','
  config.localleader = config.localleader or [[\]]
  config.plugins = config.plugins or {}

  config.theme = {
    name = config.theme.name or 'default',
    transparent = config.theme.transparent or false,
    enable_transparent_features = config.theme.enable_transparent_features or false,
    enable_custom_visual_hl = config.theme.enable_custom_visual_hl or false,
    on_before = config.theme.on_before or nil,
    on_after = config.theme.on_after or nil,
  }

  return config
end

---Setup initial configuration for nvim config
---@param config table
---@return table
function M.init(config)
  validate_init(config)

  config = merge_config_defaults(config)

  -- Global State to track config
  _G.CNull = { config = config }

  return _G.CNull.config
end

return M
