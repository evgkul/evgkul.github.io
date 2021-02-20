--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____mesh = require("mesh")
local Mesh = ____mesh.Mesh
local tvertex = "#version 300 es\nlayout (location = 0) in vec3 aPos;\n\nuniform mat4 model;\nuniform mat4 view;\nuniform mat4 projection;\n\n\nvoid main()\n{\n   gl_Position = projection * view * model * vec4(aPos.x, aPos.y, aPos.z, 1.0);\n}"
local tfragment = "#version 300 es\nprecision mediump float;\n\nout vec4 FragColor;\n\nvoid main()\n{\n    FragColor = vec4(1.0,0.0,0.0, 1.0f);\n}"
local tprogram = newDynProgram({{name = "tvertex.vert", code = tvertex, kind = "vertex"}, {name = "tvertex.frag", code = tfragment, kind = "fragment"}}, {depth_func = "LessEqual", depth_write = true, face_culling = "None"})
local testStruct = {2, 1}
local testVertices = {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1}
local testVBuffer = newVertexBuffer(testVertices, testStruct)
function ____exports.testMesh(self)
    local inst = tprogram:inst()
    local m = __TS__New(Mesh, testVBuffer, inst)
    m.transform:translate(1, 1, 1)
    return m
end
return ____exports
