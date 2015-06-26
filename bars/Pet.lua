local Parent = CreateFrame('Frame', 'pPetBar', UIParent, 'SecureHandlerStateTemplate')
Parent:SetPoint('BOTTOM', pActionBar, 'TOP')
Parent:SetSize(290, 29)

RegisterStateDriver(Parent, 'visibility', '[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; [@pet,exists] show; hide')

local SkinButton = select(2, ...).SkinButton
for index = 1, NUM_PET_ACTION_SLOTS do
	local Button = _G['PetActionButton' .. index]
	Button:ClearAllPoints()

	if(index == 1) then
		Button:SetPoint('BOTTOMLEFT', Parent, 2, 0)
	else
		Button:SetPoint('LEFT', _G['PetActionButton' .. index - 1], 'RIGHT', 5, 0)
	end

	SkinButton(Button, true)
end

PetActionBarFrame:SetParent(Parent)
PetActionBarFrame:EnableMouse(false)

hooksecurefunc('PetActionBar_Update', function(self)
	for index = 1, NUM_PET_ACTION_SLOTS do
		local Button = _G['PetActionButton' .. index]

		local _, _, _, _, _, _, autoCastEnabled = GetPetActionInfo(index)
		if(autoCastEnabled) then
			AutoCastShine_AutoCastStop(_G['PetActionButton' .. index .. 'Shine'])

			Button:SetBackdropBorderColor(1, 1, 0)
		else
			Button:SetBackdropBorderColor(0, 0, 0)
		end
	end
end)
