
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
end

function tdDebug:OnInit()
    self:InitOption{ type = 'TabWidget', name = 'Tabs'}
    self.Tabs = self:GetOptionControl('Tabs')
    
    self:Debug('Debug Init')
    self:UpdateOption()
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