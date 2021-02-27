--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____ecs = require("ecs")
local ECS = ____ecs.ECS
local ____mesh = require("mesh.mesh")
local GroupNode = ____mesh.GroupNode
____exports.WorldDef = __TS__Class()
local WorldDef = ____exports.WorldDef
WorldDef.name = "WorldDef"
function WorldDef.prototype.____constructor(self, chunkworld)
    self.node = __TS__New(GroupNode)
    self.chunkworld = chunkworld
end
____exports.worlds = {}
____exports.ecs = __TS__New(ECS)
____exports.hitboxComponent = ____exports.ecs:createComponent(
    {
        name = "hitbox",
        order = 10,
        state = {x = 0, y = 0, z = 0, world = nil, hitbox = nil, updated = true, mass = 1, friction = 1, restitution = 0, gravityMultiplier = 1, autoStep = false, airDrag = -1, fluidDrag = -1},
        onAdd = function(self, id, state)
            state.hitbox = newHitbox(0.75, 2, 0.75)
            local x = state.x
            local y = state.y
            local z = state.z
            local world = state.world
            state.hitbox:setPosition(world, x, y, z)
        end,
        system = function(self, dt, states)
            for ____, state in ipairs(states) do
                if state.updated then
                    state.updated = false
                    local hitbox = state.hitbox
                    local world = state.world
                    local x = state.x
                    local y = state.y
                    local z = state.z
                    local mass = state.mass
                    local friction = state.friction
                    local restitution = state.restitution
                    local gravityMultiplier = state.gravityMultiplier
                    local autoStep = state.autoStep
                    local airDrag = state.airDrag
                    local fluidDrag = state.fluidDrag
                    hitbox:setPosition(world, x, y, z)
                    hitbox:setMass(mass)
                    hitbox:setFriction(friction)
                    hitbox:setRestitution(restitution)
                    hitbox:setGravityMultiplier(gravityMultiplier)
                    hitbox:setAutoStep((autoStep and 1) or 0)
                    hitbox:setAirDrag(airDrag)
                    hitbox:setFluidDrag(fluidDrag)
                end
            end
            for name, def in pairs(____exports.worlds) do
                def.chunkworld:physicsTick(dt)
            end
            for ____, state in ipairs(states) do
                local hitbox = state.hitbox
                local updatedPhysics = state.updated
                local x, y, z = hitbox:getPosition()
                state.x = x
                state.y = y
                state.z = z
            end
        end
    }
)
return ____exports
