--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____game_ecs_core = require("game_ecs_core")
local ecs = ____game_ecs_core.ecs
local worlds = ____game_ecs_core.worlds
____exports.hitboxComponent = ecs:createComponent(
    {
        name = "hitbox",
        order = 10,
        state = {x = 0, y = 0, z = 0, sizeX = 1, sizeY = 1, sizeZ = 1, world = nil, hitbox = nil, updated = true, mass = 1, friction = 1, restitution = 0, gravityMultiplier = 1, autoStep = false, airDrag = -1, fluidDrag = -1},
        onAdd = function(self, id, state)
            local x = state.x
            local y = state.y
            local z = state.z
            local sizeX = state.sizeX
            local sizeY = state.sizeY
            local sizeZ = state.sizeZ
            local world = state.world
            state.hitbox = newHitbox(sizeX, sizeY, sizeZ)
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
            for name, def in pairs(worlds) do
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
____exports.hitbox_accessor = ecs:getStateAccessor("hitbox")
return ____exports
