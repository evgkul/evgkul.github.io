--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____mesh = require("mesh.mesh")
local Primitive = ____mesh.Primitive
local ____cube_gen = require("mesh.cube_gen")
local buildCubeMesh = ____cube_gen.buildCubeMesh
local ____basic_program = require("mesh.basic_program")
local basicProgram = ____basic_program.basicProgram
function ____exports.cubeMesh(self, tx, ty, tz, sx, sy, sz, uv)
    if tx == nil then
        tx = 0
    end
    if ty == nil then
        ty = 0
    end
    if tz == nil then
        tz = 0
    end
    if sx == nil then
        sx = 1
    end
    if sy == nil then
        sy = 1
    end
    if sz == nil then
        sz = 1
    end
    if uv == nil then
        uv = {0, 0, 1, 1}
    end
    local testVBuffer = buildCubeMesh(nil, tx, ty, tz, sx, sy, sz, uv)
    local inst = basicProgram:inst()
    inst:setVec4("color", 1, 0, 0, 1)
    local m = __TS__New(Primitive, testVBuffer, inst)
    return m
end
____exports.SkinHolder = __TS__Class()
local SkinHolder = ____exports.SkinHolder
SkinHolder.name = "SkinHolder"
function SkinHolder.prototype.____constructor(self, loader)
    self.skins = {}
    self.named_idx = {}
    self.named_transforms = {}
    local nodes = loader.data.nodes or ({})
    local transform_amount = 0
    self.transforms = {}
    for ____, skin in ipairs(loader.data.skins or ({})) do
        local obj = __TS__ObjectAssign({tex_offset = transform_amount}, skin)
        __TS__ArrayPush(self.skins, obj)
        for ____, node_idx in ipairs(skin.joints) do
            local t = newTransform3D()
            __TS__ArrayPush(self.transforms, t)
            local node = nodes[node_idx + 1]
            local name = node.name
            if name then
                self.named_idx[name] = #self.transforms - 1
                self.named_transforms[name] = t
            end
        end
        transform_amount = transform_amount + #skin.joints
    end
    self.transforms_tex = newTexture(nil, 4, transform_amount, 11)
    self:updateTransforms()
end
function SkinHolder.prototype.updateTransforms(self)
    local tex = self.transforms_tex
    local i = 0
    for ____, transform in ipairs(self.transforms) do
        tex:loadTransform(0, i, transform)
        i = i + 1
    end
end
return ____exports
