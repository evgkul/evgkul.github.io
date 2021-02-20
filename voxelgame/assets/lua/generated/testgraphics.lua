--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____fibers = require("fibers")
local wait = ____fibers.wait
local ____mesh = require("mesh")
local GroupNode = ____mesh.GroupNode
local ____mesh_utils = require("mesh_utils")
local testModel = ____mesh_utils.testModel
function ____exports.buildAtlas(self)
    print("BUILDATLAS")
    local img = newImageRGBA(2048, 2048)
    local atlas = newImageAtlas(img, 512, 512)
    local function loadImage(self, name, path)
        local img = wait(
            nil,
            assets:loadImage(
                "textures/" .. tostring(path)
            )
        )
        print("Loading image ", name)
        print(
            " image size:",
            img:getWidth(),
            img:getHeight()
        )
        atlas:addImage(img, name)
    end
    loadImage(nil, "rocks", "voxel_pack/Tiles/stone.png")
    loadImage(nil, "dirt", "voxel_pack/Tiles/dirt.png")
    loadImage(nil, "grass_top", "voxel_pack/Tiles/grass_top.png")
    loadImage(nil, "grass_side", "voxel_pack/Tiles/dirt_grass.png")
    loadImage(nil, "planks", "voxel_pack/Tiles/wood.png")
    loadImage(nil, "smile", "awesomeface.png")
    loadImage(nil, "test", "testimg.png")
    loadImage(nil, "glass", "glass1/transparent.png")
    loadImage(nil, "glass_red", "glass1/red1.png")
    loadImage(nil, "glass_green", "glass1/green1.png")
    loadImage(nil, "glass_blue", "glass1/blue.png")
    atlas:build()
    gamedata:setAtlas(atlas)
    return atlas
end
local function loadShader(self, name)
    local kind = (__TS__StringEndsWith(name, ".vert") and "vertex") or ((__TS__StringEndsWith(name, ".frag") and "fragment") or error("Invalid shader name"))
    local code = wait(
        nil,
        assets:loadAsset(name)
    )
    return {name = name, kind = kind, code = code}
end
____exports.POSTPROCESS_VBUFFER = (function(self)
    local vdata = {}
    local function pv(self, x, y)
        __TS__ArrayPush(vdata, (x * 2) - 1, (y * 2) - 1, x, y)
    end
    pv(nil, 0, 0)
    pv(nil, 1, 0)
    pv(nil, 1, 1)
    pv(nil, 1, 1)
    pv(nil, 0, 1)
    pv(nil, 0, 0)
    return newVertexBuffer(vdata, {1, 1})
end)(nil)
local function testPasses(self)
    local defvertex = loadShader(nil, "shaders/chunk.vert")
    return {
        opaque = gamedata:createPass(
            "opaque",
            {
                defvertex,
                loadShader(nil, "shaders/chunk.frag")
            },
            {depth_func = "LessEqual", depth_write = true, face_culling = "Front"}
        ),
        alphaclip = gamedata:createPass(
            "alphaclip",
            {
                defvertex,
                loadShader(nil, "shaders/chunk_alphaclip.frag")
            },
            {depth_func = "LessEqual", depth_write = true, face_culling = "Front"}
        ),
        simplealpha = gamedata:createPass(
            "alpha",
            {
                defvertex,
                loadShader(nil, "shaders/chunk_singlealpha.frag")
            },
            {depth_func = "LessEqual", depth_write = true, face_culling = "Front"}
        )
    }
end
function ____exports.initGraphics(self, camera, world)
    local passes = testPasses(nil)
    gamedata:usePass(passes.opaque)
    gamedata:usePass(passes.alphaclip)
    gamedata:usePass(passes.simplealpha)
    return __TS__New(____exports.TestRenderer, camera, world)
end
local UNINIT = nil
____exports.TestRenderer = __TS__Class()
local TestRenderer = ____exports.TestRenderer
TestRenderer.name = "TestRenderer"
function TestRenderer.prototype.____constructor(self, camera, world)
    self.tex_opaque = UNINIT
    self.tex_alpha = UNINIT
    self.depthstencil = UNINIT
    self.fb_opaque = UNINIT
    self.fb_alpha = UNINIT
    self.fb_default = getDefaultFramebuffer()
    self.opaque_pass = gamedata:getPassID("opaque")
    self.alpha_pass = gamedata:getPassID("alpha")
    self.alphaclip_pass = gamedata:getPassID("alphaclip")
    self.tmesh = testModel(nil)
    self.root = __TS__New(GroupNode)
    self.draw = self:buildRenderFunc()
    self.tmesh:setPosition(0, 10, 0)
    self.camera = camera
    log_info("Creating test program")
    local v = loadShader(nil, "shaders/postprocessing.vert")
    local f = loadShader(nil, "shaders/postprocessing.frag")
    local params = {depth_func = "Always", depth_write = false, face_culling = "None"}
    local p = newDynProgram({v, f}, params)
    self.postprocessProgram = p:inst()
    log_info("Created test program", self.postprocessProgram)
    self.world = world
    self.worldrenderer = newChunkWorldRenderer(world)
    self:buildFramebuffers(
        window:getDimensions()
    )
    log_info("Finished TestRenderer creation")
end
function TestRenderer.prototype.buildFramebuffers(self, w, h)
    self.tex_opaque = newTexture(nil, w, h)
    self.tex_alpha = newTexture(nil, w, h)
    self.depthstencil = newDepthStencilBuffer(w, h)
    self.fb_opaque = newFramebuffer({self.tex_opaque}, self.depthstencil)
    self.fb_alpha = newFramebuffer({self.tex_alpha}, self.depthstencil)
    self.postprocessProgram:setTexture("opaque", self.tex_opaque)
    self.postprocessProgram:setTexture("alpha", self.tex_alpha)
    self.draw = self:buildRenderFunc()
end
function TestRenderer.prototype.buildRenderFunc(self)
    local ____ = self
    local root = ____.root
    local fb_opaque = ____.fb_opaque
    local fb_alpha = ____.fb_alpha
    local fb_default = ____.fb_default
    local opaque_pass = ____.opaque_pass
    local alpha_pass = ____.alpha_pass
    local alphaclip_pass = ____.alphaclip_pass
    local postprocessProgram = ____.postprocessProgram
    local worldrenderer = ____.worldrenderer
    local stime = 0
    return function(self, dcontext, camera)
        do
        end
        stime = stime + 0.1
        local x, y, z = camera:getPos()
        worldrenderer:updateLoadedChunks(x, y, z, 3)
        worldrenderer:update()
        fb_opaque:use()
        do
            clearColorDepth(135 / 255, 206 / 255, 235 / 255, 1, 1)
            dcontext:setDrawpassID(opaque_pass)
            worldrenderer:draw(dcontext)
            dcontext:setDrawpassID(alphaclip_pass)
            worldrenderer:draw(dcontext)
            root:draw(dcontext, camera)
        end
        fb_alpha:use()
        do
            clearColorOnly(0, 0, 0, 0)
            dcontext:setDrawpassID(alpha_pass)
            worldrenderer:draw(dcontext)
        end
        fb_default:use()
        postprocessProgram:draw(dcontext, ____exports.POSTPROCESS_VBUFFER)
    end
end
return ____exports
