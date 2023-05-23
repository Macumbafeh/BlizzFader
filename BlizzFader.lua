local ADDON_NAME = "BlizzFader"
local ADDON_VERSION = 1

-- Default BlizzFaderDB
local defaultBlizzFaderDB = {
    opacity = 0.5,
}

-- Saved variables
BlizzFaderDB = BlizzFaderDB or {}

-- Interface options
local options = {
    type = "group",
    name = ADDON_NAME,
	order = 1,
    args = {
	   
	   opacityframe = {
         type = "group",
         name = "Frame Options",
         guiInline = true,
         order = 1,
         args = {
		 
        opacity = {
            type = "range",
            name = "Fade Alpha,
			order = 1,
            desc = "Set the visibility of frames outside of range",
            min = 0,
            max = 1,
            step = 0.1,
            get = function()
                return BlizzFaderDB.opacity
            end,
            set = function(info, value)
                BlizzFaderDB.opacity = value
            end
        },
	},
	},
	RangeClassCheck = {
         type = "group",
         name = "Range option",
         guiInline = true,
         order = 2,
         args = {
		 druidCheckButton = {
            type = "toggle",
            name = "10m",
			order = 2,
            desc = "Set the range at 10m, based on insecte?",
            get = function()
                return BlizzFaderDB.druidCheckButton
            end,
            set = function(info, value)
                BlizzFaderDB.druidCheckButton = value
            end,
            hidden = function()
                return select(2, UnitClass("player")) ~= "DRUID"
            end,
		},
		
    DruidEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
        return BlizzFaderDB.DruidEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.DruidEnemy = value; BlizzFader.UpdateFrames();
    end,
    values = {"40 meters [Soothe Animal] (lvl 22)", "30 meters [Wrath] (Nature's Reach: 33m, 36m)", "20 meters [Cyclone] (lvl 70 only)"},
    order = 2,
    hidden = function()
        return select(2, UnitClass("player")) ~= "DRUID"
    end,
    },
    DruidFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
        return BlizzFaderDB.DruidFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.DruidFriendly = value; BlizzFader.UpdateFrames();
    end,
    values = {"40 meters [Healing Touch]", "30 meters [Mark of the Wild]"},
    order = 2,
    hidden = function()
        return select(2, UnitClass("player")) ~= "DRUID"
    end,
    },
    
    ShamanEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
        return BlizzFaderDB.ShamanEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.ShamanEnemy = value; BlizzFader.UpdateFrames();
    end,
    values = {"30 meters [Lightning Bolt] (Storm Reach: 33m, 36m)", "30 meters [Purge] (lvl 12)", "20 meters [Earth Shock] (Gladiator Gloves: 25m)]"
    },
    order = 2,
    hidden = function()
        return select(2, UnitClass("player")) ~= "SHAMAN"
    end,
    },
    ShamanFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
        return BlizzFaderDB.ShamanFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.ShamanFriendly = value; BlizzFader.UpdateFrames();
    end,
    values = {"40 meters [Healing Wave]", "30 meters [Ancestral Spirit] (lvl 12)"
    },
    order = 2,
    hidden = function()
        return select(2, UnitClass("player")) ~= "SHAMAN"
    end,
    },
	  },
    },
  },
}

-- Function to register options
local function RegisterOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(ADDON_NAME, options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(ADDON_NAME, ADDON_NAME)
end

-- Call function to register options
RegisterOptions()

-- Party frames and target frame
local frameList = {}
local unitList = {}

-- Frame count
local frameCount = 0

-- Timer
local partyTimer = 0

-- Get frames
function BlizzFader.GetFrames()
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



-- Update frames
function BlizzFader.UpdateFrames()
    for i = 1, frameCount do
        local frame = frameList[i]
        local unit = unitList[i]
		
        if frame and unit then
            -- Determine if the player is enemy and in range
            if (UnitExists(unit) and not UnitIsDead(unit) and UnitCanAttack("player", unit)) then
                local inRange = true
                -- [DRUID]
                if BlizzFaderDB.DruidEnemy == 1 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Soothe Animal
                    inRange = IsSpellInRange(2908, unit) == 1
               elseif BlizzFaderDB.DruidEnemy == 2 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Wrath
                    inRange = IsSpellInRange(5176, unit) == 1
                elseif BlizzFaderDB.DruidEnemy == 3 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Cyclone
                    inRange = IsSpellInRange(33786, unit) == 1
             

                -- [SHAMAN]
                elseif BlizzFaderDB.ShamanEnemy == 1 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Lightning Bolt 
                    inRange = IsSpellInRange(403, unit) == 1
                elseif BlizzFaderDB.ShamanEnemy == 2 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Purge
                    inRange = IsSpellInRange(370, unit) == 1
                elseif BlizzFaderDB.ShamanEnemy == 3 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Earth Shock
                    inRange = IsSpellInRange(8042, unit) == 1
                    end
                -- Fade out the frame if the player is out of range
                if not inRange then
                    frame:SetAlpha(BlizzFaderDB.opacity)
                else
                    -- Fade in the frame if the player is in range
                    if frame:GetAlpha() < 0.8 then
                        frame:SetAlpha(1)
                    end
                end
            end

            -- Determine if the player is friend and in range
            if (UnitExists(unit) and not UnitIsDead(unit) and UnitIsFriend("player", unit)) then
                local inRange = true
                -- [DRUID]
                if BlizzFaderDB.DruidFriendly == 1 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Healing touch
                    inRange = IsSpellInRange(5185, unit) == 1
                elseif BlizzFaderDB.DruidFriendly == 2 and select(2, UnitClass("player")) == "DRUID" then
                    -- Mark of the Wild
                    inRange = IsSpellInRange(1126, unit) == 1

                    -- [SHAMAN]
               elseif BlizzFaderDB.DruidFriendly == 1 and select(2, UnitClass("player")) == "SHAMAN" then
                    -- Healing Wave
                    inRange = IsSpellInRange(331, unit) == 1
                elseif BlizzFaderDB.DruidFriendly == 2 and select(2, UnitClass("player")) == "SHAMAN" then
                    -- Ancestral Spirit
                    inRange = IsSpellInRange(2008, unit) == 1
                end
			 
                -- Fade out the frame if the player is out of range
                if not inRange then
                    frame:SetAlpha(BlizzFaderDB.opacity)
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
        BlizzFader.GetFrames()
        BlizzFader.UpdateFrames()
    end
end

local function OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "PARTY_MEMBERS_CHANGED" then
        BlizzFader.GetFrames()
        if frameCount > 0 then
            self:SetScript("OnUpdate", OnUpdate)
        else
            self:SetScript("OnUpdate", nil)
        end
elseif event == "PLAYER_TARGET_CHANGED" then
        BlizzFader.GetFrames()
        BlizzFader.UpdateFrames()
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", OnEvent)