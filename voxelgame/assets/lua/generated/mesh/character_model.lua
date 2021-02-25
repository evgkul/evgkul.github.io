--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____fibers = require("fibers")
local wait = ____fibers.wait
local ____mesh = require("mesh.mesh")
local GroupNode = ____mesh.GroupNode
local ____mesh_utils = require("mesh.mesh_utils")
local cubeMesh = ____mesh_utils.cubeMesh
local cos = math.cos
local sin = math.sin
local rad = math.rad
local pi = math.pi
local acos = math.acos
local asin = math.asin
local abs = math.abs
local function cross(self, a1, a2, a3, b1, b2, b3)
    return (a2 * b3) - (a3 * b2), (a3 * b1) - (a1 * b3), (a1 * b2) - (a2 * b1)
end
local function dot(self, a1, a2, a3, b1, b2, b3)
    return ((a1 * b1) + (a2 * b2)) + (a3 * b3)
end
local _transform = newTransform3D()
local function setLookAt(self, obj, dx, dy, dz)
    _transform:reset()
    _transform:rotateByAxis(
        rad(90),
        0,
        1,
        0
    )
    _transform:lookAtDir(dx, dy, dz, 0, 1, 0)
    obj:setRotationQuat(
        _transform:toQuat()
    )
end
____exports.CharacterNode = __TS__Class()
local CharacterNode = ____exports.CharacterNode
CharacterNode.name = "CharacterNode"
__TS__ClassExtends(CharacterNode, GroupNode)
function CharacterNode.prototype.____constructor(self, ...)
    GroupNode.prototype.____constructor(self, ...)
    self.head = nil
    self.body = nil
    self.armR = nil
    self.armL = nil
    self.legL = nil
    self.legR = nil
    self.walkTime = 0
    self.doWalk = false
end
function CharacterNode.prototype.updateNodes(self)
    local ____ = self:loadNamed()
    local head = ____.head
    local body = ____.body
    local armR = ____.armR
    local armL = ____.armL
    local legL = ____.legL
    local legR = ____.legR
    log_debug("Leg", legR)
    __TS__ObjectAssign(self, {head = head, body = body, armR = armR, armL = armL, legL = legL, legR = legR})
end
function CharacterNode.prototype.animationStep(self, time)
    local ____ = self
    local doWalk = ____.doWalk
    local walkTime = ____.walkTime
    local legL = ____.legL
    local legR = ____.legR
    if doWalk or (walkTime > 0) then
        legL:setRotationEuler(
            0,
            0,
            sin(walkTime)
        )
        legR:setRotationEuler(
            0,
            0,
            -1 * sin(walkTime)
        )
        walkTime = walkTime + time
        if (not doWalk) and (((pi - (walkTime % pi)) - time) < 0.01) then
            self.walkTime = 0
            legL:setRotationEuler(0, 0, 0)
            legR:setRotationEuler(0, 0, 0)
        else
            self.walkTime = walkTime % (pi * 2)
        end
    end
end
function CharacterNode.prototype.setDirection(self, dx, dy, dz)
    setLookAt(nil, self.head, dx, dy, dz)
end
function CharacterNode.prototype.draw(self, dcontext, camera)
    self:animationStep(0.1)
    local cx, cy, cz = camera:getPos()
    GroupNode.prototype.draw(self, dcontext, camera)
end
local defaultLayout = {body = {{5 / 16, 5 / 16, 2 / 16, 3 / 16}, {8 / 16, 5 / 16, 2 / 16, 3 / 16}, {5 / 16, 4 / 16, 2 / 16, 1 / 16}, {7 / 16, 4 / 16, 2 / 16, 1 / 16}, {4 / 16, 5 / 16, 1 / 16, 3 / 16}, {7 / 16, 5 / 16, 1 / 16, 3 / 16}}, head = {{1 / 8, 1 / 8, 1 / 8, 1 / 8}, {3 / 8, 1 / 8, 1 / 8, 1 / 8}, {1 / 8, 0 / 8, 1 / 8, 1 / 8}, {2 / 8, 0 / 8, 1 / 8, 1 / 8}, {0 / 8, 1 / 8, 1 / 8, 1 / 8}, {2 / 8, 1 / 8, 1 / 8, 1 / 8}}, armR = {{11 / 16, 5 / 16, 1 / 16, 3 / 16}, {13 / 16, 5 / 16, 1 / 16, 3 / 16}, {11 / 16, 4 / 16, 1 / 16, 1 / 16}, {12 / 16, 4 / 16, 1 / 16, 1 / 16}, {10 / 16, 5 / 16, 1 / 16, 3 / 16}, {12 / 16, 5 / 16, 1 / 16, 3 / 16}}, armL = {{(-2 / 16) + (11 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(-2 / 16) + (13 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(-2 / 16) + (11 / 16), (8 / 16) + (4 / 16), 1 / 16, 1 / 16}, {(-2 / 16) + (12 / 16), (8 / 16) + (4 / 16), 1 / 16, 1 / 16}, {(-2 / 16) + (10 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(-2 / 16) + (12 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}}, legL = {{(4 / 16) + (1 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(4 / 16) + (3 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(4 / 16) + (1 / 16), (8 / 16) + (4 / 16), 1 / 16, 1 / 16}, {(4 / 16) + (2 / 16), (8 / 16) + (4 / 16), 1 / 16, 1 / 16}, {(4 / 16) + (0 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(4 / 16) + (2 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}}, legR = {{1 / 16, 5 / 16, 1 / 16, 3 / 16}, {3 / 16, 5 / 16, 1 / 16, 3 / 16}, {1 / 16, 4 / 16, 1 / 16, 1 / 16}, {2 / 16, 4 / 16, 1 / 16, 1 / 16}, {0 / 16, 5 / 16, 1 / 16, 3 / 16}, {2 / 16, 5 / 16, 1 / 16, 3 / 16}}}
local kenneyNLLayout = {body = {{476 / 1024, 404 / 1024, 148 / 1024, 220 / 1024}, {((476 / 1024) + (148 / 1024)) + (70 / 1024), 404 / 1024, 148 / 1024, 220 / 1024}, {476 / 1024, 330 / 1024, 148 / 1024, 74 / 1024}, {476 / 1024, 624 / 1024, 148 / 1024, 74 / 1024}, {(476 / 1024) - (70 / 1024), 404 / 1024, 70 / 1024, 220 / 1024}, {624 / 1024, 404 / 1024, 70 / 1024, 220 / 1024}}, head = {{(70 / 1024) + (148 / 1024), 158 / 1024, 148 / 1024, 148 / 1024}, {(70 / 1024) + ((148 / 1024) * 3), 158 / 1024, 148 / 1024, 148 / 1024}, {(70 / 1024) + (148 / 1024), (158 / 1024) - (148 / 1024), 148 / 1024, 148 / 1024}, {(70 / 1024) + (148 / 1024), (158 / 1024) + (148 / 1024), 148 / 1024, 148 / 1024}, {70 / 1024, 158 / 1024, 148 / 1024, 148 / 1024}, {(70 / 1024) + ((148 / 1024) * 2), 158 / 1024, 148 / 1024, 148 / 1024}}, armR = {{112 / 1024, 480 / 1024, 74 / 1024, 215 / 1024}, {((112 / 1024) + (74 / 1024)) + (70 / 1024), 480 / 1024, 74 / 1024, 215 / 1024}, {112 / 1024, (480 / 1024) - (70 / 1024), 74 / 1024, 70 / 1024}, {112 / 1024, (480 / 1024) + (215 / 1024), 74 / 1024, 70 / 1024}, {(112 / 1024) - (70 / 1024), 480 / 1024, 70 / 1024, 215 / 1024}, {(112 / 1024) + (74 / 1024), 480 / 1024, 70 / 1024, 215 / 1024}}, armL = {{852 / 1024, 92 / 1024, 74 / 1024, 215 / 1024}, {((852 / 1024) - (74 / 1024)) - (70 / 1024), 92 / 1024, 74 / 1024, 215 / 1024}, {852 / 1024, (92 / 1024) - (70 / 1024), 74 / 1024, 70 / 1024}, {852 / 1024, (92 / 1024) + (215 / 1024), 74 / 1024, 70 / 1024}, {(852 / 1024) - (70 / 1024), 92 / 1024, 70 / 1024, 215 / 1024}, {(852 / 1024) + (74 / 1024), 92 / 1024, 70 / 1024, 215 / 1024}}, legR = {{354 / 1024, 726 / 1024, 76 / 1024, 217 / 1024}, {((354 / 1024) + (76 / 1024)) + (70 / 1024), 726 / 1024, 76 / 1024, 217 / 1024}, {354 / 1024, (726 / 1024) - (70 / 1024), 76 / 1024, 70 / 1024}, {354 / 1024, (726 / 1024) + (215 / 1024), 76 / 1024, 70 / 1024}, {(354 / 1024) - (70 / 1024), 726 / 1024, 76 / 1024, 217 / 1024}, {(354 / 1024) + (76 / 1024), 726 / 1024, 76 / 1024, 217 / 1024}}, legL = {{856 / 1024, 704 / 1024, 76 / 1024, 217 / 1024}, {((856 / 1024) - (76 / 1024)) - (70 / 1024), 704 / 1024, 76 / 1024, 217 / 1024}, {856 / 1024, (704 / 1024) - (70 / 1024), 76 / 1024, 70 / 1024}, {856 / 1024, (704 / 1024) + (215 / 1024), 76 / 1024, 70 / 1024}, {(856 / 1024) - (70 / 1024), 704 / 1024, 76 / 1024, 217 / 1024}, {(856 / 1024) + (76 / 1024), 704 / 1024, 76 / 1024, 217 / 1024}}}
____exports.SkinLoader = __TS__Class()
local SkinLoader = ____exports.SkinLoader
SkinLoader.name = "SkinLoader"
function SkinLoader.prototype.____constructor(self)
end
function ____exports.testCharacter(self)
    local l = kenneyNLLayout
    local skin_img = wait(
        nil,
        assets:loadImage("textures/kenney_skins/skin_orc.png")
    )
    local skin_tex = newTexture(skin_img)
    local color_code = 0
    local ymul = 1
    local function node(self, name, tx, ty, tz, sx, sy, sz)
        local res = __TS__New(GroupNode)
        res.name = name
        local mesh = cubeMesh(nil, tx, ty, tz, sx, sy, sz, l[name])
        mesh.program:setVec4("color", color_code / 8, (8 - color_code) / 8, 0, 1)
        mesh.program:setTexture("tex", skin_tex)
        res:addNode(mesh)
        color_code = color_code + 1
        return res
    end
    local res = __TS__New(____exports.CharacterNode)
    local bx = 0.25
    local by = 0.75
    local bz = 0.5
    local body = node(nil, "body", -bx / 2, -by / 2, -bz / 2, bx, by, bz)
    local hx = 0.5
    local hy = 0.5
    local hz = 0.5
    local head = node(nil, "head", -hx / 2, 0, -hz / 2, hx, hy, hz)
    head:setPosition(0, by / 2, 0)
    local ax = 0.25
    local ay = 0.75
    local az = 0.25
    local arm_r = node(nil, "armR", -ax, -ay, -az, ax, ay, az)
    arm_r:setRotationEuler(
        math.rad(-10),
        0,
        math.rad(45)
    )
    arm_r:setPosition(0, by / 2, (bz / 2) + az)
    local arm_l = node(nil, "armL", -ax / 2, -ay, -az, ax, ay, az)
    arm_l:setRotationEuler(
        math.rad(10),
        0,
        0
    )
    arm_l:setPosition(0, by / 2, -bz / 2)
    local lx = 0.25
    local ly = 0.75
    local lz = 0.25 - 0.0001
    local leg_l = node(nil, "legL", -lx / 2, -ly, -lz / 2, lx, ly, lz)
    leg_l:setPosition(0, -by / 2, -lz / 2)
    local leg_r = node(nil, "legR", -lx / 2, -ly, -lz / 2, lx, ly, lz)
    leg_r:setPosition(0, -by / 2, lz / 2)
    res:addNodes(head)
    res:addNodes(body)
    res:addNodes(arm_r, arm_l)
    res:addNodes(leg_l, leg_r)
    res:updateNodes()
    return res
end
return ____exports
