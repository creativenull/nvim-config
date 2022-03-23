---Notify user of any error via vim.notify(), see :help vim.notify
---@param errmsg string
---@return nil
return function(errmsg)
  vim.notify(errmsg, vim.log.levels.ERROR)
end
