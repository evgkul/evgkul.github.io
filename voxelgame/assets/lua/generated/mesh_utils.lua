--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____mesh = require("mesh")
local Primitive = ____mesh.Primitive
local GroupNode = ____mesh.GroupNode
local ____loader = require("gltf.loader")
local GLTFLoader = ____loader.GLTFLoader
local ____fibers = require("fibers")
local wait = ____fibers.wait
local tvertex = "#version 300 es\nlayout (location = 0) in vec3 aPos;\nlayout (location = 1) in vec3 aNormal;\nlayout (location = 2) in vec2 aTex;\nlayout (location = 3) in vec4 aJoints;\nlayout (location = 4) in vec4 aWeights;\n\nuniform mat4 model;\nuniform mat4 view;\nuniform mat4 projection;\nuniform sampler2D u_jointTexture;\nuniform float u_jointOffset;\nout vec2 tex;\nout vec3 normal;\n\n\nmat4 getBoneMatrix(uint jointNdx) {\n  int jointNdx2 = int(jointNdx);\n  return mat4(\n    texelFetch(u_jointTexture, ivec2(0, jointNdx2), 0),\n    texelFetch(u_jointTexture, ivec2(1, jointNdx2), 0),\n    texelFetch(u_jointTexture, ivec2(2, jointNdx2), 0),\n    texelFetch(u_jointTexture, ivec2(3, jointNdx2), 0));\n}\n\nvoid main()\n{\n  mat4 skinMatrix = \n    getBoneMatrix(uint(u_jointOffset+aJoints[0])) * aWeights[0] +\n    getBoneMatrix(uint(u_jointOffset+aJoints[1])) * aWeights[1] +\n    getBoneMatrix(uint(u_jointOffset+aJoints[2])) * aWeights[2] +\n    getBoneMatrix(uint(u_jointOffset+aJoints[3])) * aWeights[3] +\n    mat4(1.0) * (1.0-aWeights[0]-aWeights[1]-aWeights[2]-aWeights[3])\n  ;\n  tex = aTex;\n  normal = aNormal;\n  //normal = aJoints.xyz / 4.0 * 2. - 1.;\n  //normal = aWeights.xyz * 2. - 1.;\n  gl_Position = projection * view * (model * skinMatrix ) * vec4(aPos.x, aPos.y, aPos.z, 1.0);\n}"
local tfragment = "#version 300 es\nprecision mediump float;\nin vec2 tex;\nin vec3 normal;\n\nout vec4 FragColor;\n\nvoid main()\n{\n  FragColor = vec4(1.0,0.0,0.0,1.0);\n  //FragColor = vec4(normalize(normal) * .5 + .5, 1.0f);\n}"
local tvertex2 = "#version 300 es\nlayout (location = 0) in vec3 aPos;\nlayout (location = 1) in vec2 aTex;\n\nuniform mat4 model;\nuniform mat4 view;\nuniform mat4 projection;\nout vec2 texpos;\nout vec3 normal;\n\n\nvoid main()\n{\n  texpos = aTex;\n  //normal = aNormal;\n  //normal = aJoints.xyz / 4.0 * 2. - 1.;\n  //normal = aWeights.xyz * 2. - 1.;\n  gl_Position = projection * view * model * vec4(aPos.x, aPos.y, aPos.z, 1.0);\n}"
local tfragment2 = "#version 300 es\nprecision mediump float;\nin vec2 texpos;\nin vec3 normal;\nuniform vec4 color;\nuniform sampler2D tex;\n\nout vec4 FragColor;\n\nvoid main()\n{\n  //FragColor = color;\n  //FragColor = vec4(normalize(normal) * .5 + .5, 1.0f);\n  FragColor = texture(tex,texpos);\n  //FragColor = vec4(texpos,0.0,1.0);\n}"
local tprogram = newDynProgram({{name = "tvertex.vert", code = tvertex, kind = "vertex"}, {name = "tvertex.frag", code = tfragment, kind = "fragment"}}, {depth_func = "Always", depth_write = true, face_culling = "None"})
local tprogram2 = newDynProgram({{name = "tvertex2.vert", code = tvertex2, kind = "vertex"}, {name = "tvertex2.frag", code = tfragment2, kind = "fragment"}}, {depth_func = "LessEqual", depth_write = true, face_culling = "Back"})
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
    local uvdata
    if type(uv[1]) == "number" then
        local uvp = uv
        uvdata = {uvp, uvp, uvp, uvp, uvp, uvp}
    else
        uvdata = uv
    end
    local uvPX, uvNX, uvPY, uvNY, uvPZ, uvNZ = unpack(uvdata)
    local cubeStruct = {2, 1}
    local cubeVertices = {tx + (0 * sx), ty + (0 * sy), tz + (0 * sz), uvNZ[1] + (1 * uvNZ[3]), uvNZ[2] + (1 * uvNZ[4]), tx + (1 * sx), ty + (1 * sy), tz + (0 * sz), uvNZ[1] + (0 * uvNZ[3]), uvNZ[2] + (0 * uvNZ[4]), tx + (1 * sx), ty + (0 * sy), tz + (0 * sz), uvNZ[1] + (0 * uvNZ[3]), uvNZ[2] + (1 * uvNZ[4]), tx + (0 * sx), ty + (1 * sy), tz + (0 * sz), uvNZ[1] + (1 * uvNZ[3]), uvNZ[2] + (0 * uvNZ[4]), tx + (1 * sx), ty + (1 * sy), tz + (0 * sz), uvNZ[1] + (0 * uvNZ[3]), uvNZ[2] + (0 * uvNZ[4]), tx + (0 * sx), ty + (0 * sy), tz + (0 * sz), uvNZ[1] + (1 * uvNZ[3]), uvNZ[2] + (1 * uvNZ[4]), tx + (0 * sx), ty + (0 * sy), tz + (1 * sz), uvPZ[1] + (0 * uvPZ[3]), uvPZ[2] + (1 * uvPZ[4]), tx + (1 * sx), ty + (0 * sy), tz + (1 * sz), uvPZ[1] + (1 * uvPZ[3]), uvPZ[2] + (1 * uvPZ[4]), tx + (1 * sx), ty + (1 * sy), tz + (1 * sz), uvPZ[1] + (1 * uvPZ[3]), uvPZ[2] + (0 * uvPZ[4]), tx + (1 * sx), ty + (1 * sy), tz + (1 * sz), uvPZ[1] + (1 * uvPZ[3]), uvPZ[2] + (0 * uvPZ[4]), tx + (0 * sx), ty + (1 * sy), tz + (1 * sz), uvPZ[1] + (0 * uvPZ[3]), uvPZ[2] + (0 * uvPZ[4]), tx + (0 * sx), ty + (0 * sy), tz + (1 * sz), uvPZ[1] + (0 * uvPZ[3]), uvPZ[2] + (1 * uvPZ[4]), tx + (0 * sx), ty + (1 * sy), tz + (1 * sz), uvNX[1] + (1 * uvNX[3]), uvNX[2] + (0 * uvNX[4]), tx + (0 * sx), ty + (1 * sy), tz + (0 * sz), uvNX[1] + (0 * uvNX[3]), uvNX[2] + (0 * uvNX[4]), tx + (0 * sx), ty + (0 * sy), tz + (0 * sz), uvNX[1] + (0 * uvNX[3]), uvNX[2] + (1 * uvNX[4]), tx + (0 * sx), ty + (0 * sy), tz + (0 * sz), uvNX[1] + (0 * uvNX[3]), uvNX[2] + (1 * uvNX[4]), tx + (0 * sx), ty + (0 * sy), tz + (1 * sz), uvNX[1] + (1 * uvNX[3]), uvNX[2] + (1 * uvNX[4]), tx + (0 * sx), ty + (1 * sy), tz + (1 * sz), uvNX[1] + (1 * uvNX[3]), uvNX[2] + (0 * uvNX[4]), tx + (1 * sx), ty + (1 * sy), tz + (1 * sz), uvPX[1] + (0 * uvPX[3]), uvPX[2] + (0 * uvPX[4]), tx + (1 * sx), ty + (0 * sy), tz + (0 * sz), uvPX[1] + (1 * uvPX[3]), uvPX[2] + (1 * uvPX[4]), tx + (1 * sx), ty + (1 * sy), tz + (0 * sz), uvPX[1] + (1 * uvPX[3]), uvPX[2] + (0 * uvPX[4]), tx + (1 * sx), ty + (0 * sy), tz + (1 * sz), uvPX[1] + (0 * uvPX[3]), uvPX[2] + (1 * uvPX[4]), tx + (1 * sx), ty + (0 * sy), tz + (0 * sz), uvPX[1] + (1 * uvPX[3]), uvPX[2] + (1 * uvPX[4]), tx + (1 * sx), ty + (1 * sy), tz + (1 * sz), uvPX[1] + (0 * uvPX[3]), uvPX[2] + (0 * uvPX[4]), tx + (0 * sx), ty + (0 * sy), tz + (0 * sz), uvNY[1] + (1 * uvNY[3]), uvNY[2] + (1 * uvNY[4]), tx + (1 * sx), ty + (0 * sy), tz + (0 * sz), uvNY[1] + (1 * uvNY[3]), uvNY[2] + (0 * uvNY[4]), tx + (1 * sx), ty + (0 * sy), tz + (1 * sz), uvNY[1] + (0 * uvNY[3]), uvNY[2] + (0 * uvNY[4]), tx + (1 * sx), ty + (0 * sy), tz + (1 * sz), uvNY[1] + (0 * uvNY[3]), uvNY[2] + (0 * uvNY[4]), tx + (0 * sx), ty + (0 * sy), tz + (1 * sz), uvNY[1] + (0 * uvNY[3]), uvNY[2] + (1 * uvNY[4]), tx + (0 * sx), ty + (0 * sy), tz + (0 * sz), uvNY[1] + (1 * uvNY[3]), uvNY[2] + (1 * uvNY[4]), tx + (0 * sx), ty + (1 * sy), tz + (0 * sz), uvPY[1] + (1 * uvPY[3]), uvPY[2] + (0 * uvPY[4]), tx + (1 * sx), ty + (1 * sy), tz + (1 * sz), uvPY[1] + (0 * uvPY[3]), uvPY[2] + (1 * uvPY[4]), tx + (1 * sx), ty + (1 * sy), tz + (0 * sz), uvPY[1] + (1 * uvPY[3]), uvPY[2] + (1 * uvPY[4]), tx + (0 * sx), ty + (1 * sy), tz + (1 * sz), uvPY[1] + (0 * uvPY[3]), uvPY[2] + (0 * uvPY[4]), tx + (1 * sx), ty + (1 * sy), tz + (1 * sz), uvPY[1] + (0 * uvPY[3]), uvPY[2] + (1 * uvPY[4]), tx + (0 * sx), ty + (1 * sy), tz + (0 * sz), uvPY[1] + (1 * uvPY[3]), uvPY[2] + (0 * uvPY[4])}
    local testVBuffer = newVertexBuffer(cubeVertices, cubeStruct)
    local inst = tprogram2:inst()
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
____exports.SkinnedPrimitive = __TS__Class()
local SkinnedPrimitive = ____exports.SkinnedPrimitive
SkinnedPrimitive.name = "SkinnedPrimitive"
__TS__ClassExtends(SkinnedPrimitive, Primitive)
function SkinnedPrimitive.prototype.____constructor(self, loader, node, mesh, prim, holder)
    local m = loader:loadRiggedVertexBuffer(prim)
    local prg = tprogram:inst()
    Primitive.prototype.____constructor(self, m, prg)
    self.skinholder = holder
    local skin = holder.skins[(node.skin or 0) + 1]
    prg:setTexture("u_jointTexture", self.skinholder.transforms_tex)
    prg:setFloat("u_jointOffset", skin.tex_offset)
end
function SkinnedPrimitive.prototype.updateTransforms(self)
    self.skinholder:updateTransforms()
end
function ____exports.testMesh(self)
    local def = wait(
        nil,
        assets:loadAsset("models/basicCharacterRigged/a2.gltf")
    )
    local function l(self, name)
        local data = wait(
            nil,
            assets:loadAsset(
                "models/basicCharacterRigged/" .. tostring(name)
            )
        )
        return data
    end
    local loader = __TS__New(GLTFLoader, def, l)
    local res = __TS__New(GroupNode)
    res.transform:scale(10, 10, 10)
    local gmeshes = loader.data.meshes or ({})
    local gnodes = loader.data.nodes or ({})
    local holder = __TS__New(____exports.SkinHolder, loader)
    local named = {}
    local function loadNode(self, node, to)
        local res = __TS__New(GroupNode)
        local name = node.name
        res.name = name
        if name then
            named[name] = res
        end
        local translation = node.translation
        local rotation = node.rotation
        local scale = node.scale
        if node.name == "Head1" then
            local cube = ____exports.cubeMesh(nil)
            cube:setScale(0.01, 0.01, 0.1)
            res:addNode(cube)
        end
        if translation then
            res:setPosition(translation[1], translation[2], translation[3])
        end
        local mesh_idx = node.mesh
        if mesh_idx then
            local gmesh = gmeshes[mesh_idx + 1]
            for ____, prim in ipairs(gmesh.primitives) do
                local p = __TS__New(____exports.SkinnedPrimitive, loader, node, gmesh, prim, holder)
                res:addNode(p)
            end
        end
        for ____, child in ipairs(node.children or ({})) do
            loadNode(nil, gnodes[child + 1], res)
        end
        to:addNode(res)
    end
    local gscene = loader.data.scene
    if gscene then
        local scene = (loader.data.scenes or ({}))[gscene + 1]
        for ____, node_idx in ipairs(scene.nodes) do
            loadNode(nil, gnodes[node_idx + 1], res)
        end
    end
    holder:updateTransforms()
    local r2 = __TS__New(GroupNode)
    r2:addNode(res)
    return r2
end
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
    self.doWalk = camera:isMoving()
    self:animationStep(0.1)
    self:setDirection(
        camera:getDir()
    )
    local cx, cy, cz = camera:getPos()
    self:setPosition(cx, (cy - (0.75 / 2)) - 0.25, cz)
    GroupNode.prototype.draw(self, dcontext, camera)
end
local defaultLayout = {body = {{5 / 16, 5 / 16, 2 / 16, 3 / 16}, {8 / 16, 5 / 16, 2 / 16, 3 / 16}, {5 / 16, 4 / 16, 2 / 16, 1 / 16}, {7 / 16, 4 / 16, 2 / 16, 1 / 16}, {4 / 16, 5 / 16, 1 / 16, 3 / 16}, {7 / 16, 5 / 16, 1 / 16, 3 / 16}}, head = {{1 / 8, 1 / 8, 1 / 8, 1 / 8}, {3 / 8, 1 / 8, 1 / 8, 1 / 8}, {1 / 8, 0 / 8, 1 / 8, 1 / 8}, {2 / 8, 0 / 8, 1 / 8, 1 / 8}, {0 / 8, 1 / 8, 1 / 8, 1 / 8}, {2 / 8, 1 / 8, 1 / 8, 1 / 8}}, armR = {{11 / 16, 5 / 16, 1 / 16, 3 / 16}, {13 / 16, 5 / 16, 1 / 16, 3 / 16}, {11 / 16, 4 / 16, 1 / 16, 1 / 16}, {12 / 16, 4 / 16, 1 / 16, 1 / 16}, {10 / 16, 5 / 16, 1 / 16, 3 / 16}, {12 / 16, 5 / 16, 1 / 16, 3 / 16}}, armL = {{(-2 / 16) + (11 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(-2 / 16) + (13 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(-2 / 16) + (11 / 16), (8 / 16) + (4 / 16), 1 / 16, 1 / 16}, {(-2 / 16) + (12 / 16), (8 / 16) + (4 / 16), 1 / 16, 1 / 16}, {(-2 / 16) + (10 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(-2 / 16) + (12 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}}, legL = {{(4 / 16) + (1 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(4 / 16) + (3 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(4 / 16) + (1 / 16), (8 / 16) + (4 / 16), 1 / 16, 1 / 16}, {(4 / 16) + (2 / 16), (8 / 16) + (4 / 16), 1 / 16, 1 / 16}, {(4 / 16) + (0 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}, {(4 / 16) + (2 / 16), (8 / 16) + (5 / 16), 1 / 16, 3 / 16}}, legR = {{1 / 16, 5 / 16, 1 / 16, 3 / 16}, {3 / 16, 5 / 16, 1 / 16, 3 / 16}, {1 / 16, 4 / 16, 1 / 16, 1 / 16}, {2 / 16, 4 / 16, 1 / 16, 1 / 16}, {0 / 16, 5 / 16, 1 / 16, 3 / 16}, {2 / 16, 5 / 16, 1 / 16, 3 / 16}}}
local kenneyNLLayout = {body = {{476 / 1024, 404 / 1024, 148 / 1024, 220 / 1024}, {((476 / 1024) + (148 / 1024)) + (70 / 1024), 404 / 1024, 148 / 1024, 220 / 1024}, {476 / 1024, 330 / 1024, 148 / 1024, 74 / 1024}, {476 / 1024, 624 / 1024, 148 / 1024, 74 / 1024}, {(476 / 1024) - (70 / 1024), 404 / 1024, 70 / 1024, 220 / 1024}, {624 / 1024, 404 / 1024, 70 / 1024, 220 / 1024}}, head = {{(70 / 1024) + (148 / 1024), 158 / 1024, 148 / 1024, 148 / 1024}, {(70 / 1024) + ((148 / 1024) * 3), 158 / 1024, 148 / 1024, 148 / 1024}, {(70 / 1024) + (148 / 1024), (158 / 1024) - (148 / 1024), 148 / 1024, 148 / 1024}, {(70 / 1024) + (148 / 1024), (158 / 1024) + (148 / 1024), 148 / 1024, 148 / 1024}, {70 / 1024, 158 / 1024, 148 / 1024, 148 / 1024}, {(70 / 1024) + ((148 / 1024) * 2), 158 / 1024, 148 / 1024, 148 / 1024}}, armR = {{112 / 1024, 480 / 1024, 74 / 1024, 215 / 1024}, {((112 / 1024) + (74 / 1024)) + (70 / 1024), 480 / 1024, 74 / 1024, 215 / 1024}, {112 / 1024, (480 / 1024) - (70 / 1024), 74 / 1024, 70 / 1024}, {112 / 1024, (480 / 1024) + (215 / 1024), 74 / 1024, 70 / 1024}, {(112 / 1024) - (70 / 1024), 480 / 1024, 70 / 1024, 215 / 1024}, {(112 / 1024) + (74 / 1024), 480 / 1024, 70 / 1024, 215 / 1024}}, armL = {{852 / 1024, 92 / 1024, 74 / 1024, 215 / 1024}, {((852 / 1024) - (74 / 1024)) - (70 / 1024), 92 / 1024, 74 / 1024, 215 / 1024}, {852 / 1024, (92 / 1024) - (70 / 1024), 74 / 1024, 70 / 1024}, {852 / 1024, (92 / 1024) + (215 / 1024), 74 / 1024, 70 / 1024}, {(852 / 1024) - (70 / 1024), 92 / 1024, 70 / 1024, 215 / 1024}, {(852 / 1024) + (74 / 1024), 92 / 1024, 70 / 1024, 215 / 1024}}, legR = {{354 / 1024, 726 / 1024, 76 / 1024, 217 / 1024}, {((354 / 1024) + (76 / 1024)) + (70 / 1024), 726 / 1024, 76 / 1024, 217 / 1024}, {354 / 1024, (726 / 1024) - (70 / 1024), 76 / 1024, 70 / 1024}, {354 / 1024, (726 / 1024) + (215 / 1024), 76 / 1024, 70 / 1024}, {(354 / 1024) - (70 / 1024), 726 / 1024, 76 / 1024, 217 / 1024}, {(354 / 1024) + (76 / 1024), 726 / 1024, 76 / 1024, 217 / 1024}}, legL = {{856 / 1024, 704 / 1024, 76 / 1024, 217 / 1024}, {((856 / 1024) - (76 / 1024)) - (70 / 1024), 704 / 1024, 76 / 1024, 217 / 1024}, {856 / 1024, (704 / 1024) - (70 / 1024), 76 / 1024, 70 / 1024}, {856 / 1024, (704 / 1024) + (215 / 1024), 76 / 1024, 70 / 1024}, {(856 / 1024) - (70 / 1024), 704 / 1024, 76 / 1024, 217 / 1024}, {(856 / 1024) + (76 / 1024), 704 / 1024, 76 / 1024, 217 / 1024}}}
____exports.SkinLoader = __TS__Class()
local SkinLoader = ____exports.SkinLoader
SkinLoader.name = "SkinLoader"
function SkinLoader.prototype.____constructor(self)
end
function ____exports.testModel(self)
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
        local mesh = ____exports.cubeMesh(nil, tx, ty, tz, sx, sy, sz, l[name])
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
