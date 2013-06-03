local Parent = CreateFrame('Frame', 'pExtraBar', UIParent, 'SecureHandlerStateTemplate')
Parent:SetPoint('BOTTOM', pActionBar, 0, 30)
Parent:SetSize(50, 50)

RegisterStateDriver(Parent, 'visibility', '[petbattle][overridebar][vehicleui] hide; show')

ExtraActionBarFrame:SetParent(Parent)
ExtraActionBarFrame:EnableMouse(false)
ExtraActionBarFrame:SetAllPoints()
ExtraActionBarFrame.ignoreFramePositionManager = true
