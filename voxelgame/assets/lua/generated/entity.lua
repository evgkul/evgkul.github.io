--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____fibers = require("fibers")
local wait = ____fibers.wait
local ____mesh = require("mesh")
local GroupNode = ____mesh.GroupNode
local ____mesh_utils = require("mesh_utils")
local cubeMesh = ____mesh_utils.cubeMesh
____exports.TestEntity = __TS__Class()
local TestEntity = ____exports.TestEntity
TestEntity.name = "TestEntity"
__TS__ClassExtends(TestEntity, GroupNode)
function TestEntity.prototype.____constructor(self, world)
    GroupNode.prototype.____constructor(self)
    self.hitbox = newHitbox(0.9, 0.9, 0.9)
    self.model = cubeMesh(nil, 0, 0, 0, 0.9, 0.9, 0.9)
    log_debug("Creating entity...")
    local img = wait(
        nil,
        assets:loadImage("textures/container.png")
    )
    local tex = newTexture(img)
    self.model.program:setTexture("tex", tex)
    local x = 2 + 0.05
    local y = 32 + 0.05
    local z = 2 + 0.05
    self.model:setPosition(x, y, z)
    self.hitbox:setPosition(world, x, y, z)
    self:addNode(self.model)
end
function TestEntity.prototype.draw(self, dcontext, camera)
    local x, y, z = self.hitbox:getPosition()
    self.model:setPosition(x, y, z)
    GroupNode.prototype.draw(self, dcontext, camera)
end
return ____exports
