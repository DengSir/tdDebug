
local tdDebug = tdCore:NewAddon(...)

tdCore:SetAllowDebug(true)

local debugs = setmetatable({}, {
    __index = function(o, k)
        o[k] = {}
        tdDebug:AddAddon(k)
        return o[k]
    end,
})

function tdDebug:Add(name, ...)
    tinsert(debugs[name], table.concat({...}, ' '))
    self:GetOption():GetFrame():Update()
end

function tdDebug:OnInit()
    self:InitOption{ type = 'TabWidget', name = 'Tabs'}
    self.Tabs = self:GetOption():GetFrame():GetControl('Tabs')
    
    self:Debug('Debug Init')
    self:GetOption():GetFrame():Update()
end

function tdDebug:AddAddon(name)
    tdCore('GUI'):CreateGUI(
        {
            type = 'Widget', label = name,
            {
                type = 'ListWidget', label = 'Debug List', itemList = debugs[name],
                verticalArgs = {-1, -20, 0, 0},
            },
        }, self.Tabs, false)
end