local Parent = CreateFrame('Frame', 'pPetBar', UIParent, 'SecureHandlerStateTemplate')
Parent:SetPoint('BOTTOM', pActionBar, 'TOP')
Parent:SetSize(290, 29)

RegisterStateDriver(Parent, 'visibility', '[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; [@pet,exists,nomounted] show; hide')

local SkinButton = select(2, ...).SkinButton
for index = 1, NUM_PET_ACTION_SLOTS do
	local Button = _G['PetActionButton' .. index]
	Button:ClearAllPoints()

	if(index == 1) then
		Button:SetPoint('BOTTOMLEFT', Parent, 2, 0)
	else
		Button:SetPoint('LEFT', _G['PetActionButton' .. index - 1], 'RIGHT', 5, 0)
	end

	SkinButton('PetActionButton' .. index, 24)
end

PetActionBarFrame:SetParent(Parent)
PetActionBarFrame:EnableMouse(false)
