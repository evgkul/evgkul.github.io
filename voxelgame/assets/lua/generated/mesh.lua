--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local sin = math.sin
local cos = math.cos
____exports.BasicNode = __TS__Class()
local BasicNode = ____exports.BasicNode
BasicNode.name = "BasicNode"
function BasicNode.prototype.____constructor(self)
    self.transform = newTransform3D()
    self.px = 0
    self.py = 0
    self.pz = 0
    self.rx = 0
    self.ry = 0
    self.rz = 0
    self.rw = 1
    self.sx = 1
    self.sy = 1
    self.sz = 1
    self:updateTransform()
end
function BasicNode.prototype.updateTransform(self)
    local t = self.transform
    t:reset()
    t:scale(self.sx, self.sy, self.sz)
    t:rotateQuat(self.rx, self.ry, self.rz, self.rw)
    t:translate(self.px, self.py, self.pz)
end
function BasicNode.prototype.setPosition(self, x, y, z)
    self.px = x
    self.py = y
    self.pz = z
    self:updateTransform()
end
function BasicNode.prototype.setRotationQuat(self, x, y, z, w)
    self.rx = x
    self.ry = y
    self.rz = z
    self.rw = w
    self:updateTransform()
end
function BasicNode.prototype.setRotationAxisAngle(self, angle, x, y, z)
    local s = math.sin(angle / 2)
    local qx = x * s
    local qy = y * s
    local qz = z * s
    local qw = math.cos(angle / 2)
    self:setRotationQuat(qx, qy, qz, qw)
end
function BasicNode.prototype.setRotationEuler(self, x, y, z)
    local yaw = z
    local pitch = y
    local roll = x
    local cy = cos(yaw * 0.5)
    local sy = sin(yaw * 0.5)
    local cp = cos(pitch * 0.5)
    local sp = sin(pitch * 0.5)
    local cr = cos(roll * 0.5)
    local sr = sin(roll * 0.5)
    local qw = ((cr * cp) * cy) + ((sr * sp) * sy)
    local qx = ((sr * cp) * cy) - ((cr * sp) * sy)
    local qy = ((cr * sp) * cy) + ((sr * cp) * sy)
    local qz = ((cr * cp) * sy) - ((sr * sp) * cy)
    self:setRotationQuat(qx, qy, qz, qw)
end
function BasicNode.prototype.setScale(self, x, y, z)
    self.sx = x
    self.sy = y
    self.sz = z
    self:updateTransform()
end
function BasicNode.prototype.draw(self, dcontext, camera)
end
____exports.Primitive = __TS__Class()
local Primitive = ____exports.Primitive
Primitive.name = "Primitive"
__TS__ClassExtends(Primitive, ____exports.BasicNode)
function Primitive.prototype.____constructor(self, vbuffer, program)
    Primitive.____super.prototype.____constructor(self)
    self.transform = newTransform3D()
    self.vbuffer = vbuffer
    self.program = program
end
function Primitive.prototype.draw(self, dcontext, camera)
    local pos = dcontext:transform(self.transform)
    self.program:draw(dcontext, self.vbuffer)
    dcontext:setTransformPos(pos)
end
____exports.GroupNode = __TS__Class()
local GroupNode = ____exports.GroupNode
GroupNode.name = "GroupNode"
__TS__ClassExtends(GroupNode, ____exports.BasicNode)
function GroupNode.prototype.____constructor(self)
    GroupNode.____super.prototype.____constructor(self)
    self.subnodes = {}
    self.named = {}
    self.named_nums = {}
    self.transform = newTransform3D()
end
function GroupNode.prototype.addNode(self, node)
    local pos = __TS__ArrayPush(self.subnodes, node) - 1
    local name = node.name
    if name then
        self.named[name] = node
        self.named_nums[name] = pos
    end
end
function GroupNode.prototype.addNodes(self, ...)
    local nodes = {...}
    for ____, node in ipairs(nodes) do
        self:addNode(node)
    end
end
function GroupNode.prototype.loadNamedInto(self, to)
    if self.name then
        to[self.name] = self
    end
    for ____, node in ipairs(self.subnodes) do
        if node.name then
            to[node.name] = node
        end
        if node.loadNamedInto ~= nil then
            node:loadNamedInto(to)
        end
    end
end
function GroupNode.prototype.loadNamed(self)
    local r = {}
    self:loadNamedInto(r)
    return r
end
function GroupNode.prototype.draw(self, dcontext, camera)
    local pos = dcontext:transform(self.transform)
    for ____, node in ipairs(self.subnodes) do
        node:draw(dcontext, camera)
    end
    dcontext:setTransformPos(pos)
end
return ____exports
