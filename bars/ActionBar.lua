local _, ns = ...

local actionButtons = ns.actionButtons
local SkinButton = ns.SkinButton

local Parent = CreateFrame('Frame', 'pActionBar', UIParent, 'SecureHandlerStateTemplate')
Parent:SetPoint('BOTTOM', 0, 80)
Parent:SetSize(396, 33)

RegisterStateDriver(Parent, 'visibility', '[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show')

local visibleButtons = {}
for _, button in pairs(actionButtons) do
	visibleButtons[button] = true
end

local function UpdatePosition()
	local barIndex = 1
	for _, buttonName in pairs(actionButtons) do
		if(visibleButtons[buttonName]) then
			for index = 1, NUM_ACTIONBAR_BUTTONS do
				local Button = _G[buttonName .. index]
				Button:ClearAllPoints()

				if(index == 1) then
					Button:SetPoint('BOTTOMLEFT', Parent, 2, 33 * (barIndex - 1))
				else
					Button:SetPoint('LEFT', _G[buttonName .. index - 1], 'RIGHT', 5, 0)
				end

				if(not Button.Skinned) then
					SkinButton(buttonName .. index)
				end
			end

			Parent:SetHeight(33 * barIndex)
			barIndex = barIndex + 1
		end
	end
end

for _, frame in pairs({
	'MainMenuBarArtFrame',
	'MultiBarBottomLeft',
	'MultiBarBottomRight',
	'MultiBarRight',
	'MultiBarLeft',
}) do
	_G[frame]:SetParent(Parent)
	_G[frame]:EnableMouse(false)
end

hooksecurefunc('SetActionBarToggles', function(bar2, bar3, bar4, bar5)
	visibleButtons.MultiBarBottomLeftButton = bar2 == '1'
	visibleButtons.MultiBarBottomRightButton = bar3 == '1'
	visibleButtons.MultiBarRightButton = bar4 == '1'
	visibleButtons.MultiBarLeftButton = bar5 == '1' and bar4 == '1'

	UpdatePosition()
end)
