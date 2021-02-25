--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____ecs = require("ecs")
local ECS = ____ecs.ECS
local ____character_model = require("mesh.character_model")
local testCharacter = ____character_model.testCharacter
local ____fibers = require("fibers")
local wait = ____fibers.wait
local ____mesh = require("mesh.mesh")
local GroupNode = ____mesh.GroupNode
____exports.ecs = __TS__New(ECS)
____exports.ecs:createComponent(
    {
        name = "hitbox",
        order = 99,
        state = {x = 0, y = 0, z = 0, world = nil, hitbox = nil},
        onAdd = function(self, id, state)
            state.hitbox = newHitbox(0.25, 1.8, 0.25)
            local x = state.x
            local y = state.y
            local z = state.z
            local world = state.world
            state.hitbox:setPosition(world, x, y, z)
        end,
        system = function(self, dt, states)
            for ____, state in ipairs(states) do
                local hitbox = state.hitbox
                local x, y, z = hitbox:getPosition()
                state.x = x
                state.y = y
                state.z = z
            end
        end
    }
)
local hitbox_accessor = ____exports.ecs:getStateAccessor("hitbox")
____exports.ecs:createComponent(
    {
        name = "mesh",
        order = 100,
        state = {mesh = nil, offsetX = 0, offsetY = 0, offsetZ = 0},
        renderSystem = function(self, dt, states)
            for ____, state in ipairs(states) do
                local __id = state.__id
                local mesh = state.mesh
                local offsetX = state.offsetX
                local offsetY = state.offsetY
                local offsetZ = state.offsetZ
                local hitbox_state = hitbox_accessor(nil, __id)
                local x = hitbox_state.x
                local y = hitbox_state.y
                local z = hitbox_state.z
                mesh:setPosition(x + offsetX, y + offsetY, z + offsetZ)
            end
        end
    }
)
____exports.TestEntity = __TS__Class()
local TestEntity = ____exports.TestEntity
TestEntity.name = "TestEntity"
__TS__ClassExtends(TestEntity, GroupNode)
function TestEntity.prototype.____constructor(self, world)
    GroupNode.prototype.____constructor(self)
    self.id = ____exports.ecs:createEntity()
    self.hitbox = nil
    self.model = testCharacter(nil)
    ____exports.ecs:addComponent(self.id, "hitbox", {x = 2, y = 32, z = 2, world = world})
    ____exports.ecs:addComponent(self.id, "mesh", {mesh = self.model, offsetX = 0.125, offsetY = 1.125, offsetZ = 0.125})
    self.hitbox = ____exports.ecs:getState(self.id, "hitbox").hitbox
    log_debug("Creating entity...")
    local img = wait(
        nil,
        assets:loadImage("textures/container.png")
    )
    self:addNode(self.model)
end
function TestEntity.prototype.update(self, dtime)
    GroupNode.prototype.update(self, dtime)
end
function TestEntity.prototype.draw(self, dcontext, camera)
    GroupNode.prototype.draw(self, dcontext, camera)
end
function TestEntity.prototype.getEyePoint(self)
    local sx, sy, sz = self.model:getPosition()
    local hx, hy, hz = self.model.head:getPosition()
    return sx + hx, (sy + hy) + 0.25, sz + hz
end
return ____exports
