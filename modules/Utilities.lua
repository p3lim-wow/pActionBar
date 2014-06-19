
local function OnClick(self)
	PutItemInBag(self:GetID() + 19)
end

for index = 2, 5 do
	local portrait = _G['ContainerFrame' .. index .. 'PortraitButton']
	portrait:HookScript('OnReceiveDrag', OnClick)
	portrait:HookScript('OnClick', OnClick)
end
