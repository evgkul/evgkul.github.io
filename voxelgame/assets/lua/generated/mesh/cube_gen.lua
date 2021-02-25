--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.buildCubeMesh(self, tx, ty, tz, sx, sy, sz, uv)
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
    return newVertexBuffer(cubeVertices, cubeStruct)
end
return ____exports
