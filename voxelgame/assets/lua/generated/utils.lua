--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.counter(self, after)
    local rem = 0
    return function(self)
        rem = rem + 1
        return function()
            rem = rem - 1
            if rem == 0 then
                after(nil)
            end
        end
    end
end
return ____exports
