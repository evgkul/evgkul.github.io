--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local DataStore = __TS__Class()
DataStore.name = "DataStore"
function DataStore.prototype.____constructor(self)
    self.list = {}
    self.hash = {}
    self._map = {}
end
function DataStore.prototype.add(self, id, object)
    __TS__ArrayPush(self.list, object)
    self.hash[id] = object
    self._map[id] = #self.list - 1
end
function DataStore.prototype.remove(self, id)
    local index = self._map[id]
    if index == (#self.list - 1) then
        table.remove(self.list)
    else
        local movedItem = table.remove(self.list)
        self.list[index + 1] = movedItem
        local movedID = movedItem.__id or movedItem[1].__id
        self._map[movedID] = index
    end
    __TS__Delete(self.hash, id)
    __TS__Delete(self._map, id)
end
____exports.ECS = __TS__Class()
local ECS = ____exports.ECS
ECS.name = "ECS"
function ECS.prototype.____constructor(self)
    self.components = {}
    self.comps = self.components
    self.UID = 1
    self.storage = {}
    self.systems = {}
    self.renderSystems = {}
    self.deferredEntityRemovals = {}
    self.deferredCompRemovals = {}
    self.deferredMultiCompRemovals = {}
    self.deferralTimeoutPending = false
end
function ECS.prototype.createEntity(self, compList)
    local id = self.UID
    self.UID = self.UID + 1
    if compList then
        for ____, compName in ipairs(compList) do
            self:addComponent(id, compName)
        end
    end
    return id
end
function ECS.prototype.deleteEntity(self, entID, immediately)
    if immediately == nil then
        immediately = false
    end
    if immediately then
        self:deleteEntityNow(entID)
    else
        __TS__ArrayPush(self.deferredEntityRemovals, entID)
        self:makeDeferralTimeout()
    end
end
function ECS.prototype.createComponent(self, compDefn)
    if not compDefn then
        error("Missing component definition", 0)
    end
    local name = compDefn.name
    if not name then
        error("Component definition must have a name property.", 0)
    end
    if type(name) ~= "string" then
        error("Component name must be a string.", 0)
    end
    if name == "" then
        error("Component name must be a non-empty string.", 0)
    end
    if self.storage[name] then
        error(
            ("Component " .. tostring(name)) .. " already exists.",
            0
        )
    end
    local internalDef = {}
    internalDef.name = name
    internalDef.order = (__TS__NumberIsNaN(
        __TS__Number(compDefn.order)
    ) and 99) or compDefn.order
    internalDef.state = compDefn.state or ({})
    internalDef.onAdd = compDefn.onAdd or nil
    internalDef.onRemove = compDefn.onRemove or nil
    internalDef.system = compDefn.system or nil
    internalDef.renderSystem = compDefn.renderSystem or nil
    internalDef.multi = not (not compDefn.multi)
    local ____ = self
    local components = ____.components
    local systems = ____.systems
    local renderSystems = ____.renderSystems
    self.components[name] = internalDef
    self.storage[name] = __TS__New(DataStore)
    if internalDef.system then
        __TS__ArrayPush(systems, name)
        __TS__ArraySort(
            systems,
            function(____, a, b) return components[a].order - components[b].order end
        )
    end
    if internalDef.renderSystem then
        __TS__ArrayPush(renderSystems, name)
        __TS__ArraySort(
            renderSystems,
            function(____, a, b) return components[a].order - components[b].order end
        )
    end
    return name
end
function ECS.prototype.deleteComponent(self, compName)
    local ____ = self
    local storage = ____.storage
    local systems = ____.systems
    local renderSystems = ____.renderSystems
    local components = ____.components
    local data = storage[compName]
    if not data then
        error(
            "Unknown component: " .. tostring(compName),
            0
        )
    end
    for ____, obj in ipairs(data.list) do
        local id = obj.__id or obj[0].__id
        self:removeComponent(id, compName, true)
    end
    local i = __TS__ArrayIndexOf(systems, compName)
    local j = __TS__ArrayIndexOf(renderSystems, compName)
    if i > -1 then
        __TS__ArraySplice(systems, i, 1)
    end
    if j > -1 then
        __TS__ArraySplice(renderSystems, j, 1)
    end
    __TS__Delete(components, compName)
    __TS__Delete(storage, compName)
    return self
end
function ECS.prototype.addComponent(self, entID, compName, state)
    local ____ = self
    local components = ____.components
    local storage = ____.storage
    local deferredCompRemovals = ____.deferredCompRemovals
    local def = components[compName]
    local data = storage[compName]
    if not data then
        error(
            ("Unknown component: " .. tostring(compName)) .. ".",
            0
        )
    end
    local pendingRemoval = false
    for ____, obj in ipairs(deferredCompRemovals) do
        if (obj.id == entID) and (obj.compName == compName) then
            pendingRemoval = true
        end
    end
    if pendingRemoval then
        self:doDeferredComponentRemovals()
    end
    if data.hash[entID] and (not def.multi) then
        error(
            ((("Entity " .. tostring(entID)) .. " already has component: ") .. tostring(compName)) .. ".",
            0
        )
    end
    local newState = __TS__ObjectAssign({}, {__id = entID}, def.state, state)
    newState.__id = entID
    if def.multi then
        local statesArr = data.hash[entID]
        if not statesArr then
            statesArr = {}
            data:add(entID, statesArr)
        end
        statesArr:push(newState)
    else
        data:add(entID, newState)
    end
    if def.onAdd then
        def:onAdd(entID, newState)
    end
    return self
end
function ECS.prototype.getState(self, entID, compName)
    local data = self.storage[compName]
    if not data then
        error(
            ("Unknown component: " .. tostring(compName)) .. ".",
            0
        )
    end
    return data.hash[entID]
end
function ECS.prototype.hasComponent(self, entID, compName)
    local data = self.storage[compName]
    if not data then
        error(
            ("Unknown component: " .. tostring(compName)) .. ".",
            0
        )
    end
    return data.hash[entID] ~= nil
end
function ECS.prototype.removeComponent(self, entID, compName, immediately)
    if immediately == nil then
        immediately = false
    end
    local def = self.components[compName]
    local data = self.storage[compName]
    if not data then
        error(
            ("Unknown component: " .. tostring(compName)) .. ".",
            0
        )
    end
    if not data.hash[entID] then
        if def.multi then
            return self
        else
            error(
                ((("Entity " .. tostring(entID)) .. " does not have component: ") .. tostring(compName)) .. " to remove.",
                0
            )
        end
    end
    if immediately then
        self:removeComponentNow(entID, compName)
    else
        __TS__ArrayPush(self.deferredCompRemovals, {id = entID, compName = compName})
        self:makeDeferralTimeout()
    end
    return self
end
function ECS.prototype.getStatesList(self, compName)
    local data = self.storage[compName]
    if not data then
        error(
            ("Unknown component: " .. tostring(compName)) .. ".",
            0
        )
    end
    return data.list
end
function ECS.prototype.getStateAccessor(self, compName)
    local ____ = self
    local storage = ____.storage
    if not storage[compName] then
        error(
            ("Unknown component: " .. tostring(compName)) .. ".",
            0
        )
    end
    local hash = storage[compName].hash
    return function(self, entID)
        return hash[entID]
    end
end
function ECS.prototype.getComponentAccessor(self, compName)
    local storage = self.storage
    if not storage[compName] then
        error(
            ("Unknown component: " .. tostring(compName)) .. ".",
            0
        )
    end
    local hash = storage[compName].hash
    return function(self, entID)
        return hash[entID] ~= nil
    end
end
function ECS.prototype.tick(self, dt)
    self:runAllDeferredRemovals()
    local ____ = self
    local systems = ____.systems
    local storage = ____.storage
    local components = ____.components
    for ____, compName in ipairs(systems) do
        local list = storage[compName].list
        local comp = components[compName]
        comp:system(dt, list)
    end
    self:runAllDeferredRemovals()
    return self
end
function ECS.prototype.render(self, dt)
    self:runAllDeferredRemovals()
    local ____ = self
    local renderSystems = ____.renderSystems
    local storage = ____.storage
    local components = ____.components
    for ____, compName in ipairs(renderSystems) do
        local list = storage[compName].list
        local comp = components[compName]
        comp:renderSystem(dt, list)
    end
    self:runAllDeferredRemovals()
    return self
end
function ECS.prototype.removeMultiComponent(self, entID, compName, index, immediately)
    if immediately == nil then
        immediately = false
    end
    local ____ = self
    local components = ____.components
    local storage = ____.storage
    local deferredMultiCompRemovals = ____.deferredMultiCompRemovals
    local def = components[compName]
    local data = storage[compName]
    if not data then
        error(
            ("Unknown component: " .. tostring(compName)) .. ".",
            0
        )
    end
    if not def.multi then
        error("removeMultiComponent called on non-multi component", 0)
    end
    local statesArr = data.hash[entID]
    if (not statesArr) or (not statesArr[index]) then
        error(
            (("Multicomponent " .. tostring(compName)) .. " instance not found at index ") .. tostring(index),
            0
        )
    end
    local stateToRemove = statesArr[index]
    if immediately then
        self:removeMultiCompNow(entID, compName, stateToRemove)
    else
        __TS__ArrayPush(deferredMultiCompRemovals, {id = entID, compName = compName, state = stateToRemove})
    end
    return self
end
function ECS.prototype.deleteEntityNow(self, entID)
    local storage = self.storage
    for compName in pairs(storage) do
        local data = storage[compName]
        if data.hash[entID] then
            self:removeComponentNow(entID, compName)
        end
    end
end
function ECS.prototype.removeComponentNow(self, entID, compName)
    local ____ = self
    local components = ____.components
    local storage = ____.storage
    local def = components[compName]
    local data = storage[compName]
    if not data then
        return
    end
    if not data.hash[entID] then
        return
    end
    if def.onRemove then
        if def.multi then
            for ____, state in __TS__Iterator(data.hash[entID]) do
                def:onRemove(entID, state)
            end
        else
            def:onRemove(entID, data.hash[entID])
        end
    end
    if def.multi then
        data.hash[entID].length = 0
    end
    data:remove(entID)
end
function ECS.prototype.removeMultiCompNow(self, entID, compName, stateObj)
    local def = self.components[compName]
    local data = self.storage[compName]
    local statesArr = data.hash[entID]
    if not statesArr then
        return
    end
    local i = statesArr:indexOf(stateObj)
    if i < 0 then
        return
    end
    if def.onRemove then
        def:onRemove(entID, stateObj)
    end
    statesArr:splice(i, 1)
    if statesArr.length == 0 then
        self:removeComponentNow(entID, compName)
    end
end
function ECS.prototype.makeDeferralTimeout(self)
    local ____self = self
    if self.deferralTimeoutPending then
        return
    end
    self.deferralTimeoutPending = true
    local setTimeout = callSoon
    setTimeout(
        function()
            ____self.deferralTimeoutPending = false
            ____self:runAllDeferredRemovals()
        end
    )
end
function ECS.prototype.runAllDeferredRemovals(self)
    self:doDeferredComponentRemovals()
    self:doDeferredMultiComponentRemovals()
    self:doDeferredEntityRemovals()
end
function ECS.prototype.doDeferredEntityRemovals(self)
    local ____ = self
    local deferredEntityRemovals = ____.deferredEntityRemovals
    while #deferredEntityRemovals > 0 do
        local entID = table.remove(deferredEntityRemovals)
        self:deleteEntityNow(entID)
    end
end
function ECS.prototype.doDeferredComponentRemovals(self)
    local ____ = self
    local deferredCompRemovals = ____.deferredCompRemovals
    while #deferredCompRemovals > 0 do
        local obj = table.remove(deferredCompRemovals)
        self:removeComponentNow(obj.id, obj.compName)
    end
end
function ECS.prototype.doDeferredMultiComponentRemovals(self)
    local ____ = self
    local deferredMultiCompRemovals = ____.deferredMultiCompRemovals
    while #deferredMultiCompRemovals > 0 do
        local obj = table.remove(deferredMultiCompRemovals)
        self:removeMultiCompNow(obj.id, obj.compName, obj.state)
        obj.state = nil
    end
end
return ____exports
