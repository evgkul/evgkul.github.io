--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____ecs = require("ecs")
local ECS = ____ecs.ECS
local ____character_model = require("mesh.character_model")
local testCharacter = ____character_model.testCharacter
local ____mesh = require("mesh.mesh")
local GroupNode = ____mesh.GroupNode
____exports.model_providers = {character = testCharacter}
____exports.WorldDef = __TS__Class()
local WorldDef = ____exports.WorldDef
WorldDef.name = "WorldDef"
function WorldDef.prototype.____constructor(self, chunkworld)
    self.node = __TS__New(GroupNode)
    self.chunkworld = chunkworld
end
____exports.worlds = {}
____exports.ecs = __TS__New(ECS)
return ____exports
