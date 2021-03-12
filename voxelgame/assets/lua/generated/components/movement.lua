--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____game_ecs_core = require("game_ecs_core")
local ecs = ____game_ecs_core.ecs
local ____vec3 = require("vec3")
local dot = ____vec3.dot
local ____hitbox = require("components.hitbox")
local hitbox_accessor = ____hitbox.hitbox_accessor
local sqrt = math.sqrt
local max = math.max
local sin = math.sin
ecs:createComponent(
    {
        name = "movement",
        order = 9,
        state = {dirX = 0, dirY = 0, dirZ = 0, moves = false, movementSpeed = 25, maxSpeed = 10, movementFriction = 1, standingFriction = 2},
        onAdd = function(self, id, state)
        end,
        system = function(self, dt, states)
            for ____, state in ipairs(states) do
                local __id = state.__id
                local dirX = state.dirX
                local dirZ = state.dirZ
                local movementSpeed = state.movementSpeed
                local maxSpeed = state.maxSpeed
                local movementFriction = state.movementFriction
                local standingFriction = state.standingFriction
                local hitbox_state = hitbox_accessor(nil, __id)
                local hitbox = hitbox_state.hitbox
                if (dirX ~= 0) or (dirZ ~= 0) then
                    local l = sqrt((dirX * dirX) + (dirZ * dirZ))
                    dirX = dirX / l
                    dirZ = dirZ / l
                    local rX, rY, rZ = hitbox:getResting()
                    local vX, vY, vZ = hitbox:getVelocity()
                    local curSpeed = sqrt((vX * vX) + (vZ * vZ))
                    state.moves = true
                    local c = sqrt(
                        max(maxSpeed - curSpeed, 0) / maxSpeed
                    )
                    local speed = movementSpeed * c
                    if rY == -1 then
                        local d = max(
                            0,
                            -1 * dot(nil, vX / curSpeed, 0, vZ / curSpeed, dirX, 0, dirZ)
                        ) * 2
                        local friction = movementFriction + ((standingFriction - movementFriction) * d)
                        hitbox_state.friction = friction
                        hitbox:setFriction(friction)
                    else
                        hitbox_state.friction = standingFriction
                        hitbox:setFriction(standingFriction)
                    end
                    hitbox:addForce(dirX * speed, 0, dirZ * speed)
                else
                    state.moves = false
                    hitbox_state.friction = standingFriction
                    hitbox:setFriction(standingFriction)
                end
            end
        end
    }
)
return ____exports
