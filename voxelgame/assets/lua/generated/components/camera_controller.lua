--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____game_ecs_core = require("game_ecs_core")
local ecs = ____game_ecs_core.ecs
local getmodel = ecs:getStateAccessor("model")
ecs:createComponent(
    {
        name = "camera_controller",
        order = 101,
        state = {camera = nil},
        onAdd = function(self, id, state)
            if not state.camera then
                state.camera = newCamera()
            end
        end,
        renderSystem = function(self, dt, states)
            for ____, state in ipairs(states) do
                local __id = state.__id
                local camera = state.camera
                local modelState = getmodel(nil, __id)
                local model_node = modelState.model_node
                local x, y, z = model_node:getEyePoint()
                local dirX, dirY, dirZ = model_node:getEyeDirection()
                camera:setPos(x, y, z)
                camera:setDir(dirX, dirY, dirZ)
            end
        end
    }
)
return ____exports
