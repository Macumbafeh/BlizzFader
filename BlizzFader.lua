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
	
    args = {
	   
	   opacityframe = {
         type = "group",
         name = "Frame Options",
         guiInline = true,
         order = 1,
         args = {
		 
        opacity = {
            type = "range",
            name = "Fade Alpha",
			order = 1,
            desc = "Set the visibility of frames outside of range",
            min = 0,
            max = 1,
            step = 0.1,
            get = function()
				if BlizzFaderDB.opacity == 0 then
				BlizzFaderDB.opacity = 0.5 -- Set the default index for the harmful spells
				end
                return BlizzFaderDB.opacity
            end,
            set = function(info, value)
                BlizzFaderDB.opacity = value
            end
        },
	},
	},
	RangeEnemy = {
         type = "group",
         name = "Enemy target Range option",
         order = 2,
		 guiInline = true,
         args = {
		 
		DisableEnemySpells = {
    type = "toggle",
    name = "Disable Harmful Spells",
    get = function()
		if BlizzFaderDB.DisableEnemySpells == nil then
			BlizzFaderDB.DisableEnemySpells = false -- Set the default index for the harmful spells
		end
        return BlizzFaderDB.DisableEnemySpells
    end,
    set = function(info, value)
        BlizzFaderDB.DisableEnemySpells = value
    end,
    order = 0,
},

     DruidEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.DruidEnemy == nil then
            BlizzFaderDB.DruidEnemy = 2 -- Set the default index for the harmful spells
        end
        return BlizzFaderDB.DruidEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.DruidEnemy = value;
    end,
    values = {
	"|TInterface\\Icons\\Ability_Hunter_BeastSoothe:15:15|t 40m (lvl 22)", 
	"|TInterface\\Icons\\Spell_Nature_AbolishMagic:15:15|t 30m (33m, 36m Nature's Reach)", 
	"|TInterface\\Icons\\Spell_Nature_EarthBind:15:15|t 20m (lvl 70 only)"},
    order = 1,
    hidden = function()
        return select(2, UnitClass("player")) ~= "DRUID"
    end,
    disabled = function()
        return BlizzFaderDB.DisableEnemySpells
    end,
    },


    ShamanEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.ShamanEnemy == nil then
            BlizzFaderDB.ShamanEnemy = 1 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.ShamanEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.ShamanEnemy = value;
    end,
    values = {
    "|TInterface\\Icons\\Spell_Nature_Lightning:15:15|t 30m (33m, 36m Storm Reach)", 
	"|TInterface\\Icons\\Spell_Nature_Purge:15:15|t 30m (lvl 12)", 
	"|TInterface\\Icons\\Spell_Nature_EarthShock:15:15|t 20m (25m Gladiator Gloves)]",
    },
    order = 1,
    hidden = function()
        return select(2, UnitClass("player")) ~= "SHAMAN"
    end,
    disabled = function()
        return BlizzFaderDB.DisableEnemySpells
    end,
    },


	WarlockEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.WarlockEnemy == nil then
            BlizzFaderDB.WarlockEnemy = 1 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.WarlockEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.WarlockEnemy = value;
    end,
    values = {
    -- Immolate
    "|TInterface\\Icons\\Spell_Fire_Immolation:15:15|t 30m (33m, 36m Destructive Reach)",
    -- Corruption
	  "|TInterface\\Icons\\Spell_Shadow_AbominationExplosion:15:15|t 30m (lvl 4, 33m, 36m Grim Reach)", 
	  -- Shoot
	 "|TInterface\\Icons\\Ability_ShootWand:15:15|t 30m", 
	 -- Fear
	 "|TInterface\\Icons\\Spell_Shadow_Possession:15:15|t 20m (lvl 8, 22m, 24m Grim Reach)",
   -- Shadowburn
   "|TInterface\\Icons\\Spell_Shadow_ScourgeBuild:15:15|t 20m (lvl 20, 22m, 24m Destructive Reach)", 
    },
    order = 1,
    hidden = function()
        return select(2, UnitClass("player")) ~= "WARLOCK"
    end,
	disabled = function()
        return BlizzFaderDB.DisableEnemySpells
    end,
	
	
	
    },
	},
	},


   RangeFriendly = {
         type = "group",
         name = "Friendly target and Party Range option",       
         order = 3,
		 guiInline = true,
         args = {

    DisableFriendlySpells = {
    type = "toggle",
    name = "Disable Friendly Spells",
    get = function()
		if BlizzFaderDB.DisableFriendlySpells == nil then
			BlizzFaderDB.DisableFriendlySpells = false -- Set the default index for the harmful spells
		end
        return BlizzFaderDB.DisableFriendlySpells
    end,
    set = function(info, value)
        BlizzFaderDB.DisableFriendlySpells = value
    end,
    order = 0,
},

    DruidFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.DruidFriendly == nil then
            BlizzFaderDB.DruidFriendly = 1 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.DruidFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.DruidFriendly = value;
    end,
    values = {
        "|TInterface\\Icons\\Spell_Nature_HealingTouch:15:15|t 40m",
        "|TInterface\\Icons\\Spell_Nature_Regeneration:15:15|t 30m",
    },
    order = 1,
    hidden = function()
        return select(2, UnitClass("player")) ~= "DRUID"
    end,
    disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
    end,
    },

    ShamanFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.ShamanFriendly == nil then
            BlizzFaderDB.ShamanFriendly = 1 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.ShamanFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.ShamanFriendly = value;
    end,
    values = {
    "|TInterface\\Icons\\Spell_Nature_HealingWaveGreater:15:15|t 40m", 
	"|TInterface\\Icons\\Spell_Nature_Regenerate:15:15|t 30m(lvl 12)",
    },
    order = 1,
    hidden = function()
        return select(2, UnitClass("player")) ~= "SHAMAN"
    end,
    disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
    end,
    },
	
	MageFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.MageFriendly == nil then
            BlizzFaderDB.MageFriendly = 2 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.MageFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.MageFriendly = value;
    end,
    values = {
    -- Arcane Brilliance
    "|TInterface\\Icons\\Spell_Holy_ArcaneIntellect:15:15|t 40m (lvl 56)",
     -- Arcane Intellect
	"|TInterface\\Icons\\Spell_Holy_MagicalSentry:15:15|t 30m"
    },
    order = 1,
    hidden = function()
        return select(2, UnitClass("player")) ~= "MAGE"
    end,
	 disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
    end,
    },
	
	
	WarlockFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.WarlockFriendly == nil then
            BlizzFaderDB.WarlockFriendly = 1 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.WarlockFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.WarlockFriendly = value;
    end,
    values = {
    -- Unending Breath
    "|TInterface\\Icons\\Spell_Shadow_DemonBreath:15:15|t 30m (lvl 16)",
    },
    order = 1,
    hidden = function()
        return select(2, UnitClass("player")) ~= "WARLOCK"
    end,
	disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
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



-- Update frames
local function UpdateFrames()
    for i = 1, frameCount do
        local frame = frameList[i]
        local unit = unitList[i]
		
        if frame and unit then
			
            -- Determine if the player is enemy and in range
            if (UnitExists(unit) and not UnitIsDead(unit) and not UnitIsDeadOrGhost(unit) and not UnitIsGhost(unit) and UnitIsConnected(unit) and UnitCanAttack("player", unit)) then
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
					
				
				-- [MAGE]
                elseif BlizzFaderDB.MageEnemy == 1 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Fireball 
                    inRange = IsSpellInRange(133, unit) == 1
                elseif BlizzFaderDB.MageEnemy == 2 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Frost Bolt
                    inRange = IsSpellInRange(116, unit) == 1
                elseif BlizzFaderDB.MageEnemy == 3 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Scorch
                    inRange = IsSpellInRange(2948, unit) == 1
                elseif BlizzFaderDB.MageEnemy == 4 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Shoot
                    inRange = IsSpellInRange(5019, unit) == 1
                elseif BlizzFaderDB.MageEnemy == 5 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Fire Blast
                    inRange = IsSpellInRange(2136, unit) == 1
					
				
				-- [WARLOCK]
                elseif BlizzFaderDB.WarlockEnemy == 1 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Immolate 
                    inRange = IsSpellInRange(348, unit) == 1
                elseif BlizzFaderDB.WarlockEnemy == 2 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Corruption
                    inRange = IsSpellInRange(172, unit) == 1
                elseif BlizzFaderDB.WarlockEnemy == 3 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Shoot
                    inRange = IsSpellInRange(5019, unit) == 1
                elseif BlizzFaderDB.WarlockEnemy == 4 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Fear
                    inRange = IsSpellInRange(5782, unit) == 1
                elseif BlizzFaderDB.WarlockEnemy == 5 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Shadowburn 
                    if IsSpellInRange(17877) then
						inRange = IsSpellInRange(17877, unit) == 1
					else
						inRange = true
					end
				
				
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
            if (UnitExists(unit) and not UnitIsDead(unit) and not UnitIsDeadOrGhost(unit) and not UnitIsGhost(unit) and UnitIsConnected(unit) and UnitIsFriend("player", unit)) then
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
					
					
				-- [MAGE]
               elseif BlizzFaderDB.MageFriendly == 1 and select(2, UnitClass("player")) == "MAGE" then
                    -- Arcane Brilliance
                    inRange = IsSpellInRange(23028, unit) == 1
               elseif BlizzFaderDB.MageFriendly == 2 and select(2, UnitClass("player")) == "MAGE" then
                    -- Arcane Intellect
                    inRange = IsSpellInRange(1459, unit) == 1
				

				-- [WARLOCK]
               elseif BlizzFaderDB.WarlockFriendly == 1 and select(2, UnitClass("player")) == "WARLOCK" then
                    -- Unending Breath
                    if IsSpellInRange(5697) then
						inRange = IsSpellInRange(5697, unit) == 1
					else
						inRange = true
					end
					
					
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