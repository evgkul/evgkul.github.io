--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____game_ecs = require("game_ecs")
local ecs = ____game_ecs.ecs
local sqrt = math.sqrt
local max = math.max
local sin = math.sin
local hitbox_accessor = ecs:getStateAccessor("hitbox")
____exports.TestEntity = __TS__Class()
local TestEntity = ____exports.TestEntity
TestEntity.name = "TestEntity"
function TestEntity.prototype.____constructor(self, world)
    self.id = ecs:createEntity()
    local sizeX = 0.75
    local sizeY = 1.8
    local sizeZ = 0.75
    ecs:addComponent(self.id, "hitbox", {x = 5, y = 32, z = 5, sizeX = sizeX, sizeY = sizeY, sizeZ = sizeZ, world = world, mass = 1, friction = 2})
    ecs:addComponent(self.id, "movement")
    ecs:addComponent(self.id, "model", {model = "character", offsetX = sizeX / 2, offsetY = (sizeY / 2) + 0.1125, offsetZ = sizeZ / 2})
    ecs:addComponent(self.id, "movement_animation")
end
return ____exports
