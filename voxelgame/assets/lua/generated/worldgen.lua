--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local function randGenerator(self, seed)
    local next = math.floor(seed)
    local ISIZE = 2 ^ 32
    local mul = 1 / ISIZE
    return function(self)
        next = ((next * 1103515245) + 12345) % ISIZE
        return next * mul
    end
end
local NOISE_MUL = 1 / math.sqrt(3 / 4)
local SX = 2
local SY = 2
local SZ = 2
function ____exports.genWorld(self, world)
    log_info("Started world generation")
    local r = randGenerator(nil, 100500)
    local noise_p = {}
    for i = 0, 255 do
        noise_p[i + 1] = i
    end
    for i = 255, 1, -1 do
        local j = math.floor(
            r(nil) * i
        )
        local tmp = noise_p[i + 1]
        noise_p[i + 1] = noise_p[j + 1]
        noise_p[j + 1] = tmp
    end
    local noisegen = newImprovedPerlinNoiseGenerator(noise_p)
    local function noise(self, x, y, z)
        return (noisegen:noise(x, y, z) * NOISE_MUL) + math.max(y, -0.5)
    end
    local planks = gamedata:getBlockID("planks")
    local rocks = gamedata:getBlockID("rocks")
    local top = gamedata:getBlockID("dirt")
    local top2 = gamedata:getBlockID("grass")
    local edge = gamedata:getBlockID("planks")
    local heightmap = {}
    for cx = -SX, SX do
        for cz = -SZ, SZ do
            do
                for lx = 0, 15 do
                    for lz = 0, 15 do
                        heightmap[(lx + (lz * 16)) + 1] = -1
                    end
                end
            end
            for cy = -SY, SY do
                log_info("Processing chunk", cx, cy, cz)
                local chunk = world:createChunk(cx, cy, cz)
                for lx = 0, 15 do
                    for lz = 0, 15 do
                        local hmap = heightmap[(lx + (lz * 16)) + 1]
                        for ly = 0, 15 do
                            local nx = cx + (lx / 16)
                            local ny = cy + (ly / 16)
                            local nz = cz + (lz / 16)
                            local v = noise(nil, nx, ny, nz)
                            if v < 0 then
                                if (ny > -0.5) and (v > -0.2) then
                                    if noise(nil, nx, ny + (1 / 16), nz) >= 0 then
                                        chunk:setBlockID(lx, ly, lz, top2)
                                    else
                                        chunk:setBlockID(lx, ly, lz, top)
                                    end
                                else
                                    chunk:setBlockID(lx, ly, lz, rocks)
                                end
                            end
                        end
                    end
                end
                for i = 0, 15 do
                    chunk:setBlockID(i, 0, 0, edge)
                    chunk:setBlockID(0, i, 0, edge)
                    chunk:setBlockID(0, 0, i, edge)
                end
            end
            do
            end
        end
    end
    log_info("Started skylight propogation")
    world:propogateSkylight(((SY + 1) * 16) - 1, -SX * 16, -SZ * 16, (SX * 16) + 15, (SZ * 16) + 15)
    log_info("Finished skylight propogation")
end
return ____exports
