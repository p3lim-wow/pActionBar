
local function OnClick(self, ...)
	if(CursorHasItem() and not InCombatLockdown()) then
		PutItemInBag(self:GetID() + 19)
	elseif(self.origOnClick) then
		self.origOnClick(self, ...)
	end
end

for index = 2, 5 do
	local portrait = _G['ContainerFrame' .. index .. 'PortraitButton']
	portrait.origOnClick = portrait:GetScript('OnClick')
	portrait:SetScript('OnClick', OnClick)
	portrait:HookScript('OnReceiveDrag', OnClick)
end
