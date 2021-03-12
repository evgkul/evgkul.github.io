--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____game_ecs_core = require("game_ecs_core")
local ecs = ____game_ecs_core.ecs
local worlds = ____game_ecs_core.worlds
local model_providers = ____game_ecs_core.model_providers
local ____hitbox = require("components.hitbox")
local hitbox_accessor = ____hitbox.hitbox_accessor
ecs:createComponent(
    {
        name = "model",
        order = 100,
        state = {model_node = nil, model = "character", _world_prev = nil, offsetX = 0, offsetY = 0, offsetZ = 0},
        onAdd = function(self, id, state)
            if not state.model_node then
                state.model_node = model_providers[state.model](model_providers, {})
            end
        end,
        renderSystem = function(self, dt, states)
            for ____, state in ipairs(states) do
                local __id = state.__id
                local mesh = state.model_node
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
return ____exports
