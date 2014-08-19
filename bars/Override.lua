local Parent = CreateFrame('Frame', 'pOverrideBar', UIParent, 'SecureHandlerStateTemplate')
Parent:SetPoint('BOTTOM', 0, 80)
Parent:SetSize(198, 33)

RegisterStateDriver(Parent, 'visibility', '[petbattle] hide; [overridebar][vehicleui][possessbar,@vehicle,exists] show; hide')
RegisterStateDriver(OverrideActionBar, 'visibility', '[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide')

local SkinButton = select(2, ...).SkinButton
for index = 1, NUM_OVERRIDE_BUTTONS do
	local Button = _G['OverrideActionBarButton' .. index]
	Button:ClearAllPoints()

	if(index == 1) then
		Button:SetPoint('BOTTOMLEFT', Parent, 2, 0)
	else
		Button:SetPoint('LEFT', _G['OverrideActionBarButton' .. index - 1], 'RIGHT', 5, 0)
	end

	SkinButton(Button)
end

OverrideActionBar:SetParent(Parent)
OverrideActionBar:EnableMouse(false)
OverrideActionBar:SetScript('OnShow', nil)

local LeaveButton = CreateFrame('Button', 'pOverrideBarLeave', Parent, 'ActionButtonTemplate, SecureActionButtonTemplate')
LeaveButton:SetPoint('RIGHT', _G['OverrideActionBarButton' .. NUM_OVERRIDE_BUTTONS], 20, 0)
LeaveButton:SetAttribute('type', 'macro')
LeaveButton:SetAttribute('macrotext', '/leavevehicle')

SkinButton(LeaveButton, nil, true)

LeaveButton.icon:SetTexture([[Interface\Vehicles\UI-Vehicles-Button-Exit-Up]])
LeaveButton.icon:SetTexCoord(1/5, 4/5, 1/5, 4/5)
