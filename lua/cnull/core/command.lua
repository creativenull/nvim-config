local store_lua_fn = require('cnull.core.lib.storefn').store_lua_fn
local M = {}

-- Validate options
-- @param cmd string
-- @param exec funtion|string
-- @return nil
local function validate(cmd, exec)
  local tableorstring = type(exec) == 'function' or type(exec) == 'string'
  vim.validate {
    cmd = { cmd, 'string' },
    exec = { exec, function() return tableorstring end },
  }
end

-- Merge attributes with defaults
-- @param attrs table
-- @return table
local function merge_attrs(attrs)
  attrs = attrs or ''
  if vim.tbl_islist(attrs) then
    attrs = table.concat(attrs, ' ')
  end

  return attrs
end

-- Set the execution of command
-- @param cmd string
-- @param exec funtion|string
-- @return string
local function get_exec(cmd, exec)
  local execfn = nil
  if type(exec) == 'function' then
    execfn = store_lua_fn('commands', cmd, exec)
  end

  exec = execfn or exec
  return exec
end

-- Create a :command! given a `cmd` and `exec` with optional `attrs`
-- check :help E174.
-- @param cmd string
-- @param exec string|function
-- @param attrs string|table
function M.command(cmd, exec, attrs)
  validate(cmd, exec)
  attrs = merge_attrs(attrs)
  exec = get_exec(cmd, exec)
  local success, errmsg = pcall(vim.api.nvim_command, string.format('command! %s %s %s', attrs, cmd, exec))
  if not success then
    vim.api.nvim_err_writeln(errmsg)
  end
end

return M.command
