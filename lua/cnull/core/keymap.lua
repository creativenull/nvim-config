local err = require('cnull.core.lib.err')
local DEFAULT_OPTS = { noremap = true }
local M = {}

---Validate user opts
---@param input string
---@param exec string|function
---@return nil
local function validate(input, exec)
  vim.validate({
    input = { input, 'string' },
    exec = { exec, { 'string', 'function' } },
  })
end

---Merge default opts from user provided opts
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

---Map input to exec with provided mode and opts
---@param mode string
---@param input string
---@param exec string|function
---@param opts table|nil
---@return nil
local function mapper(mode, input, exec, opts)
  local ok, errmsg = pcall(validate, input, exec)

  if not ok then
    err(errmsg)

    return
  end

  opts = merge_opts(opts)

  if opts.bufnr then
    local bufnr = opts.bufnr
    opts.bufnr = nil

    ok, errmsg = pcall(vim.keymap.set, mode, input, exec, vim.tbl_extend('force', { buffer = bufnr }, opts))

    if not ok then
      err(errmsg)
    end
  else
    ok, errmsg = pcall(vim.keymap.set, mode, input, exec, opts)

    if not ok then
      err(errmsg)
    end
  end
end

---Create a normal, visual and operator-pending mode keymap, see :help mapmode-nvo
---@param input string
---@param exec string|function
---@param opts table
function M.map(input, exec, opts)
  mapper('', input, exec, opts)
end

---Create a normal mode keymap, see :help mapmode-n
---@param input string
---@param exec string|function
---@param opts table
function M.nmap(input, exec, opts)
  mapper('n', input, exec, opts)
end

---Create an insert mode keymap, see :help mapmode-i
---@param input string
---@param exec string|function
---@param opts table
function M.imap(input, exec, opts)
  mapper('i', input, exec, opts)
end

---Create a visual mode keymap, see :help mapmode-v
---@param input string
---@param exec string|function
---@param opts table
function M.vmap(input, exec, opts)
  mapper('v', input, exec, opts)
end

---Create a terminal mode keymap, see :help mapmode-t
---@param input string
---@param exec string|function
---@param opts table
function M.tmap(input, exec, opts)
  mapper('t', input, exec, opts)
end

---Create a command line mode keymap, see :help mapmode-c
---@param input string
---@param exec string|function
---@param opts table
function M.cmap(input, exec, opts)
  mapper('c', input, exec, opts)
end

---Create a visual and select mode keymap, see :help mapmode-x
---@param input string
---@param exec string|function
---@param opts table
function M.xmap(input, exec, opts)
  mapper('x', input, exec, opts)
end

---Create an operator-pending mode keymap, see :help mapmode-o
---@param input string
---@param exec string|function
---@param opts table
function M.omap(input, exec, opts)
  mapper('o', input, exec, opts)
end

---Create a select mode keymap, see :help mapmode-s
---@param input string
---@param exec string|function
---@param opts table
function M.smap(input, exec, opts)
  mapper('s', input, exec, opts)
end

return M
