--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
require("lualib_bundle");
local ____exports = {}
local HOTBAR_COLOR = 538976383
local HOTBAR_SLOT_SIZE = 0.1
local HOTBAR_INNER_MARGIN = 0.01
____exports.Slot = __TS__Class()
local Slot = ____exports.Slot
Slot.name = "Slot"
function Slot.prototype.____constructor(self)
    self.image = nil
    self.name = ""
    self.onUse = function(self)
    end
    self.onAttack = function(self)
    end
end
function Slot.fromBlockdata(self, bdata)
    local slot = __TS__New(____exports.Slot)
    if bdata.drawable then
        slot.image = bdata.texture_parts[2]
    end
    slot.name = bdata.name
    return slot
end
____exports.Hotbar = __TS__Class()
local Hotbar = ____exports.Hotbar
Hotbar.name = "Hotbar"
function Hotbar.prototype.____constructor(self)
    self.slots = {}
    self.activeSlot = 0
    self.defaultSlot = __TS__New(____exports.Slot)
end
function Hotbar.prototype.getSlot(self, num)
    return self.slots[num + 1]
end
function Hotbar.prototype.getActiveSlotNum(self)
    return self.activeSlot
end
function Hotbar.prototype.setActiveSlot(self, num)
    self.activeSlot = num
end
function Hotbar.prototype.getActiveSlot(self)
    return self.slots[self.activeSlot + 1]
end
function Hotbar.prototype.setSlot(self, num, slot)
    self.slots[num + 1] = slot
end
function Hotbar.prototype.removeSlot(self, num)
    self.slots[num + 1] = nil
end
function Hotbar.prototype.draw(self, canvas)
    local width = HOTBAR_SLOT_SIZE * 9
    local startx = -width * 0.5
    local starty = -HOTBAR_SLOT_SIZE
    canvas:fill(startx, starty, width, HOTBAR_SLOT_SIZE, HOTBAR_COLOR)
    local selected_x = startx + (HOTBAR_SLOT_SIZE * self.activeSlot)
    local selected_y = starty
    canvas:fill(selected_x, selected_y, HOTBAR_SLOT_SIZE, HOTBAR_SLOT_SIZE, 2812782591)
    local x = startx + HOTBAR_INNER_MARGIN
    local y = starty + HOTBAR_INNER_MARGIN
    local wh = HOTBAR_SLOT_SIZE - (HOTBAR_INNER_MARGIN * 2)
    for i = 0, 8 do
        local slot = self.slots[i + 1]
        if slot then
            local img = slot.image
            if img then
                canvas:imagePart(x, y, wh, wh, 4294967295, img)
            end
        end
        x = x + HOTBAR_SLOT_SIZE
    end
    do
        local slot = self.slots[self.activeSlot + 1] or self.defaultSlot
        local name = slot.name
        if name ~= "" then
            local w = 0.05
            local h = 0.05
            local x = (utf8.len(name) * -0.5) * w
            local y = (-HOTBAR_SLOT_SIZE - 0.01) - h
            canvas:textline(x, y, w, h, name, 4294967207, false)
        end
    end
end
return ____exports
