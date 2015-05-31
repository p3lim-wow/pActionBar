local function TimerCallback(self)
	local Button = self.Button
	Button.icon:SetAlpha(1)
	Button.Timer = nil
end

local hooked = {}
hooksecurefunc('CooldownFrame_SetTimer', function(self, start, duration, _, charges, _, override)
	local Button = self:GetParent()
	if(not hooked[Button]) then
		return
	end

	local Timer = Button.Timer
	if(duration > 2) then
		if(charges and charges > 0) then
			self:SetSwipeColor(0, 0, 0, 0.9)
			CooldownFrame_SetTimer(self, start, duration, true, 0, 0, true)
		elseif(not override) then
			self:SetSwipeColor(0, 0, 0)
			Button.icon:SetAlpha(1/5)
		end

		if(Timer) then
			Timer:Cancel()
		end

		Timer = C_Timer.NewTimer(math.max(0, start - GetTime() + duration), TimerCallback)
		Timer.Button = Button

		Button.Timer = Timer
	elseif(Timer) then
		Timer:Cancel()
		Button.icon:SetAlpha(1)
	end
end)

if(ActionBarButtonEventsFrame.frames) then
	for index, Button in next, ActionBarButtonEventsFrame.frames do
		hooked[Button] = true
	end
end
