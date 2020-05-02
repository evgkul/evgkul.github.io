print("Files:",files);
print("Main.lua!");
print("Test")

local require_cache = {};
require = function(name)
    local cached = require_cache[name];
    if cached~=nil then
        return cached;
    end
    local path = name:gsub("%.","/")..".lua";
    local loaded = files[path];
    if loaded==nil then
        error("Not found "..name);
        return;
    end
    print("Loaded"..loaded);
    local fun, err = load(loaded,path);
    if fun==nil then
        error("Error while loading "..name..": "..err);
        return;
    end
    local res = fun();
    require_cache[name] = res;
    return res;
end

print("req!"..require('test'));