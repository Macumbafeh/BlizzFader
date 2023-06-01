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
	width = "full",
    args = {
	   
	   opacityframe = {
         type = "group",
         name = "Frame Options",
         inline = true,
         order = 1,
        width = "full",
         args = {
		 
        opacity = {
            type = "range",
            name = "Fade Alpha",
			order = 1,
			-- width = "full",
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
		 inline = true,
		 width = "full",
         args = {
		 
		DisableEnemySpells = {
    type = "toggle",
    name = "Disable Harmful Spells",
    order = 0,
    width = "full",
    get = function()
		if BlizzFaderDB.DisableEnemySpells == nil then
			BlizzFaderDB.DisableEnemySpells = false -- Set the default index for the harmful spells
		end
        return BlizzFaderDB.DisableEnemySpells
    end,
    set = function(info, value)
        BlizzFaderDB.DisableEnemySpells = value
    end,
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
    -- Soothe Animal
	"|TInterface\\Icons\\Ability_Hunter_BeastSoothe:15:15|t 40m (lvl 22)", 
	-- Wrath
	"|TInterface\\Icons\\Spell_Nature_AbolishMagic:15:15|t 30m (33m, 36m Nature's Reach)", 
	-- Cyclone
	"|TInterface\\Icons\\Spell_Nature_EarthBind:15:15|t 20m (lvl 70 only)"},
    order = 1,
    width = "full",
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
    -- Lightning Bolt 
    "|TInterface\\Icons\\Spell_Nature_Lightning:15:15|t 30m (33m, 36m Storm Reach)", 
    -- Purge
	"|TInterface\\Icons\\Spell_Nature_Purge:15:15|t 30m (lvl 12)", 
	-- Earth Shock
	"|TInterface\\Icons\\Spell_Nature_EarthShock:15:15|t 20m (25m Gladiator Gloves)]",
    },
    order = 1,
    width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "SHAMAN"
    end,
    disabled = function()
        return BlizzFaderDB.DisableEnemySpells
    end,
    },


	MageEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.MageEnemy == nil then
            BlizzFaderDB.MageEnemy = 1 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.MageEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.MageEnemy = value;
    end,
    values = {
    -- Fireball
    "|TInterface\\Icons\\Spell_Fire_FlameBolt:15:15|t 35m (38m, 41m Flame Throwing)",
    -- Frost Bolt 
	  "|TInterface\\Icons\\Spell_Frost_FrostBolt02:15:15|t 30m (lvl 4, 33m, 36m Arctic Reach)", 
	  -- Scorch
	 "|TInterface\\Icons\\Spell_Fire_SoulBurn:15:15|t 30m (lvl 22, 33m, 36m Flame Throwing)",
	  -- Shoot
	 "|TInterface\\Icons\\Ability_ShootWand:15:15|t 30m", 
	  -- Fire Blast
	  "|TInterface\\Icons\\Spell_Fire_Fireball:15:15|t 20m (lvl 6, 23m, 26m Flame Throwing)", 
    },
    order = 1,
    width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "MAGE"
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
    width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "WARLOCK"
    end,
	disabled = function()
        return BlizzFaderDB.DisableEnemySpells
    end,
	 },
	 
	
	RogueEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.RogueEnemy == nil then
            BlizzFaderDB.RogueEnemy = 2 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.RogueEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.RogueEnemy = value;
    end,
    values = {
    -- Slice and Dice
    "|TInterface\\Icons\\Ability_Rogue_SliceDice:15:15|t 100m (lvl 10)",
    -- Throw
    "|TInterface\\Icons\\Ability_Throw:15:15|t 30m",
    -- Shadow Step
    "|TInterface\\Icons\\Ability_Rogue_Shadowstep:15:15|t 25m (lvl 50)",
    -- Blind
	  "|TInterface\\Icons\\Spell_Shadow_MindSteal:15:15|t 10m (lvl 34, 12m, 15m Dirty Tricks)", 
	  -- Sap
	 "|TInterface\\Icons\\Ability_Sap:15:15|t 5m (lvl 10, 7m, 10m Dirty Tricks)",
	  -- Eviscerate
	 "|TInterface\\Icons\\Ability_Rogue_Eviscerate:15:15|t 5m", 
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "ROGUE"
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
         width = "full",
		 inline = true,
         args = {

    DisableFriendlySpells = {
    type = "toggle",
    name = "Disable Friendly Spells",
    order = 0,
    width = "full",
    get = function()
		if BlizzFaderDB.DisableFriendlySpells == nil then
			BlizzFaderDB.DisableFriendlySpells = false -- Set the default index for the harmful spells
		end
        return BlizzFaderDB.DisableFriendlySpells
    end,
    set = function(info, value)
        BlizzFaderDB.DisableFriendlySpells = value
    end,
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
        -- Healing Touch
        "|TInterface\\Icons\\Spell_Nature_HealingTouch:15:15|t 40m",
        -- Mark of the Wild
        "|TInterface\\Icons\\Spell_Nature_Regeneration:15:15|t 30m",
    },
    order = 1,
    width = "full",
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
    -- Healing Wave   
    "|TInterface\\Icons\\Spell_Nature_HealingWaveGreater:15:15|t 40m", 
    -- Ancestral Spirit
	"|TInterface\\Icons\\Spell_Nature_Regenerate:15:15|t 30m(lvl 12)",
    },
    order = 1,
    width = "full",
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
    width = "full",
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
    width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "WARLOCK"
    end,
	disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
    end,
    },
	
	
	RogueFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.RogueFriendly == nil then
            BlizzFaderDB.RogueFriendly = 1 -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.RogueFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.RogueFriendly = value;
    end,
    values = {
    -- Bandage
    "|TInterface\\Icons\\INV_Misc_Bandage_Netherweave_Heavy:15:15|t 15m (Bandage required)",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "ROGUE"
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
            if (UnitExists(unit) and not UnitIsDead(unit) and not UnitIsDeadOrGhost(unit) and not UnitIsGhost(unit) and UnitIsConnected(unit) and UnitCanAttack("player", unit)) and not BlizzFaderDB.DisableEnemySpells then
                local inRange = true
				local inMeleeRange = false
                -- [DRUID]
                if BlizzFaderDB.DruidEnemy == 1 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Soothe Animal
                    if IsSpellInRange(2908) then
                    inRange = IsSpellInRange(2908, unit) == 1
                    else
						           inRange = true
				           	end
               elseif BlizzFaderDB.DruidEnemy == 2 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Wrath
                    if IsSpellInRange(5176) then
                    inRange = IsSpellInRange(5176, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.DruidEnemy == 3 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Cyclone
                    if IsSpellInRange(33786) then
                    inRange = IsSpellInRange(33786, unit) == 1
                    else
						           inRange = true
				           	end
             

                -- [SHAMAN]
                elseif BlizzFaderDB.ShamanEnemy == 1 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Lightning Bolt 
                    if IsSpellInRange(403) then
                    inRange = IsSpellInRange(403, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.ShamanEnemy == 2 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Purge
                    if IsSpellInRange(370) then
                    inRange = IsSpellInRange(370, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.ShamanEnemy == 3 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Earth Shock
                    if IsSpellInRange(8042) then
                    inRange = IsSpellInRange(8042, unit) == 1
                    else
						           inRange = true
				           	end
					
				
				-- [MAGE]
                elseif BlizzFaderDB.MageEnemy == 1 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Fireball 
                    if IsSpellInRange(133) then
                    inRange = IsSpellInRange(133, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.MageEnemy == 2 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Frost Bolt
                    if IsSpellInRange(116) then
                    inRange = IsSpellInRange(116, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.MageEnemy == 3 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Scorch
                    if IsSpellInRange(2948) then
                    inRange = IsSpellInRange(2948, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.MageEnemy == 4 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Shoot
                    if IsSpellInRange(5019) then
                    inRange = IsSpellInRange(5019, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.MageEnemy == 5 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Fire Blast
                    if IsSpellInRange(2136) then
                    inRange = IsSpellInRange(2136, unit) == 1
					           else
						           inRange = true
				           	end
				
				-- [WARLOCK]
                elseif BlizzFaderDB.WarlockEnemy == 1 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Immolate 
                    if IsSpellInRange(348) then
                    inRange = IsSpellInRange(348, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.WarlockEnemy == 2 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Corruption
                    if IsSpellInRange(172) then
                    inRange = IsSpellInRange(172, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.WarlockEnemy == 3 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Shoot
                    if IsSpellInRange(5019) then
                    inRange = IsSpellInRange(5019, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.WarlockEnemy == 4 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Fear
                    if IsSpellInRange(5782) then
                    inRange = IsSpellInRange(5782, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.WarlockEnemy == 5 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Shadowburn 
                    if IsSpellInRange(17877) then
						inRange = IsSpellInRange(17877, unit) == 1
					else
						inRange = true
					end
				
				
				-- [ROGUE]
                elseif BlizzFaderDB.RogueEnemy == 1 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Slice and Dice 
                    if IsSpellInRange(5171) then
                    inRange = IsSpellInRange(5171, unit) == 1
                    else
						           inRange = true
					           end
                elseif BlizzFaderDB.RogueEnemy == 2 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Throw
                    -- Check if within melee range for Eviscerate
					if IsSpellInRange(2098, unit) == 1 then
						inMeleeRange = true
					-- Check if out of range for Throw
					elseif IsSpellInRange(2764, unit) == 0 then
						inRange = false
					end
				
                elseif BlizzFaderDB.RogueEnemy == 3 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Shadow Step
                    if IsSpellInRange(36554) then
                    inRange = IsSpellInRange(36554, unit) == 1
                    else
						           inRange = true
					           end
                elseif BlizzFaderDB.RogueEnemy == 4 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Blind
                    if IsSpellInRange(2094) then
                    inRange = IsSpellInRange(2094, unit) == 1
                    else
						           inRange = true
					           end
                  elseif BlizzFaderDB.RogueEnemy == 5 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Sap
                    if IsSpellInRange(6770) then
                    inRange = IsSpellInRange(6770, unit) == 1
                    else
						           inRange = true
					           end
                elseif BlizzFaderDB.RogueEnemy == 6 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Eviscerate
                    if IsSpellInRange(2098) then
                    inRange = IsSpellInRange(2098, unit) == 1
                    else
						           inRange = true
					           end
                    end
                -- Fade out the frame if the player is out of range
                if not inRange then
                    frame:SetAlpha(BlizzFaderDB.opacity)
					
					TargetFrameFlash:Hide();
                else
                    -- Fade in the frame if the player is in range
                    if frame:GetAlpha() < 0.8 then
                        frame:SetAlpha(1)
                    end
				
				-- Add a red border if in melee range
				if inMeleeRange then
					TargetFrameFlash:SetVertexColor(1, 0, 0) -- Red border color
					TargetFrameFlash:Show();
				else
					TargetFrameFlash:Hide();
				end
                end
            end

            -- Determine if the player is friend and in range
            if (UnitExists(unit) and not UnitIsDead(unit) and not UnitIsDeadOrGhost(unit) and not UnitIsGhost(unit) and UnitIsConnected(unit) and UnitIsFriend("player", unit)) and not BlizzFaderDB.DisableFriendlySpells then
                local inRange = true
                -- [DRUID]
                if BlizzFaderDB.DruidFriendly == 1 and select(2, UnitClass("player")) == "DRUID" then 
                    
                    -- Healing touch
                    if IsSpellInRange(5185) then
                    inRange = IsSpellInRange(5185, unit) == 1
                    else
						           inRange = true
				           	end
                elseif BlizzFaderDB.DruidFriendly == 2 and select(2, UnitClass("player")) == "DRUID" then
                    -- Mark of the Wild
                    if IsSpellInRange(1126) then
                    inRange = IsSpellInRange(1126, unit) == 1
                    else
						inRange = true
					end


                -- [SHAMAN]
               elseif BlizzFaderDB.DruidFriendly == 1 and select(2, UnitClass("player")) == "SHAMAN" then
                    -- Healing Wave
                    if IsSpellInRange(331) then
                    inRange = IsSpellInRange(331, unit) == 1
                    else
						inRange = true
					end
               elseif BlizzFaderDB.DruidFriendly == 2 and select(2, UnitClass("player")) == "SHAMAN" then
                    -- Ancestral Spirit
                    if IsSpellInRange(2008) then
                    inRange = IsSpellInRange(2008, unit) == 1
                    else
						inRange = true
					end
					
					
				-- [MAGE]
               elseif BlizzFaderDB.MageFriendly == 1 and select(2, UnitClass("player")) == "MAGE" then
                    -- Arcane Brilliance
                    if IsSpellInRange(23028) then
                    inRange = IsSpellInRange(23028, unit) == 1
                    else
						inRange = true
					end
               elseif BlizzFaderDB.MageFriendly == 2 and select(2, UnitClass("player")) == "MAGE" then
                    -- Arcane Intellect
                    if IsSpellInRange(1459) then
                    inRange = IsSpellInRange(1459, unit) == 1
                    else
						inRange = true
					end
				

				-- [WARLOCK]
               elseif BlizzFaderDB.WarlockFriendly == 1 and select(2, UnitClass("player")) == "WARLOCK" then
                    -- Unending Breath
                    if IsSpellInRange(5697) then
						inRange = IsSpellInRange(5697, unit) == 1
					else
						inRange = true
					end
				
				
				-- [ROGUE]
               elseif BlizzFaderDB.RogueFriendly == 1 and select(2, UnitClass("player")) == "ROGUE" then
                    -- Bandage
                    inRange = IsItemInRange(21991, unit) == 1
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