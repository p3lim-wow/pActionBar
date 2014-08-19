local WoD = select(4, GetBuildInfo()) >= 6e4

local FONT = [[Interface\AddOns\pActionBar\semplice.ttf]]
local TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local BACKDROP = {
	edgeFile = TEXTURE, edgeSize = 1,
	insets = {left = 1, right = 1, top = 1, bottom = 1},
}

local function null() end

local Handler = CreateFrame('Frame')
Handler:RegisterEvent('PLAYER_LOGIN')
Handler:SetScript('OnEvent', function()
	SetCVar('lockActionBars', 1)
	SetCVar('alwaysShowActionBars', 0)
	SetCVar('secureAbilityToggle', 1)

	if(WoD) then
		SetCVar('countdownForCooldowns', 0)
	end
end)

local function UpdateButton(self)
	local Button = self:GetParent()
	local action = Button.action

	Button.icon:SetVertexColor(1, 1, 1)

	if(not IsUsableAction(action)) then
		Button.icon:SetVertexColor(0.4, 0.4, 0.4)
	else
		Button.icon:SetVertexColor(1, 1, 1)
	end
end

local function PersistentNormalTexture(self, texture)
	if(texture) then
		self:SetNormalTexture(nil)
	end
end

local function SkinButton(Button, size)
	local name = Button:GetName()
	Button:SetSize(size or 28, size or 28)
	Button:SetBackdrop(BACKDROP)
	Button:SetBackdropBorderColor(0, 0, 0)

	local HotKey = WoD and Button.HotKey or _G[name .. 'HotKey']
	local CheckedTexture = Button:GetCheckedTexture()
	if(size) then
		Button.cooldown:SetSize(size or 28, size or 28)
		Button.cooldown:SetAllPoints()

		HotKey:SetAlpha(0)

		hooksecurefunc(Button, 'SetNormalTexture', PersistentNormalTexture)

		CheckedTexture:SetTexture(0, 1/2, 1, 1/3)
		CheckedTexture:ClearAllPoints()
		CheckedTexture:SetPoint('TOPRIGHT', -1, -1)
		CheckedTexture:SetPoint('BOTTOMLEFT', 1, 1)

		_G[name .. 'AutoCastable']:SetAlpha(0)
	else
		HotKey:ClearAllPoints()
		HotKey:SetPoint('BOTTOMRIGHT', 0, 1)
		HotKey:SetFont(FONT, 8, 'OUTLINEMONOCHROME')

		local NormalTexture = WoD and Button.NormalTexture or _G[name .. 'NormalTexture']
		NormalTexture:SetTexture(nil)
		hooksecurefunc(NormalTexture, 'SetVertexColor', UpdateButton)

		CheckedTexture:SetTexture(nil)
	end

	local Count = WoD and Button.Count or _G[name .. 'Count']
	Count:ClearAllPoints()
	Count:SetPoint('TOPLEFT', 1, -1)
	Count:SetFont(FONT, 8, 'OUTLINEMONOCHROME')

	local Icon = Button.icon
	Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	Icon:SetAllPoints()

	local PushedTexture = Button:GetPushedTexture()
	PushedTexture:SetTexture(1, 1, 2/5, 1/5)
	PushedTexture:ClearAllPoints()
	PushedTexture:SetPoint('TOPRIGHT', -1, -1)
	PushedTexture:SetPoint('BOTTOMLEFT', 1, 1)

	local HighlightTexture = Button:GetHighlightTexture()
	HighlightTexture:SetTexture(0, 3/5, 1, 1/5)
	HighlightTexture:ClearAllPoints()
	HighlightTexture:SetPoint('TOPRIGHT', -1, -1)
	HighlightTexture:SetPoint('BOTTOMLEFT', 1, 1)

	local Flash = WoD and Button.Flash or _G[name .. 'Flash']
	Flash:SetTexture(1, 0, 0, 1/3)
	Flash:ClearAllPoints()
	Flash:SetPoint('TOPRIGHT', -1, -1)
	Flash:SetPoint('BOTTOMLEFT', 1, 1)

	local FloatingBG = _G[name .. 'FloatingBG']
	if(FloatingBG) then
		FloatingBG:Hide()
	end

	local FlyoutBorder = WoD and Button.FlyoutBorder or _G[name .. 'FlyoutBorder']
	if(FlyoutBorder) then
		FlyoutBorder:SetTexture(nil)
	end

	local FlyoutBorderShadow = WoD and Button.FlyoutBorderShadow or _G[name .. 'FlyoutBorderShadow']
	if(FlyoutBorderShadow) then
		FlyoutBorderShadow:SetTexture(nil)
	end

	if(WoD) then
		Button.Border:SetTexture(nil)
		Button.Name:Hide()
	else
		_G[name .. 'Border']:SetTexture(nil)
		_G[name .. 'Name']:Hide()
	end

	Button.Skinned = true
end

local _, ns = ...
ns.SkinButton = SkinButton
ns.WoD = WoD

ns.actionButtons = {
	'ActionButton',
	'MultiBarBottomLeftButton',
	'MultiBarBottomRightButton',
	'MultiBarRightButton',
	'MultiBarLeftButton',
}
