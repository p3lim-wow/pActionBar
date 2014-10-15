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
	SetCVar('countdownForCooldowns', 0)
end)

local function UpdateButton(self)
	local Button = self:GetParent()
	local action = Button.action

	Button.icon:SetVertexColor(1, 1, 1)

	if(not IsUsableAction(action)) then
		Button.icon:SetVertexColor(1/4, 1/4, 1/4)
	else
		Button.icon:SetVertexColor(1, 1, 1)
	end
end

local function PersistentNormalTexture(self, texture)
	if(texture) then
		self:SetNormalTexture(nil)
	end
end

local function SkinButton(Button, petButton, leaveButton)
	local name = Button:GetName()
	local buttonSize = petButton and 24 or 28

	Button:SetSize(buttonSize, buttonSize)
	Button:SetBackdrop(BACKDROP)
	Button:SetBackdropBorderColor(0, 0, 0)

	local Cooldown = Button.cooldown
	Cooldown:ClearAllPoints()
	Cooldown:SetPoint('CENTER')
	Cooldown:SetSize(buttonSize - 2, buttonSize - 2)

	local StringParent = CreateFrame('Frame', nil, Button)
	StringParent:SetFrameLevel(20)

	local HotKey = Button.HotKey

	local CheckedTexture = not leaveButton and Button:GetCheckedTexture()
	if(petButton) then
		HotKey:SetAlpha(0)

		hooksecurefunc(Button, 'SetNormalTexture', PersistentNormalTexture)

		CheckedTexture:SetTexture(0, 1/2, 1, 1/3)
		CheckedTexture:ClearAllPoints()
		CheckedTexture:SetPoint('TOPRIGHT', -1, -1)
		CheckedTexture:SetPoint('BOTTOMLEFT', 1, 1)

		_G[name .. 'AutoCastable']:SetAlpha(0)
	else
		HotKey:SetParent(StringParent)
		HotKey:ClearAllPoints()
		HotKey:SetPoint('BOTTOMRIGHT', Button, 0, 1)
		HotKey:SetFont(FONT, 8, 'OUTLINEMONOCHROME')

		local NormalTexture = Button.NormalTexture
		NormalTexture:SetTexture(nil)
		hooksecurefunc(NormalTexture, 'SetVertexColor', UpdateButton)

		if(CheckedTexture) then
			CheckedTexture:SetTexture(nil)
		end

		local NewActionTexture = Button.NewActionTexture
		if(NewActionTexture) then
			NewActionTexture:SetTexture(nil)
		end
	end

	local Count = Button.Count
	Count:SetParent(StringParent)
	Count:ClearAllPoints()
	Count:SetPoint('TOPLEFT', Button, 3, -3)
	Count:SetFont(FONT, 8, 'OUTLINEMONOCHROME')
	Count:SetJustifyH('LEFT')

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

	local Flash = Button.Flash
	Flash:SetTexture(1, 0, 0, 1/3)
	Flash:ClearAllPoints()
	Flash:SetPoint('TOPRIGHT', -1, -1)
	Flash:SetPoint('BOTTOMLEFT', 1, 1)

	local FloatingBG = _G[name .. 'FloatingBG']
	if(FloatingBG) then
		FloatingBG:Hide()
	end

	local FlyoutBorder = Button.FlyoutBorder
	if(FlyoutBorder) then
		FlyoutBorder:SetTexture(nil)
	end

	local FlyoutBorderShadow = Button.FlyoutBorderShadow
	if(FlyoutBorderShadow) then
		FlyoutBorderShadow:SetTexture(nil)
	end

	Button.Border:SetTexture(nil)
	Button.Name:Hide()

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
