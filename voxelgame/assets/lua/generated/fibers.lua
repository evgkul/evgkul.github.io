--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local cur_fiber_step
local coro_resume = coroutine.resume
local coro_yield = coroutine.yield
local unwrap_args_l = unwrap_args
function ____exports.createFiber(self, name, fun)
    return function(...)
        local coro = coroutine.create(fun)
        local function step(...)
            local oldstep = cur_fiber_step
            cur_fiber_step = step
            local suc, msgorfn, a, b, c = coro_resume(coro, ...)
            cur_fiber_step = oldstep
            if not suc then
                local s = debug.traceback(
                    coro,
                    tostring(msgorfn)
                )
                log_error(
                    ("Error during execution of fiber \"" .. tostring(name)) .. "\":",
                    s
                )
            elseif msgorfn then
                msgorfn(a, b, c)
            end
        end
        callSoon(step, ...)
    end
end
function ____exports.pwait(self, future)
    if not cur_fiber_step then
        error("Attempt to wait outside of fiber")
    end
    return coro_yield(future["then"], future, cur_fiber_step)
end
function ____exports.wait(self, future)
    return unwrap_args_l(
        ____exports.pwait(nil, future)
    )
end
return ____exports
