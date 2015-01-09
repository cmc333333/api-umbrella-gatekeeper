local _M = {}

local lrucache = require "resty.lrucache.pureffi"
local utils = require "utils"

local cache = lrucache.new(500)

function _M.get(api_key)
  local user = cache:get(api_key)
  if user then
    return user
  end

  user = utils.get_packed(ngx.shared.api_users, api_key)
  cache:set(api_key, user)
  return user
end


return _M