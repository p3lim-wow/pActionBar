local Hider = CreateFrame('Frame', 'pActionBarHider')
Hider:Hide()

local function null() end

for _, frame in pairs({
	'MainMenuBar',
	'MainMenuBarPageNumber',
	'ActionBarDownButton',
	'ActionBarUpButton',
	'OverrideActionBarExpBar',
	'OverrideActionBarHealthBar',
	'OverrideActionBarPowerBar',
	'OverrideActionBarPitchFrame',
	'OverrideActionBarLeaveFrame',
	'CharacterMicroButton',
	'SpellbookMicroButton',
	'TalentMicroButton',
	'AchievementMicroButton',
	'QuestLogMicroButton',
	'GuildMicroButton',
	'PVPMicroButton',
	'LFDMicroButton',
	'StoreMicroButton',
	'CompanionsMicroButton',
	'EJMicroButton',
	'MainMenuMicroButton',
	'HelpMicroButton',
	'MainMenuBarBackpackButton',
	'CharacterBag0Slot',
	'CharacterBag1Slot',
	'CharacterBag2Slot',
	'CharacterBag3Slot',
	'StanceBarFrame',
}) do
	_G[frame]:SetParent(Hider)
	_G[frame].SetParent = null
end

for _, texture in pairs({
	'StanceBarLeft',
	'StanceBarMiddle',
	'StanceBarRight',
	'SlidingActionBarTexture0',
	'SlidingActionBarTexture1',
	'PossessBackground1',
	'PossessBackground2',
	'MainMenuBarTexture0',
	'MainMenuBarTexture1',
	'MainMenuBarTexture2',
	'MainMenuBarTexture3',
	'MainMenuBarLeftEndCap',
	'MainMenuBarRightEndCap',
}) do
	_G[texture]:SetTexture(nil)
end

for _, texture in pairs({
	'_BG',
	'EndCapL',
	'EndCapR',
	'_Border',
	'Divider1',
	'Divider2',
	'Divider3',
	'ExitBG',
	'MicroBGL',
	'MicroBGR',
	'_MicroBGMid',
	'ButtonBGL',
	'ButtonBGR',
	'_ButtonBGMid',
}) do
	OverrideActionBar[texture]:SetAlpha(0)
end
