--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.cross(self, a1, a2, a3, b1, b2, b3)
    return (a2 * b3) - (a3 * b2), (a3 * b1) - (a1 * b3), (a1 * b2) - (a2 * b1)
end
function ____exports.dot(self, a1, a2, a3, b1, b2, b3)
    return ((a1 * b1) + (a2 * b2)) + (a3 * b3)
end
return ____exports
