---Make a copy of a function
---https://leafo.net/guides/function-cloning-in-lua.html
---@param fn function
---@return string
local function clone_fn(fn)
  local dumped = string.dump(fn)
  local cloned = loadstring(dumped)
  local i = 1
  while true do
    local name = debug.getupvalue(fn, i)
    if not name then
      break
    end
    debug.upvaluejoin(cloned, i, fn, i)
    i = i + 1
  end
  return cloned
end

return clone_fn
