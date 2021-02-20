--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local cos = math.cos
local sin = math.sin
local rad = math.rad
local min = math.min
local max = math.max
local function cameraMovement(self)
    local posX = 1
    local posY = 2
    local posZ = 10
    local dirX = 0
    local dirY = 0
    local dirZ = -1
    local dirXFlat = 0
    local dirZFlat = -1
    local yaw = -90
    local pitch = 0
    local speed = 25
    local function getPosition(self)
        return posX, posY, posZ
    end
    local function getDirection(self)
        return dirX, dirY, dirZ
    end
    local function setPosition(self, x, y, z)
        posX = x
        posY = y
        posZ = z
    end
    local function moveForward(self, delta)
        local velocity = speed * delta
        posX = posX + (dirXFlat * velocity)
        posZ = posZ + (dirZFlat * velocity)
    end
    local function moveRight(self, delta)
        local velocity = speed * delta
        posX = posX - (dirZFlat * velocity)
        posZ = posZ + (dirXFlat * velocity)
    end
    local function moveUp(self, delta)
        posY = posY + (delta * speed)
    end
    local function handleMouse(self, deltaYaw, deltaPitch)
        pitch = min(
            max(pitch + deltaPitch, -89),
            89
        )
        yaw = yaw + deltaYaw
        local r_pitch = rad(pitch)
        local r_yaw = rad(yaw)
        dirX = cos(r_yaw) * cos(r_pitch)
        dirY = sin(r_pitch)
        dirZ = sin(r_yaw) * cos(r_pitch)
        dirXFlat = cos(r_yaw)
        dirZFlat = sin(r_yaw)
    end
    return {getPosition = getPosition, getDirection = getDirection, setPosition = setPosition, moveForward = moveForward, moveRight = moveRight, moveUp = moveUp, handleMouse = handleMouse}
end
____exports.CameraMovementController = __TS__Class()
local CameraMovementController = ____exports.CameraMovementController
CameraMovementController.name = "CameraMovementController"
function CameraMovementController.prototype.____constructor(self)
    self.x = 0
    self.y = 0
    self.z = 0
    self.dirX = 0
    self.dirY = 0
    self.dirZ = -1
    self.dirXFlat = 1
    self.dirZFlat = 0
    self.worldUpX = 0
    self.worldUpY = 1
    self.worldUpZ = -1
    self.yaw = -90
    self.pitch = 0
    self.speed = 25
    self.doMoveForward = false
    self.doMoveBackward = false
    self.doMoveLeft = false
    self.doMoveRight = false
    self.doMoveDown = false
    self.doMoveUp = false
end
function CameraMovementController.prototype.getPosition(self)
    return self.x, self.y, self.z
end
function CameraMovementController.prototype.getDirection(self)
    return self.dirX, self.dirY, self.dirZ
end
function CameraMovementController.prototype.setPosition(self, x, y, z)
    self.x = x
    self.y = y
    self.z = z
end
function CameraMovementController.prototype.moveForward(self, delta)
    local velocity = self.speed * delta
    self.x = self.x + (self.dirXFlat * velocity)
    self.z = self.z + (self.dirZFlat * velocity)
end
function CameraMovementController.prototype.moveRight(self, delta)
    local velocity = self.speed * delta
    self.x = self.x + (self.dirZFlat * velocity)
    self.z = self.z - (self.dirXFlat * velocity)
end
function CameraMovementController.prototype.handleMouse(self, deltaYaw, deltaPitch)
    self.pitch = max(
        min(self.pitch + deltaPitch, 89),
        -89
    )
    self.yaw = self.yaw + deltaYaw
    local ____ = self
    local pitch = ____.pitch
    local yaw = ____.yaw
    local r_pitch = rad(pitch)
    local r_yaw = rad(yaw)
    local c_yaw = cos(r_yaw)
    local s_yaw = sin(r_yaw)
    local c_pitch = cos(r_pitch)
    local s_pitch = sin(r_pitch)
    self.dirX = c_yaw * c_pitch
    self.dirY = s_pitch
    self.dirZ = s_yaw * c_pitch
    self.dirXFlat = c_yaw
    self.dirZFlat = s_yaw
end
function CameraMovementController.prototype.resetPosition(self)
    self.x = 0
    self.y = 0
    self.z = 0
end
function CameraMovementController.prototype.tick(self, delta)
    if self.doMoveForward then
        self:moveForward(delta)
    end
    if self.doMoveBackward then
        self:moveForward(-delta)
    end
    if self.doMoveLeft then
        self:moveRight(-delta)
    end
    if self.doMoveRight then
        self:moveRight(delta)
    end
end
return ____exports
