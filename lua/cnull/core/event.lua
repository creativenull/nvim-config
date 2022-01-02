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

  -- If event is table list, then join
  if vim.tbl_islist(opts.event) and vim.tbl_count(opts.event) > 1 then
    opts.event = table.concat(opts.event, ',')
  end

  -- If pattern is table list, then join
  if vim.tbl_islist(opts.pattern) and vim.tbl_count(opts.pattern) > 1 then
    opts.pattern = table.concat(opts.pattern, ',')
  end

  local execfn = nil
  if type(opts.exec) == 'function' then
    execfn = store_lua_fn('events', opts.event, opts.exec)
  end

  local au = string.format(
    'autocmd%s %s %s %s %s %s',
    opts.clear and '!' or '',
    opts.event,
    opts.pattern or '*',
    opts.once and '++once' or '',
    opts.nested and '++nested' or '',
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
