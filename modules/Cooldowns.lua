local WoD = select(2, ...).WoD

local function TimerCallback(self)
	local Button = self.Button
	Button.icon:SetAlpha(1)

	if(WoD) then
		Button.Timer = nil
	else
		Button.__finished = true
	end
end

local stopMethod = WoD and 'Cancel' or 'Stop'

local hooked = {}
hooksecurefunc('CooldownFrame_SetTimer', function(self, start, duration, _, charges, _, override)
	local Button = self:GetParent()
	if(not hooked[Button]) then
		return
	end

	local Timer = Button.Timer
	if(duration > 2) then
		if(charges > 0) then
			if(WoD) then
				self:SetSwipeColor(0, 0, 0, 0.9)
				CooldownFrame_SetTimer(self, start, duration, true, 0, 0, true)
			else
				return
			end
		elseif(not override) then
			if(WoD) then
				self:SetSwipeColor(0, 0, 0)
			end

			Button.icon:SetAlpha(1/5)
		end

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
