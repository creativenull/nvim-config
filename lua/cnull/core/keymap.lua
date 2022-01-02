local store_lua_fn = require('cnull.core.lib.storefn').store_lua_fn
local store_vlua_fn = require('cnull.core.lib.storefn').store_vlua_fn
local DEFAULT_OPTS = { noremap = true, silent = true }
local M = {}

---Validate args for mapper()
---@param input string
---@param exec string|function
---@return nil
local function validate(input, exec)
  local valid_strfn = type(exec) == 'string' or type(exec) == 'function'
  vim.validate({
    input = { input, 'string' },
    exec = {
      exec,
      function()
        return valid_strfn
      end,
    },
  })
end

---Merge opts with default keymap options
---@param opts table
---@return table
local function merge_opts(opts)
  if opts and type(opts) == 'table' then
    opts = vim.tbl_extend('force', DEFAULT_OPTS, opts)
  else
    opts = DEFAULT_OPTS
  end

  return opts
end

---Set the right-hand-side as string or function
---@param input string
---@param exec string|function
---@return string
local function set_exec(input, exec, opts)
  local execfn = nil
  if type(exec) == 'function' then
    if opts.expr then
      execfn = store_vlua_fn('keymaps', input, exec)
    else
      execfn = string.format('<Cmd>%s<CR>', store_lua_fn('keymaps', input, exec))
    end
  end
  exec = execfn or exec
  return exec
end

---Generic key mapper to map keys globally or in buffer
---@param mode string
---@param input string
---@param exec string|function
---@param opts table|nil
---@return nil
local function mapper(mode, input, exec, opts)
  validate(input, exec)
  opts = merge_opts(opts)
  exec = set_exec(input, exec, opts)

  if opts.bufnr then
    local bufnr = opts.bufnr
    opts.bufnr = nil
    local success, errmsg = pcall(vim.api.nvim_buf_set_keymap, bufnr, mode, input, exec, opts)
    if not success then
      vim.api.nvim_err_writeln(errmsg)
    end
  else
    local success, errmsg = pcall(vim.api.nvim_set_keymap, mode, input, exec, opts)
    if not success then
      vim.api.nvim_err_writeln(errmsg)
    end
  end
end

---@param input string
---@param exec string|function
---@param opts table
function M.map(input, exec, opts)
  mapper('', input, exec, opts)
end

---@param input string
---@param exec string|function
---@param opts table
function M.nmap(input, exec, opts)
  mapper('n', input, exec, opts)
end

---@param input string
---@param exec string|function
---@param opts table
function M.imap(input, exec, opts)
  mapper('i', input, exec, opts)
end

---@param input string
---@param exec string|function
---@param opts table
function M.vmap(input, exec, opts)
  mapper('v', input, exec, opts)
end

---@param input string
---@param exec string|function
---@param opts table
function M.tmap(input, exec, opts)
  mapper('t', input, exec, opts)
end

---@param input string
---@param exec string|function
---@param opts table
function M.cmap(input, exec, opts)
  mapper('c', input, exec, opts)
end

---@param input string
---@param exec string|function
---@param opts table
function M.xmap(input, exec, opts)
  mapper('x', input, exec, opts)
end

---@param input string
---@param exec string|function
---@param opts table
function M.omap(input, exec, opts)
  mapper('o', input, exec, opts)
end

---@param input string
---@param exec string|function
---@param opts table
function M.smap(input, exec, opts)
  mapper('s', input, exec, opts)
end

return M
