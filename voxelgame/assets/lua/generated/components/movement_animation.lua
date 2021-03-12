--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____game_ecs_core = require("game_ecs_core")
local ecs = ____game_ecs_core.ecs
local movement_state_accessor = ecs:getStateAccessor("movement")
local sqrt = math.sqrt
ecs:createComponent(
    {
        name = "movement_animation",
        order = 98,
        state = {dirX = 0, dirY = 0, dirZ = 0, target = nil},
        onAdd = function(self, id, state)
            if not state.target then
                local model_state = ecs:getState(id, "model")
                state.target = model_state.model_node
            end
        end,
        renderSystem = function(self, dt, states)
            for ____, state in ipairs(states) do
                local __id = state.__id
                local target = state.target
                local dirX = state.dirX
                local dirY = state.dirY
                local dirZ = state.dirZ
                local movement_state = movement_state_accessor(nil, __id)
                local moves = movement_state.moves
                target.doWalk = moves
                local l = sqrt(((dirX * dirX) + (dirY * dirY)) + (dirZ * dirZ))
                if l == 0 then
                    l = 1
                end
                dirX = dirX / l
                dirY = dirY / l
                dirZ = dirZ / l
                target:setDirection(dirX, dirY, dirZ)
            end
        end
    }
)
return ____exports
