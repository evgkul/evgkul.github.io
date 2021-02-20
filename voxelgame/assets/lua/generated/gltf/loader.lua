--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____base64 = require("base64")
local decode = ____base64.decode
local ____unpack = string.unpack
local byte = string.byte
local function iterateIndices(self, a)
    local raw = a.raw
    local count = a.count
    local size = 2
    local i = 0
    return function(self)
        if i >= count then
            return nil
        end
        local b = string.byte(raw, 1 + (i * size))
        local b2 = string.byte(raw, (1 + (i * size)) + 1)
        i = i + 1
        return b + (b2 * 256)
    end
end
local function readZeroVec2(self, pos)
    return 0, 0
end
local function readZeroVec3(self, pos)
    return 0, 0, 0
end
local function readZeroVec4(self, pos)
    return 0, 0, 0, 0
end
local ACCESSOR_TYPE_SIZES = {SCALAR = 1, VEC2 = 2, VEC3 = 3, VEC4 = 4, MAT2 = 4, MAT3 = 9, MAT4 = 16}
local COMPONENT_TYPE_SIZES = {[5120] = 1, [5121] = 1, [5122] = 2, [5123] = 2, [5125] = 4, [5126] = 4}
____exports.GLTFLoader = __TS__Class()
local GLTFLoader = ____exports.GLTFLoader
GLTFLoader.name = "GLTFLoader"
function GLTFLoader.prototype.____constructor(self, model, loader)
    self.buffers = {}
    self.data = JSON:parse(model)
    for ____, bufdef in ipairs(self.data.buffers or ({})) do
        local val = ""
        local uri = bufdef.uri or "DEFAULT"
        if __TS__StringStartsWith(uri, "data:") then
            local spl = (string.find(uri, "base64,", nil, true) or 0) - 1
            if spl == -1 then
                error("Invalid data URI!", 0)
            end
            local p = __TS__StringSubstr(uri, spl + #"base64,")
            val = decode(p)
        else
            val = loader(nil, uri)
        end
        __TS__ArrayPush(self.buffers, val)
    end
end
function GLTFLoader.prototype.accessor(self, idx)
    if idx then
        local a = (self.data.accessors or ({}))[idx + 1]
        local raw_bufview = (self.data.bufferViews or ({}))[(a.bufferView or error("Invalid accessor")) + 1]
        local realsize = COMPONENT_TYPE_SIZES[a.componentType] * ACCESSOR_TYPE_SIZES[a.type]
        local raw = __TS__StringSubstr(self.buffers[raw_bufview.buffer + 1], (raw_bufview.byteOffset or 0) + (a.byteOffset or 0), raw_bufview.byteLength)
        local stride = raw_bufview.byteStride or realsize
        if stride ~= realsize then
            local tmp = {}
            for i = 0, a.count - 1 do
                __TS__ArrayPush(
                    tmp,
                    __TS__StringSubstr(raw, i * stride, realsize)
                )
            end
            raw = table.concat(tmp, "" or ",")
        end
        return __TS__ObjectAssign({raw = raw, raw_bufview = raw_bufview}, a)
    end
end
function GLTFLoader.prototype.readNum(self, accessor_idx)
    local data = self:accessor(accessor_idx)
    if data == nil then
        return function() return 0 end
    else
        local raw = data.raw
        local ty = data.componentType
        if ty == 5126 then
            return function(____, pos)
                local n = ____unpack("> f", raw, 1 + (pos * 4))
                return n
            end
        elseif ty == 5123 then
            return function(____, pos)
                local p = 1 + (pos * 2)
                return byte(raw, p) + (byte(raw, p + 1) * 256)
            end
        elseif ty == 5121 then
            return function(____, pos) return byte(raw, 1 + pos) end
        else
            error(
                (("Unsupported component type at accessor " .. tostring(accessor_idx)) .. ": ") .. tostring(ty),
                0
            )
        end
    end
end
function GLTFLoader.prototype.readVec2(self, accessor_idx)
    local data = self:accessor(accessor_idx)
    if data == nil then
        return readZeroVec2
    else
        local raw = data.raw
        if data.type ~= "VEC2" then
            error(
                "Invalid accessor type! Expected VEC2, got " .. tostring(data.type),
                0
            )
        end
        local ty = data.componentType
        if ty == 5126 then
            local function read(self, pos)
                local x, y = ____unpack("< ff", raw, 1 + (pos * 8))
                return x, y
            end
            return read
        else
            local reader = self:readNum(accessor_idx)
            local function read(self, pos)
                local n = pos * 2
                local x = reader(nil, n)
                local y = reader(nil, n + 1)
                return x, y
            end
            return read
        end
    end
end
function GLTFLoader.prototype.readVec3(self, accessor_idx)
    local data = self:accessor(accessor_idx)
    if data == nil then
        return readZeroVec3
    else
        local raw = data.raw
        if data.type ~= "VEC3" then
            error(
                "Invalid accessor type! Expected VEC3, got " .. tostring(data.type),
                0
            )
        end
        local ty = data.componentType
        if ty == 5126 then
            local function read(self, pos)
                local x, y, z = ____unpack("< fff", raw, 1 + (pos * 12))
                return x, y, z
            end
            return read
        else
            local reader = self:readNum(accessor_idx)
            local function read(self, pos)
                local n = pos * 3
                local x = reader(nil, n)
                local y = reader(nil, n + 1)
                local z = reader(nil, n + 2)
                return x, y, z
            end
            return read
        end
    end
end
function GLTFLoader.prototype.readVec4(self, accessor_idx)
    local data = self:accessor(accessor_idx)
    if data == nil then
        return readZeroVec4
    else
        local raw = data.raw
        if data.type ~= "VEC4" then
            error(
                "Invalid accessor type! Expected VEC4, got " .. tostring(data.type),
                0
            )
        end
        local ty = data.componentType
        if ty == 5126 then
            local function read(self, pos)
                local x, y, z, w = ____unpack("< ffff", raw, 1 + (pos * 16))
                return x, y, z, w
            end
            return read
        else
            local reader = self:readNum(accessor_idx)
            local function read(self, pos)
                local n = pos * 4
                local x = reader(nil, n)
                local y = reader(nil, n + 1)
                local z = reader(nil, n + 2)
                local w = reader(nil, n + 3)
                return x, y, z, w
            end
            return read
        end
    end
end
function GLTFLoader.prototype.loadPrimitiveVertices(self, prim)
    local indices = prim.indices and self:accessor(prim.indices)
    local positions = self:accessor(prim.attributes.POSITION)
    if positions == nil then
        error("Primitive without positions")
    end
    local positions_reader = self:readVec3(prim.attributes.POSITION)
    local indices_reader = self:readNum(prim.indices)
    local count = (indices and indices.count) or positions.count
    local texcoords_reader = self:readVec2(prim.attributes.TEXCOORD_0)
    local normals_reader = self:readVec3(prim.attributes.NORMAL)
    local joints = self:accessor(prim.attributes.JOINTS_0)
    local joints_reader = self:readVec4(prim.attributes.JOINTS_0)
    local weights_reader = self:readVec4(prim.attributes.WEIGHTS_0)
    local els = 3
    local i = 0
    local function iter(self)
        if i >= count then
            return
        end
        local ind = 0
        local x = 0
        local y = 0
        local z = 0
        local nx = 0
        local ny = 0
        local nz = 0
        local u = 0
        local v = 0
        local j1 = 0
        local j2 = 0
        local j3 = 0
        local j4 = 0
        local w1 = 0
        local w2 = 0
        local w3 = 0
        local w4 = 0
        if indices then
            ind = indices_reader(nil, i)
        else
            ind = i
        end
        x, y, z = positions_reader(nil, ind)
        nx, ny, nz = normals_reader(nil, ind)
        u, v = texcoords_reader(nil, ind)
        j1, j2, j3, j4 = joints_reader(nil, ind)
        w1, w2, w3, w4 = weights_reader(nil, ind)
        i = i + 1
        return x, y, z, nx, ny, nz, u, v, j1, j2, j3, j4, w1, w2, w3, w4
    end
    return iter
end
function GLTFLoader.prototype.loadRiggedVertexBuffer(self, prim)
    local t = {}
    for x, y, z, nx, ny, nz, u, v, j1, j2, j3, j4, w1, w2, w3, w4 in self:loadPrimitiveVertices(prim) do
        __TS__ArrayPush(t, x, y, z, nx, ny, nz, u, v, j1, j2, j3, j4, w1, w2, w3, w4)
    end
    return newVertexBuffer(t, {2, 2, 1, 3, 3})
end
return ____exports
