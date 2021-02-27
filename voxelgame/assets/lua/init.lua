print = log_info

print("Hello from lua")

math.atan2 = math.atan2 or math.atan --Lua 5.3


do --Fixing incompatibilities between luajit and lua 5.4
unpack = unpack or table.unpack
end

old_require = require

local load_cache = {}
currently_loading = {}
local lua_modules = lua_modules
--local requirePrefixes = {"lua/","lua/generated"}
--for k,v in pairs(lua_modules) do
--  print("MODULE!",k)
--end
require = function(name)
  if currently_loading[name] then
    error("Attempt to recursively load module (or failed previous attempt) "..name)
  end
  local val = load_cache[name]
  if val~=nil then
    return val
  else
    currently_loading[name] = true
    log_debug("Loading module",name)
    local path = name:gsub("%.","/")..".lua"
    local code = lua_modules[path]
    if code then
      local f,err = load(code,"@"..path,"t")
      if f==nil then
        error("Unable to load module "..name..": "..err)
      end
      val = f()
      load_cache[name] = val
      currently_loading[name] = false
      log_debug("Loaded module",name)
      return val
    end
  end
  return old_require(name)
end

function main()  
  function testbp()
    assert(string.pack,"string.pack not defined")
    assert(string.unpack,"string.pack not defined")
    assert(string.packsize,"string.pack not defined")
    --require("tpack")
  end
  testbp()
  do
    local json = require("json")
    local decode = json.decode
    local encode = json.encode
     
    _G.JSON = {}
    function _G.JSON.parse(self,str)
      return decode(str)
    end
    function _G.JSON.stringify(self,data)
      return encode(data)
    end
  end
  

  require("init_second")
  print("TEST",buildAtlas)
end

function handleError(e)
  log_error(debug.traceback(e,2))
end

_G.unwrap_args = function(is_suc,...)
  if not is_suc then
    error(...)
  else
    return ...
  end
end

xpcall(main,handleError)

print("EXITED")