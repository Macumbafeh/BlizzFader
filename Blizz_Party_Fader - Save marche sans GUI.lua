local opacity = 0.5 -- Set the visibility, 0 being invisible
local rangeThreshold = 40 -- Set the range threshold in yards

local partyTimer = 0
local frameList = {}
local unitList = {}
local frameCount = 0

local function GetFrames()
    -- Clear out the previous frame and unit lists
    wipe(frameList)
    wipe(unitList)

    -- Add party frames to the frame list
    for i = 1, 4 do
        local frameName = "PartyMemberFrame" .. i
        local frame = _G[frameName]
        if frame then
            table.insert(frameList, frame)
            table.insert(unitList, frame.unit)
        end
    end

    -- Add target frame to the frame list
    local targetFrame = _G["TargetFrame"]
    if targetFrame then
        table.insert(frameList, targetFrame)
        table.insert(unitList, "target")
    end
    
    -- Update the frame count
    frameCount = #frameList
end

local function UpdateFrames()
    for i = 1, frameCount do
        local frame = frameList[i]
        local unit = unitList[i]

      if frame and unit then
            -- Determine if the player is enemy and in range
         if(UnitExists(unit) and (not UnitIsDead(unit)) and UnitCanAttack("player", unit)) then
			local inRange = IsSpellInRange(33786, unit) == 1

            -- Fade out the frame if the player is out of range
            if not inRange then
                frame:SetAlpha(opacity)
            else
                -- Fade in the frame if the player is in range
                if frame:GetAlpha() < 0.8 then
                    frame:SetAlpha(1)
                end
            end
		end
			
		if(UnitExists(unit) and (not UnitIsDead(unit)) and UnitIsFriend("player", unit)) then
			local inRange = IsSpellInRange(5185, unit) == 1

            -- Fade out the frame if the player is out of range
            if not inRange then
                frame:SetAlpha(opacity)
            else
                -- Fade in the frame if the player is in range
                if frame:GetAlpha() < 0.8 then
                    frame:SetAlpha(1)
                end
            end
		end
      end
    end
end

local function OnUpdate(self, elapsed)
    partyTimer = partyTimer + elapsed
    if partyTimer > 0.1 then
        partyTimer = 0
        GetFrames()
        UpdateFrames()
    end
end

local function OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "PARTY_MEMBERS_CHANGED" then
        GetFrames()
        if frameCount > 0 then
            self:SetScript("OnUpdate", OnUpdate)
        else
            self:SetScript("OnUpdate", nil)
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        GetFrames()
        UpdateFrames()
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", OnEvent)
