local _, ns = ...
local actionButtons = ns.actionButtons

local gsub = string.gsub
local function CleanKey(key)
	if(key) then
		key = string.upper(key)
		key = gsub(key, ' ', '')
		key = gsub(key, '%-', '')
		key = gsub(key, 'MOUSEBUTTON', 'B')
		key = gsub(key, 'MIDDLEMOUSE', 'MM')
		key = gsub(key, 'BACKSPACE', 'BS')

		return key
	end
end

local Handler = CreateFrame('Frame')
Handler:RegisterEvent('PLAYER_LOGIN')
Handler:RegisterEvent('UPDATE_BINDINGS')
Handler:SetScript('OnEvent', function()
	for _, name in next, actionButtons do
		for index = 1, NUM_ACTIONBAR_BUTTONS do
			local Button = _G[name .. index]
			if(Button) then
				local HotKey = Button.HotKey
				if(HotKey) then
					HotKey:SetText(CleanKey(HotKey:GetText()) or '')
				end
			end
		end
	end
end)
