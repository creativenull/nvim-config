local err = require('cnull.core.lib.err')
local M = {}

---Wrapper to add a user command, see :help nvim_add_user_command
---@param name string
---@param command string|function
---@param opts table|nil
---@return nil
function M.command(name, command, opts)
  opts = opts or {}

  local ok, errmsg = pcall(vim.api.nvim_add_user_command, name, command, opts)

  if not ok then
    err(errmsg)
  end
end

return M.command
