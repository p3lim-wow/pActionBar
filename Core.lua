local FONT = [[Interface\AddOns\pActionBar\semplice.ttf]]
local TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local BACKDROP = {
	edgeFile = TEXTURE, edgeSize = 1,
	insets = {left = 1, right = 1, top = 1, bottom = 1},
}

local function null() end

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
	self:SetNormalTexture(nil)
end

local function SkinButton(name, size)
	local Button = _G[name]
	Button:SetSize(size or 28, size or 28)
	Button:SetBackdrop(BACKDROP)
	Button:SetBackdropBorderColor(0, 0, 0)

	local Hotkey = _G[name .. 'HotKey']
	local CheckedTexture = Button:GetCheckedTexture()
	if(size) then
		Hotkey:SetAlpha(0)

		hooksecurefunc(Button, 'SetNormalTexture', PersistentNormalTexture)

		CheckedTexture.SetAlpha = null
		CheckedTexture:SetTexture(0, 1/2, 1, 1/3)
		CheckedTexture:ClearAllPoints()
		CheckedTexture:SetPoint('TOPRIGHT', -1, -1)
		CheckedTexture:SetPoint('BOTTOMLEFT', 1, 1)

		_G[name .. 'Shine']:SetSize(size * 0.9, size * 0.9)
		_G[name .. 'AutoCastable']:SetAlpha(0)
	else
		Hotkey:ClearAllPoints()
		Hotkey:SetPoint('BOTTOMRIGHT', 0, 1)
		Hotkey:SetFont(FONT, 8, 'OUTLINEMONOCHROME')

		CheckedTexture:SetTexture(nil)
	end

	local Count = _G[name .. 'Count']
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

	local NormalTexture = _G[name .. 'NormalTexture']
	if(NormalTexture) then
		NormalTexture:SetTexture(nil)
		hooksecurefunc(NormalTexture, 'SetVertexColor', UpdateButton)
	end

	local FloatingBG = _G[name .. 'FloatingBG']
	if(FloatingBG) then
		FloatingBG:Hide()
	end

	local FlyoutBorder = _G[name .. 'FlyoutBorder']
	if(FlyoutBorder) then
		FlyoutBorder:SetTexture(nil)
	end

	local FlyoutBorderShadow = _G[name .. 'FlyoutBorderShadow']
	if(FlyoutBorderShadow) then
		FlyoutBorderShadow:SetTexture(nil)
	end

	_G[name .. 'Border']:SetTexture(nil)
	_G[name .. 'Name']:Hide()

	Button.Skinned = true
end

local _, ns = ...
ns.SkinButton = SkinButton

ns.actionButtons = {
	'ActionButton',
	'MultiBarBottomLeftButton',
	'MultiBarBottomRightButton',
	'MultiBarRightButton',
	'MultiBarLeftButton',
}
