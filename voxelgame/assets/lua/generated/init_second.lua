--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local ____fibers = require("fibers")
local createFiber = ____fibers.createFiber
local pwait = ____fibers.pwait
local ____indicators = require("indicators")
local Indicators = ____indicators.Indicators
local ____mesh_utils = require("mesh_utils")
local cubeMesh = ____mesh_utils.cubeMesh
local ____testgame = require("testgame")
local init2 = ____testgame.initialize
local ____testgraphics = require("testgraphics")
local initGraphics = ____testgraphics.initGraphics
local luahotbar = require("hotbar")
local ____entity = require("entity")
local TestEntity = ____entity.TestEntity
local ____basic_camera = require("basic_camera")
local CameraMovementController = ____basic_camera.CameraMovementController
local trenderer, tentity, thotbar, controller, dcontext, indicators, mtime, canvas, onTick
function onTick(time)
    local camera = trenderer.camera
    mtime = mtime + time
    dcontext:resetTransforms()
    local x, y, z = camera:getPos()
    raycaster:ignoreHitboxNextCast(tentity.hitbox)
    raycaster:raycast(
        testworld,
        camera:getPosDir()
    )
    do
        do
            camera:setDir(controller.dirX, controller.dirY, controller.dirZ)
            controller:tick(time)
            local x = controller.x
            local y = controller.y
            local z = controller.z
            controller:resetPosition()
            tentity.hitbox:addForce(x * 100, y * 100, z * 100)
        end
        local x, y, z = tentity.hitbox:getPosition()
        camera:setPos(x + 0.45, y + 0.45, z + 0.45)
    end
    dcontext:loadCamera(camera)
    trenderer:draw(dcontext, camera)
    canvas:resetTransform()
    canvas:zerototop()
    canvas:popTransformation()
    canvas:draw(-0.01, -0.01, 0.02, 0.02, 4278190335, 0.2, 0.2)
    canvas:zerotobottom()
    thotbar:draw(canvas)
    canvas:resetTransform()
    indicators:draw(canvas, time)
    canvas:resetTransform()
    canvas:zerotobottom()
    testworld:afterUpdate()
end
local camera = newCamera()
local tfiber = createFiber(
    nil,
    "testfiber",
    function(res, a, b)
        print("STARTED FIBER")
        local suc, val = pwait(
            nil,
            assets:loadAsset("lua/init.lua")
        )
        print("TESTFILE", suc, val)
        local r = (tostring(a) .. "_") .. tostring(b)
        res(nil, r)
    end
)
tfiber(
    function(____, r) return log_debug("tfiber_res", r) end,
    "1",
    "2"
)
callSoon(
    function(a, b, c)
        log_debug("callSoon", a, b, c)
    end,
    1,
    2,
    3
)
local blocks
local function setFramebuffers(self, w, h)
    trenderer:buildFramebuffers(w, h)
end
trenderer = nil
local mesh = cubeMesh(nil)
local initialize = createFiber(
    nil,
    "initialize",
    function(res)
        local data = init2(nil)
        testworld = data.world
        tentity = __TS__New(TestEntity, testworld)
        trenderer = initGraphics(nil, camera, testworld)
        trenderer.root:addNode(tentity)
        log_info("Finished initialize")
        res(data)
        blocks = gamedata:getAllBlockData()
        do
            local names = {"planks", "smile", "rocks", "nothing", "testblock", "glass", "glass_red", "glass_green", "glass_blue"}
            for num, block in ipairs(names) do
                if block ~= "" then
                    local id = gamedata:getBlockID(block)
                    local bdata = blocks[block]
                    local slot = luahotbar.Slot:fromBlockdata(blocks[block])
                    if bdata.placeable then
                        slot.onUse = function(self)
                            local x, y, z = raycaster:getBlockPosition()
                            local nx, ny, nz = raycaster:getBlockNormal()
                            testworld:setBlockID(x + nx, y + ny, z + nz, id)
                        end
                    end
                    slot.onAttack = function(self)
                        local x, y, z = raycaster:getBlockPosition()
                        testworld:setBlockID(x, y, z, 0)
                    end
                    thotbar:setSlot(num - 1, slot)
                end
            end
        end
        print(
            "TESTWORLD!",
            tostring(testworld),
            testworld.setBlockID
        )
        local id = gamedata:getBlockID("glass_green")
        for i = 0, 15 do
            testworld:setBlockID(5, i, 5, id)
        end
        window:setFrameHandler(onTick)
    end
)
thotbar = __TS__New(luahotbar.Hotbar)
__TS__ObjectAssign(_G, {initialize = initialize})
window:setMouseMovementHandler(
    function(deltax, deltay)
        controller:handleMouse(deltax * 0.1, -deltay * 0.1)
    end
)
window:setMouseButtonHandler(
    function(action, button)
        if (action == 1) and (raycaster:getKind() == 1) then
            local slot = thotbar:getActiveSlot()
            local x, y, z = raycaster:getBlockPosition()
            if button == 0 then
                slot:onAttack()
            elseif button == 1 then
                slot:onUse()
            end
        end
    end
)
local curSmooth = true
local isFullscreen = false
local pressedKeys = 0
controller = __TS__New(CameraMovementController)
window:setKeyHandler(
    function(action, key)
        if action == 1 then
            if key == 32 then
                tentity.hitbox:addImpulse(0, 10, 0)
            elseif key == 340 then
                tentity.hitbox:addImpulse(0, -10, 0)
            end
        end
        if key == 87 then
            controller.doMoveForward = action == 1
            camera:setMovementState(0, action == 1)
        elseif key == 65 then
            controller.doMoveRight = action == 1
            camera:setMovementState(2, action == 1)
        elseif key == 83 then
            controller.doMoveBackward = action == 1
            camera:setMovementState(1, action == 1)
        elseif key == 68 then
            controller.doMoveLeft = action == 1
            camera:setMovementState(3, action == 1)
        elseif key == 256 then
        elseif ((key >= 49) and (key <= 57)) and (action == 1) then
            local slotnum = key - 49
            thotbar:setActiveSlot(slotnum)
        elseif (key == 264) and (action == 1) then
            local dec = testworld:getSkylightDec()
            if dec < 15 then
                testworld:setSkylightDec(dec + 1)
            end
        elseif (key == 265) and (action == 1) then
            local dec = testworld:getSkylightDec()
            if dec > 0 then
                testworld:setSkylightDec(dec - 1)
            end
        elseif (key == 67) and (action == 1) then
            curSmooth = not curSmooth
            trenderer.worldrenderer:setSmoothLighting(curSmooth)
        elseif (key == 70) and (action == 1) then
            isFullscreen = window:setFullscreen(not isFullscreen)
        elseif (key == 88) and (action == 1) then
            trenderer.tmesh.doWalk = not trenderer.tmesh.doWalk
        elseif (key == 90) and (action == 1) then
            local mx = math.random(20) - 10
            local my = math.random(10)
            local mz = math.random(20) - 10
            tentity.hitbox:addImpulse(mx, my, mz)
        end
    end
)
dcontext = newDrawContext()
do
    local w, h = window:getDimensions()
    dcontext:setAspectRatio(w / h)
end
local screenWidth = 1
local screenHeight = 1
window:setResizeHandler(
    function(w, h)
        screenWidth = w
        screenHeight = h
        local ratio = w / h
        print("RESIZE", w, h, ratio)
        dcontext:setAspectRatio(ratio)
        setFramebuffers(nil, w, h)
    end
)
local cur_dist = -0.3
camera:setOrbitDistance(cur_dist)
window:setScrollHandler(
    function(x, y)
        cur_dist = cur_dist - (y * 0.1)
        camera:setOrbitDistance(cur_dist)
    end
)
indicators = __TS__New(Indicators, camera)
mtime = 0
canvas = newCanvas(
    getDefaultFramebuffer()
)
return ____exports
