--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
____exports.Indicators = __TS__Class()
local Indicators = ____exports.Indicators
Indicators.name = "Indicators"
function Indicators.prototype.____constructor(self, camera)
    self.delta_accum = 0
    self.frames = 0
    self.cur_fps = 0
    self.camera = camera
end
function Indicators.prototype.draw(self, canvas, delta)
    self.delta_accum = self.delta_accum + delta
    self.frames = self.frames + 1
    if self.delta_accum >= 1 then
        self.cur_fps = self.frames / self.delta_accum
        self.frames = 0
        self.delta_accum = 0
    end
    canvas:zerototop()
    local h = 0.05
    local y = 0
    local cx, cy, cz = self.camera:getPos()
    local msg = string.format("FPS: %.2f\nX: %.2f\nY: %.2f\nZ: %.2f", self.cur_fps, cx, cy, cz)
    canvas:textline(-1, y, 0.05, h, msg, 4294967295, false)
    y = y + h
    canvas:popTransformation()
end
return ____exports
