--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local tvertex2 = "#version 300 es\nlayout (location = 0) in vec3 aPos;\nlayout (location = 1) in vec2 aTex;\n\nuniform mat4 model;\nuniform mat4 view;\nuniform mat4 projection;\nout vec2 texpos;\nout vec3 normal;\n\n\nvoid main()\n{\n  texpos = aTex;\n  //normal = aNormal;\n  //normal = aJoints.xyz / 4.0 * 2. - 1.;\n  //normal = aWeights.xyz * 2. - 1.;\n  gl_Position = projection * view * model * vec4(aPos.x, aPos.y, aPos.z, 1.0);\n}"
local tfragment2 = "#version 300 es\nprecision mediump float;\nin vec2 texpos;\nin vec3 normal;\nuniform vec4 color;\nuniform sampler2D tex;\n\nout vec4 FragColor;\n\nvoid main()\n{\n  //FragColor = color;\n  //FragColor = vec4(normalize(normal) * .5 + .5, 1.0f);\n  FragColor = texture(tex,texpos);\n  //FragColor = vec4(texpos,0.0,1.0);\n}"
____exports.basicProgram = newDynProgram({{name = "builtin:basic_program.vert", code = tvertex2, kind = "vertex"}, {name = "buildin:basic_program.frag", code = tfragment2, kind = "fragment"}}, {depth_func = "LessEqual", depth_write = true, face_culling = "Back"})
return ____exports
