local api = vim.api
local store_lua_fn = require('cnull.core.lib.storefn').store_lua_fn
local M = {}

---@class VimEventOption
---@field event string|table
---@field exec string|function
---@field pattern string = '*'
---@field once boolean
---@field nested boolean
---@field clear boolean

---Create an :autocmd event, see :help :autocmd for information
---@param opts VimEventOption
---@return nil
function M.autocmd(opts)
  if opts.event == nil then
    error(debug.traceback('autocmd: `event` cannot be empty'))
  end

  -- Set defaults
  opts.once = opts.once and '++once' or ''
  opts.nested = opts.nested and '++nested' or ''
  opts.clear = opts.clear and '!' or ''

  if opts.pattern == nil or opts.pattern == {} then
    opts.pattern = '*'
  end

  -- If event is table list, then join
  if type(opts.event) == 'table' and vim.tbl_count(opts.event) > 1 then
    opts.event = table.concat(opts.event, ',')
  elseif type(opts.event) == 'table' and vim.tbl_count(opts.event) == 1 then
    opts.event = opts.event[1]
  end

  -- If pattern is table list, then join
  if type(opts.pattern) == 'table' and vim.tbl_count(opts.pattern) > 1 then
    opts.pattern = table.concat(opts.pattern, ',')
  elseif type(opts.pattern) == 'table' and vim.tbl_count(opts.pattern) == 1 then
    opts.pattern = opts.pattern[1]
  end

  local execfn = nil
  if type(opts.exec) == 'function' then
    execfn = store_lua_fn('events', opts.event, opts.exec)
  end

  local au = string.format(
    'autocmd%s %s %s %s %s %s',
    opts.clear,
    opts.event,
    opts.pattern,
    opts.once,
    opts.nested,
    execfn or opts.exec
  )

  local success, errmsg = pcall(api.nvim_command, au)
  if not success then
    api.nvim_err_writeln(errmsg)
  end
end

---Create an :augroup, see :help :augroup for information
---@param name string
---@param autocmds VimEventOption[]
---@return nil
function M.augroup(name, autocmds)
  if autocmds == nil or vim.tbl_isempty(autocmds) then
    error(debug.traceback('augroup: `autocmds` cannot be empty'))
  end

  api.nvim_command('augroup ' .. name)
  api.nvim_command('autocmd!')
  for _, exec in pairs(autocmds) do
    M.autocmd(exec)
  end
  api.nvim_command('augroup END')
end

return M
