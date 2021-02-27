--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____game_ecs = require("game_ecs")
local ecs = ____game_ecs.ecs
local worlds = ____game_ecs.worlds
local ____character_model = require("mesh.character_model")
local testCharacter = ____character_model.testCharacter
local ____fibers = require("fibers")
local wait = ____fibers.wait
local ____mesh = require("mesh.mesh")
local GroupNode = ____mesh.GroupNode
local hitbox_accessor = ecs:getStateAccessor("hitbox")
ecs:createComponent(
    {
        name = "mesh",
        order = 100,
        state = {mesh = nil, _world_prev = nil, offsetX = 0, offsetY = 0, offsetZ = 0},
        renderSystem = function(self, dt, states)
            for ____, state in ipairs(states) do
                local __id = state.__id
                local mesh = state.mesh
                local offsetX = state.offsetX
                local offsetY = state.offsetY
                local offsetZ = state.offsetZ
                local _world_prev = state._world_prev
                local hitbox_state = hitbox_accessor(nil, __id)
                local x = hitbox_state.x
                local y = hitbox_state.y
                local z = hitbox_state.z
                local world = hitbox_state.world
                mesh:setPosition(x + offsetX, y + offsetY, z + offsetZ)
                if world ~= _world_prev then
                    local def = worlds.test
                    def.node:addNode(mesh)
                    state._world_prev = world
                end
            end
        end
    }
)
ecs:createComponent(
    {
        name = "movement",
        order = 9,
        state = {},
        onAdd = function(self, id, state)
        end
    }
)
____exports.TestEntity = __TS__Class()
local TestEntity = ____exports.TestEntity
TestEntity.name = "TestEntity"
__TS__ClassExtends(TestEntity, GroupNode)
function TestEntity.prototype.____constructor(self, world)
    GroupNode.prototype.____constructor(self)
    self.id = ecs:createEntity()
    self.hitbox = nil
    self.model = testCharacter(nil)
    ecs:addComponent(self.id, "hitbox", {x = 2, y = 32, z = 2, world = world})
    ecs:addComponent(self.id, "mesh", {mesh = self.model, offsetX = 0.375, offsetY = 1.125, offsetZ = 0.375})
    self.hitbox = ecs:getState(self.id, "hitbox").hitbox
    log_debug("Creating entity...")
    local img = wait(
        nil,
        assets:loadImage("textures/container.png")
    )
end
function TestEntity.prototype.update(self, dtime)
    GroupNode.prototype.update(self, dtime)
end
function TestEntity.prototype.draw(self, dcontext, camera)
    GroupNode.prototype.draw(self, dcontext, camera)
end
function TestEntity.prototype.getEyePoint(self)
    return self.model.head:localToGlobal(0, 0.25, 0)
end
return ____exports
