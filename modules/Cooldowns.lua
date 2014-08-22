local WoD = select(2, ...).WoD

local function TimerCallback(self)
	self.Button.icon:SetAlpha(1)

	if(WoD) then
		self.Button.Timer = nil
	else
		self.Button.__finished = true
	end
end

local stopMethod = WoD and 'Cancel' or 'Stop'

local hooked = {}
hooksecurefunc('CooldownFrame_SetTimer', function(self, start, duration, _, charges)
	local Button = self:GetParent()
	if(not hooked[Button]) then
		return
	end

	local Timer = Button.Timer
	if(duration > 2 and charges == 0) then
		Button.icon:SetAlpha(1/5)

		if(Timer) then
			Timer[stopMethod](Timer)
		end

		if(WoD) then
			Timer = C_Timer.NewTimer(start - GetTime() + duration, TimerCallback)
			Timer.Button = Button
		else
			if(not Timer) then
				Timer = Button:CreateAnimationGroup()
				Timer:CreateAnimation('Animation'):SetOrder(1)
				Timer:SetScript('OnFinished', TimerCallback)
				Timer.Button = Button
			end

			Button.__finished = false
			Timer:GetAnimations():SetDuration(start - GetTime() + duration)
			Timer:Play()
		end

		Button.Timer = Timer
	elseif((WoD and Timer) or (not WoD and (Button.__finished ~= true and Button.__finished ~= nil))) then
		Timer[stopMethod](Timer)
		Button.icon:SetAlpha(1)
	end
end)

if(ActionBarButtonEventsFrame.frames) then
	for index, Button in next, ActionBarButtonEventsFrame.frames do
		hooked[Button] = true
	end
end
