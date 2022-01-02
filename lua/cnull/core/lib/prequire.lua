---Protected require, just like pcall but for require()
---@param modname string
---@return nil
return function(modname)
  local success, mod_or_err = pcall(require, modname)
  if not success then
    vim.api.nvim_err_writeln(mod_or_err)
    return
  end

  return mod_or_err
end
