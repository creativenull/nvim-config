local err = require('cnull.core.lib.err')
local M = {}

---Validate opts from user
---@param opts table
---@return nil
local function validate_autocmd(opts)
  vim.validate({
    event = { opts.event, { 'string', 'table' } },
    exec = { opts.exec, { 'string', 'function' } },

    -- nullables
    group = { opts.group, 'string', true },
    once = { opts.once, 'boolean', true },
    nested = { opts.nested, 'boolean', true },
    pattern = { opts.pattern, { 'string', 'table' }, true },
    desc = { opts.desc, { 'string' }, true }
  })
end

---Merge default opts with user provided opts
---@param opts table
---@return table
local function merge_autocmd_defaults(opts)
  opts = opts or {}
  opts.once = opts.once or false
  opts.nested = opts.nested or false
  opts.group = opts.group or 'user_events'
  opts.pattern = opts.pattern or '*'
  opts.desc = opts.desc or 'Awesome autocmd from nightly'

  if opts.buffer then
    opts.pattern = nil
  end

  if type(opts.exec) == 'string' then
    opts.command = opts.exec
    opts.exec = nil
  elseif type(opts.exec) == 'function' then
    opts.callback = opts.exec
    opts.exec = nil
  end

  return opts
end

---Create an :autocmd event, see :help nvim_create_autocmd
---@param opts table
---@return nil
local function autocmd(opts)
  local ok, errmsg = pcall(validate_autocmd, opts)

  if not ok then
    err(errmsg)

    return
  end

  opts = merge_autocmd_defaults(opts)
  local name = opts.event
  opts.event = nil

  ok, errmsg = pcall(vim.api.nvim_create_autocmd, name, opts)

  if not ok then
    err(errmsg)
  end
end

---Validate opts from user
---@param name string
---@param autocmds table
---@param opts table
---@return nil
local function validate_augroup(name, autocmds, opts)
  vim.validate({
    name = { name, 'string' },
    autocmds = { autocmds, 'table' },
    opts = { opts, 'table', true },
  })
end

---Merge default opts with user provided opts
---@param opts table
---@return table
local function merge_augroup_defaults(opts)
  opts = opts or {}
  opts.clear = opts.clear or true

  return opts
end

---Create an :augroup, see :help nvim_create_augroup
---@param name string
---@param autocmds table
---@return nil
local function augroup(name, autocmds, opts)
  local ok, errmsg = pcall(validate_augroup, name, autocmds, opts)

  if not ok then
    err(errmsg)

    return
  end

  opts = merge_augroup_defaults(opts)

  ok, errmsg = pcall(vim.api.nvim_create_augroup, name, opts)

  if not ok then
    err(errmsg)

    return
  end

  for _, v in pairs(autocmds) do
    M.autocmd(vim.tbl_extend('force', { group = name }, v))
  end
end

M.autocmd = autocmd
M.augroup = augroup

return M
