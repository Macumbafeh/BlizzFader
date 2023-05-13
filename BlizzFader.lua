local opacity = 0.5 -- Set the visibility, 0 being invisible
local rangeThreshold = 40 -- Set the range threshold in yards

local _G = _G
local LibStub = LibStub or error("LibStub not found!")
local BlizzFader = LibStub("AceAddon-3.0"):GetAddon("BlizzFader")

local L = BlizzFader.L

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
         if UnitExists(unit) and not UnitIsDead(unit) and UnitCanAttack("player", unit) then
			local inRange = IsSpellInRange(8921, unit) == 1
			-- local inRange = IsSpellInRange(172, unit) == 1 warlock

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
			
		if UnitExists(unit) and not UnitIsDead(unit) and not (UnitCanAttack("player", unit)) or UnitIsFriend("player", unit) then
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



-- Define the options table
local options = {
    name = "BlizzFader", -- Name of the addon
    handler = BlizzFader, -- Handler object for the addon
    type = "group",
    args = {
        alphaSlider = { -- Alpha slider
            type = "range",
            name = "Frame Alpha",
            desc = "Set the alpha of the frame",
            min = 0,
            max = 1,
            step = 0.05,
            get = function(info) return BlizzFader.db.profile.frameAlpha end,
            set = function(info, value) BlizzFader.db.profile.frameAlpha = value end,
            order = 1,
        },
        showFrame = { -- Check button
            type = "toggle",
            name = "Show Frame",
            desc = "Toggle the visibility of the frame",
            get = function(info) return BlizzFader.db.profile.showFrame end,
            set = function(info, value) BlizzFader.db.profile.showFrame = value end,
            order = 2,
        },
    },
}

-- Create a new options panel
local optionsPanel = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("BlizzFader")
optionsPanel.default = function() BlizzFader.db:ResetProfile() end
optionsPanel.refresh = function() BlizzFader:RefreshConfig() end
optionsPanel.args = options.args