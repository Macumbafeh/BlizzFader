local ADDON_NAME = "BlizzFader"
local ADDON_VERSION = 1

-- Default BlizzFaderDB
local defaultBlizzFaderDB = {
    opacity = 0.5,
	enableRedBorder = true,
	enableDeadzoneHighlight = true,
	enableSquare = false,
	DisableEnemySpells = false,
	DruidEnemy = 2,
	ShamanEnemy = 1,
	MageEnemy = 1,
	WarlockEnemy = 1,
	RogueEnemy = 2,
	PriestEnemy = 1,
	HunterEnemy = 4,
	PaladinEnemy = 1,
	WarriorEnemy = 1,
	DisableFriendlySpells = false,
	DruidFriendly = 1,
	ShamanFriendly = 1,
	MageFriendly = 2,
	WarlockFriendly = 1,
	RogueFriendly = 1,
	PriestFriendly = 1,
	HunterFriendly = 1,
	PaladinFriendly = 1,
	WarriorFriendly = 1,
}


-- Saved variables
BlizzFaderDB = BlizzFaderDB or {}

local function HighlightDebug()
local queryitem = {8149, 24268, 34368, 21991, 21519, 32321};
if (queryitem) and (queryitem ~= nil) and (queryitem ~= "") and (queryitem ~= 0) then
    for i, itemID in ipairs(queryitem) do
        local itemName = GetItemInfo(itemID)
        -- print(itemName)
        GameTooltip:SetHyperlink("item:"..itemID..":0:0:0:0:0:0:0");
    end
end
    print("Highlights debug done.")
end

local function resetred()
    BlizzFaderDB.redBorderColor = { r = 1, g = 0, b = 0, a = 1 } -- Default red color
end

local function resetyellow()
    BlizzFaderDB.yellowBorderColor = { r = 1, g = 1, b = 0, a = 1 } -- Default yellow color
end

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
				if BlizzFaderDB.opacity == nil then
				BlizzFaderDB.opacity = defaultBlizzFaderDB.opacity -- Set the default index for the harmful spells
				end
                return BlizzFaderDB.opacity
            end,
            set = function(info, value)
                BlizzFaderDB.opacity = value
            end
        },
	},
},

			debugoptions = {
				name = "",
				type = "group",
				order = 0,
				inline = true,
				width = "full",
				args = {
					debugButton = {
						type = "execute",
						name = "Highlight Debug",
						desc = "Click to query items and make Melee range and Deadzone range highlights works.",
						func = function()
							HighlightDebug()
						end,
					},
				},
			},

	ColorEnemy = {
         type = "group",
         name = "Enemy target Range option",
         order = 2,
		 inline = true,
		 width = "full",
         args = {
		 
		 enableRedBorder = {
    type = "toggle",
    name = "Enable Melee Border",
    desc = "Toggle the red border around the frame when in melee range",
    order = 0,
    width = "full",
    get = function()
			if BlizzFaderDB.enableRedBorder == nil then
			BlizzFaderDB.enableRedBorder = defaultBlizzFaderDB.enableRedBorder -- Set the default index
		end
			return BlizzFaderDB.enableRedBorder
          end,
    set = function(_, value)
			BlizzFaderDB.enableRedBorder = value
          end,
},

redBorderColor = {
    type = "color",
    name = "Melee Border Color",
    desc = "Set the color of the Melee border",
    order = 1,
    get = function()
        local color = BlizzFaderDB.redBorderColor or { r = 1, g = 0, b = 0, a = 1 } -- Default red color
        return color.r, color.g, color.b, color.a
    end,
    set = function(_, r, g, b, a)
        BlizzFaderDB.redBorderColor = { r = r, g = g, b = b, a = a }
    end,
    hasAlpha = true,
    disabled = function()
        return not BlizzFaderDB.enableRedBorder
    end,
},

resetButton1 = {
        type = "execute",
        name = "Reset Melee Color",
        desc = "Reset the color option to default for the Melee Border Color",
        order = 2,
        func = resetred,
    },

enableDeadzoneHighlight = {
    type = "toggle",
    name = "Enable Deadzone Border",
    desc = "Toggle the yellow border around the frame when in deadzone range",
    order = 3,
    width = "full",
    get = function()
			if BlizzFaderDB.enableDeadzoneHighlight == nil then
			BlizzFaderDB.enableDeadzoneHighlight = defaultBlizzFaderDB.enableDeadzoneHighlight -- Set the default index
		end
			return BlizzFaderDB.enableDeadzoneHighlight
          end,
    set = function(_, value)
			BlizzFaderDB.enableDeadzoneHighlight = value
          end,
},

yellowBorderColor = {
    type = "color",
    name = "Deadzone Border Color",
    desc = "Set the color of the Deadzone border",
    order = 4,
    get = function()
        local color = BlizzFaderDB.yellowBorderColor or { r = 1, g = 1, b = 0, a = 1 } -- Default red color
        return color.r, color.g, color.b, color.a
    end,
    set = function(_, r, g, b, a)
        BlizzFaderDB.yellowBorderColor = { r = r, g = g, b = b, a = a }
    end,
    hasAlpha = true,
    disabled = function()
        return not BlizzFaderDB.enableDeadzoneHighlight
    end,
},

resetButton2 = {
        type = "execute",
        name = "Reset Deadzone Color",
        desc = "Reset the color option to default for the Deadzone Border Color",
        order = 5,
        func = resetyellow,
    },
	
enableSquare = {
    type = "toggle",
    name = "Enable Square",
    desc = "Toggle Square to replace the yellow/red border around the frame",
    order = 6,
    width = "full",
    get = function()
			if BlizzFaderDB.enableSquare == nil then
			BlizzFaderDB.enableSquare = defaultBlizzFaderDB.enableSquare -- Set the default index
		end
			return BlizzFaderDB.enableSquare
          end,
    set = function(_, value)
			BlizzFaderDB.enableSquare = value
          end,
},
},
},		 
	RangeEnemy = {
         type = "group",
         name = "Enemy target Range option",
         order = 3,
		 inline = true,
		 width = "full",
         args = {
		 
		 
		 
		DisableEnemySpells = {
    type = "toggle",
    name = "Disable Harmful Spells",
	desc = "Disable Harmful spells for Target Frame",
    order = 0,
    width = "full",
    get = function()
		if BlizzFaderDB.DisableEnemySpells == nil then
			BlizzFaderDB.DisableEnemySpells = defaultBlizzFaderDB.DisableEnemySpells -- Set the default index for the harmful spells
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
            BlizzFaderDB.DruidEnemy = defaultBlizzFaderDB.DruidEnemy -- Set the default index for the harmful spells
        end
        return BlizzFaderDB.DruidEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.DruidEnemy = value;
    end,
    values = {
    -- Soothe Animal
	"|TInterface\\Icons\\Ability_Hunter_BeastSoothe:15:15|t 40m (lvl 22, 44m, 48m Nature's Reach, Beast only)", 
	-- Wrath
	"|TInterface\\Icons\\Spell_Nature_AbolishMagic:15:15|t 30m (33m, 36m Nature's Reach)", 
	-- Cyclone
	"|TInterface\\Icons\\Spell_Nature_EarthBind:15:15|t 20m (lvl 70, 22m, 24m Nature's Reach)",
	-- Feral Charge
	"|TInterface\\Icons\\Ability_Hunter_Pet_Bear:15:15|t 8-25m (lvl 20)",
	-- Bash (Growl)
	"|TInterface\\Icons\\Ability_Druid_Bash:15:15|t 5m (lvl 10)",
	},
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
            BlizzFaderDB.ShamanEnemy = defaultBlizzFaderDB.ShamanEnemy -- Set the default index for the friendly spells
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
	-- Stormstrike
	"|TInterface\\Icons\\Ability_Shaman_Stormstrike:15:15|t 5m (lvl 40)]",
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
            BlizzFaderDB.MageEnemy = defaultBlizzFaderDB.MageEnemy -- Set the default index for the friendly spells
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
            BlizzFaderDB.WarlockEnemy = defaultBlizzFaderDB.WarlockEnemy -- Set the default index for the friendly spells
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
            BlizzFaderDB.RogueEnemy = defaultBlizzFaderDB.RogueEnemy -- Set the default index for the friendly spells
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
    "|TInterface\\Icons\\Ability_Throw:15:15|t 5-30m",
    -- Shadow Step
    "|TInterface\\Icons\\Ability_Rogue_Shadowstep:15:15|t 25m (lvl 50)",
    -- Blind
	  "|TInterface\\Icons\\Spell_Shadow_MindSteal:15:15|t 10m (lvl 34, 12m, 15m Dirty Tricks, Humanoid only)", 
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
	
	
	PriestEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.PriestEnemy == nil then
            BlizzFaderDB.PriestEnemy = defaultBlizzFaderDB.PriestEnemy -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.PriestEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.PriestEnemy = value;
    end,
    values = {
    -- Smite
    "|TInterface\\Icons\\Spell_Holy_HolySmite:15:15|t 30m (33m, 36m Holy Reach)",
    -- Shadow Word: Pain
	"|TInterface\\Icons\\Spell_Shadow_ShadowWordPain:15:15|t 30m (lvl 4, 33m, 36m Shadow Reach)", 
	  -- Shoot
	"|TInterface\\Icons\\Ability_ShootWand:15:15|t 30m", 
	 -- Mind Flay
	 "|TInterface\\Icons\\Spell_Shadow_SiphonMana:15:15|t 20m (lvl 20, 22m, 24m Grim Reach)",
	 -- Mind Control
	 "|TInterface\\Icons\\Spell_Shadow_ShadowWordDominate:15:15|t 20m (lvl 30, Humanoid only)",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "PRIEST"
    end,
    disabled = function()
        return BlizzFaderDB.DisableEnemySpells
    end,
    },
	
	
	HunterEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.HunterEnemy == nil then
            BlizzFaderDB.HunterEnemy = defaultBlizzFaderDB.HunterEnemy -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.HunterEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.HunterEnemy = value;
    end,
    values = {
    -- Hunter's Mark
    "|TInterface\\Icons\\Ability_Hunter_SniperShot:15:15|t 100m",
    -- Kill Command
    "|TInterface\\Icons\\Ability_Hunter_KillCommand:15:15|t 45m (lvl 66)",
    -- Auto Shot
    "|TInterface\\Icons\\Ability_Whirlwind:15:15|t 5-35m (37m, 39m, 41m Hawk Eye)",
    -- Throw
    "|TInterface\\Icons\\Ability_Throw:15:15|t 30m",
    -- Scatter Shot
	"|TInterface\\Icons\\Ability_GolemStormBolt:15:15|t 15m (lvl 30, 17m, 19m, 21m Hawk Eye)", 
	  -- Wing clip
	"|TInterface\\Icons\\Ability_Rogue_Trip:15:15|t 5m (lvl 12)",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "HUNTER"
    end,
    disabled = function()
        return BlizzFaderDB.DisableEnemySpells
    end,
    },
	
	
	PaladinEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.PaladinEnemy == nil then
            BlizzFaderDB.PaladinEnemy = defaultBlizzFaderDB.PaladinEnemy -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.PaladinEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.PaladinEnemy = value;
    end,
    values = {
    -- Hammer of Wrath
    "|TInterface\\Icons\\Ability_ThunderClap:15:15|t 30m (lvl 44)",
    -- Turn Undead
    "|TInterface\\Icons\\Spell_Holy_TurnUndead:15:15|t 20m (lvl 24, Undead only)",
    -- Holy Shock
    "|TInterface\\Icons\\Spell_Holy_SearingLight:15:15|t 20m (lvl 40)",
	-- Repentance
    "|TInterface\\Icons\\Spell_Holy_PrayerOfHealing:15:15|t 20m (lvl 40, Humanoid only)",
    -- Judgement
    "|TInterface\\Icons\\Spell_Holy_RighteousFury:15:15|t 10m (lvl 4)",
    -- Crusader Strike
    "|TInterface\\Icons\\Spell_Holy_CrusaderStrike:15:15|t 5m (lvl 50)",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "PALADIN"
    end,
    disabled = function()
        return BlizzFaderDB.DisableEnemySpells
    end,
    },
	
	
	WarriorEnemy = {
    type = "select",
    name = "Harmful Spells",
    desc = "Set the range based on harmful spells",
    get = function()
		if BlizzFaderDB.WarriorEnemy == nil then
            BlizzFaderDB.WarriorEnemy = defaultBlizzFaderDB.WarriorEnemy -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.WarriorEnemy
    end,
    set = function(info, value)
        BlizzFaderDB.WarriorEnemy = value;
    end,
    values = {
    -- Shoot
    "|TInterface\\Icons\\Ability_Marksmanship:15:15|t 5-30m",
    -- Charge
    "|TInterface\\Icons\\Ability_Warrior_Charge:15:15|t 8-25m (lvl 4)",
    -- Intimidating Shout
	  "|TInterface\\Icons\\Ability_GolemThunderClap:15:15|t 10m (lvl 22)", 
	  -- Rend
	 "|TInterface\\Icons\\ability_gouge:15:15|t 5m (lvl 4)",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "WARRIOR"
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
         order = 4,
         width = "full",
		 inline = true,
         args = {

    DisableFriendlySpells = {
    type = "toggle",
    name = "Disable Friendly Spells",
	desc = "Disable Friendly spells for Target and Party Frames",
    order = 0,
    -- width = "full",
    get = function()
		if BlizzFaderDB.DisableFriendlySpells == nil then
			BlizzFaderDB.DisableFriendlySpells = defaultBlizzFaderDB.DisableFriendlySpells -- Set the default index for the harmful spells
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
            BlizzFaderDB.DruidFriendly = defaultBlizzFaderDB.DruidFriendly -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.DruidFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.DruidFriendly = value;
    end,
    values = {
        -- Healing Touch
        "|TInterface\\Icons\\Spell_Nature_HealingTouch:15:15|t 40m",
		-- Thorns
        "|TInterface\\Icons\\Spell_Nature_Thorns:15:15|t 30m (lvl 6, 33m, 36m Nature's Reach)",
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
            BlizzFaderDB.ShamanFriendly = defaultBlizzFaderDB.ShamanFriendly -- Set the default index for the friendly spells
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
	"|TInterface\\Icons\\Spell_Nature_Regenerate:15:15|t 30m (lvl 12, Dead Player only)",
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
            BlizzFaderDB.MageFriendly = defaultBlizzFaderDB.MageFriendly -- Set the default index for the friendly spells
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
	"|TInterface\\Icons\\Spell_Holy_MagicalSentry:15:15|t 30m",
	-- Bandage
    "|TInterface\\Icons\\INV_Misc_Bandage_Netherweave_Heavy:15:15|t 15m",
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
            BlizzFaderDB.WarlockFriendly = defaultBlizzFaderDB.WarlockFriendly -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.WarlockFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.WarlockFriendly = value;
    end,
    values = {
    -- Unending Breath
    "|TInterface\\Icons\\Spell_Shadow_DemonBreath:15:15|t 30m (lvl 16)",
	-- Bandage
    "|TInterface\\Icons\\INV_Misc_Bandage_Netherweave_Heavy:15:15|t 15m",
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
            BlizzFaderDB.RogueFriendly = defaultBlizzFaderDB.RogueFriendly -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.RogueFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.RogueFriendly = value;
    end,
    values = {
    -- Bandage
    "|TInterface\\Icons\\INV_Misc_Bandage_Netherweave_Heavy:15:15|t 15m",
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
	
	
	PriestFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.PriestFriendly == nil then
            BlizzFaderDB.PriestFriendly = defaultBlizzFaderDB.PriestEnemy -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.PriestFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.PriestFriendly = value;
    end,
    values = {
    -- Lesser Heal
    "|TInterface\\Icons\\Spell_Holy_Renew:15:15|t 40m",
    -- Power Word: Fortitude
    "|TInterface\\Icons\\Spell_Holy_WordFortitude:15:15|t 30m",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "PRIEST"
    end,
    disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
    end,
    },
	
	
	HunterFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.HunterFriendly == nil then
            BlizzFaderDB.HunterFriendly = defaultBlizzFaderDB.HunterFriendly -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.HunterFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.HunterFriendly = value;
    end,
    values = {
    -- Misdirection
    "|TInterface\\Icons\\Ability_Hunter_Misdirection:15:15|t 100m (lvl 70 only)",
    -- Mend pet
    "|TInterface\\Icons\\Ability_Hunter_MendPet:15:15|t 45m (lvl 12, Pet only)",
     -- Bandage
    "|TInterface\\Icons\\INV_Misc_Bandage_Netherweave_Heavy:15:15|t 15m",
    -- Dismiss pet
    "|TInterface\\Icons\\Spell_Nature_SpiritWolf:15:15|t 10m (lvl 10, Pet only)",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "HUNTER"
    end,
    disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
    end,
    },
	
	
	PaladinFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.PaladinFriendly == nil then
            BlizzFaderDB.PaladinFriendly = defaultBlizzFaderDB.PaladinFriendly -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.PaladinFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.PaladinFriendly = value;
    end,
    values = {
    -- Holy Light
    "|TInterface\\Icons\\Spell_Holy_HolyBolt:15:15|t 40m",
    -- Blessing of Might
    "|TInterface\\Icons\\Spell_Holy_FistOfJustice:15:15|t 30m (lvl 4)",
    -- Holy Shock
    "|TInterface\\Icons\\Spell_Holy_SearingLight:15:15|t 20m (lvl 40)",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "PALADIN"
    end,
    disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
    end,
    },
	
	
	WarriorFriendly = {
    type = "select",
    name = "Friendly Spells",
    desc = "Set the range based on friendly spells",
    get = function()
		if BlizzFaderDB.WarriorFriendly == nil then
            BlizzFaderDB.WarriorFriendly = defaultBlizzFaderDB.WarriorFriendly -- Set the default index for the friendly spells
        end
        return BlizzFaderDB.WarriorFriendly
    end,
    set = function(info, value)
        BlizzFaderDB.WarriorFriendly = value;
    end,
    values = {
    -- Intervene
    "|TInterface\\Icons\\Ability_Warrior_VictoryRush:15:15|t 25m (lvl 70 only)",
	-- Battle and Commanding Shout
    "|TInterface\\Icons\\Ability_Warrior_BattleShout:15:15|t 20m",
    -- Bandage
    "|TInterface\\Icons\\INV_Misc_Bandage_Netherweave_Heavy:15:15|t 15m",
    },
    order = 1,
	width = "full",
    hidden = function()
        return select(2, UnitClass("player")) ~= "WARRIOR"
    end,
    disabled = function()
        return BlizzFaderDB.DisableFriendlySpells
    end,
    },
	
	SaveAndReload = {
    type = "execute",
    name = "Save & Reload",
    desc = "Save the settings and reload the UI, if you have some issue click on this button to reload the game",
    func = function()
        StaticPopupDialogs["CONFIRM_RELOADUI"] = {
            text = "Are you sure you want to reload the UI?",
            button1 = "Yes",
            button2 = "No",
            OnAccept = function()
                ReloadUI()
            end,
            OnCancel = function()
                -- Do nothing if the user cancels
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3, -- Ensure the dialog appears above other UI elements
        }

        StaticPopup_Show("CONFIRM_RELOADUI")
    end,
    order = 10,
		}
	  },
    },
  },
}

-- Function to register options
local function RegisterOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(ADDON_NAME, options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(ADDON_NAME, ADDON_NAME)
end

-- Set up slash commands
SLASH_BLIZZFADER1 = "/blizzfader"
SLASH_BLIZZFADER2 = "/bf"
SlashCmdList["BLIZZFADER"] = function()
    InterfaceOptionsFrame_OpenToFrame(ADDON_NAME)
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

local framesquare = {}	
				for i = 1, 5 do 
						framesquare[i] = CreateFrame("Frame", nil, TargetFrame)
						framesquare[i]:SetWidth(32)
						framesquare[i]:SetHeight(32)

						framesquare[i].bg = framesquare[i]:CreateTexture(nil, "ARTWORK")
						framesquare[i].border = framesquare[i]:CreateTexture(nil, "BORDER")

						framesquare[i].bg:SetAllPoints()
						framesquare[i].bg:SetTexture(1)

						framesquare[i].border:SetPoint("CENTER")
						framesquare[i].border:SetTexture(0, 0, 0, 1)
						framesquare[i].border:SetWidth(36)
						framesquare[i].border:SetHeight(36)
						framesquare[i]:SetPoint("LEFT", TargetFrame, "RIGHT")
						framesquare[i]:Hide()
						-- print("hide")
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
				local inMeleeRange = false
				local inDeadzone = false
                -- [DRUID]
                if BlizzFaderDB.DruidEnemy == 1 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Soothe Animal
                    -- Check if within melee range for Growl
                    if IsSpellInRange(GetSpellInfo(6795), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Soothe Animal
                    elseif IsSpellInRange(GetSpellInfo(2908), unit) == 0 then
                        inRange = false
                    end
               elseif BlizzFaderDB.DruidEnemy == 2 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Wrath
					-- Check if within melee range for Growl
                    if IsSpellInRange(GetSpellInfo(6795), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Wrath
                    elseif IsSpellInRange(GetSpellInfo(5176), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.DruidEnemy == 3 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Cyclone
                    -- Check if within melee range for Growl
                    if IsSpellInRange(GetSpellInfo(6795), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Cyclone
                    elseif IsSpellInRange(GetSpellInfo(33786), unit) == 0 then
                        inRange = false
                    end
				elseif BlizzFaderDB.DruidEnemy == 4 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Feral Charge
                    -- Check if within melee range for Growl
                    if IsSpellInRange(GetSpellInfo(6795), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Netherweave Net item
                    elseif IsItemInRange(24268, unit) == 0 then
                        inRange = false
                    end
					
				elseif BlizzFaderDB.DruidEnemy == 5 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Bash (Growl)
                    -- Check if within melee range for Growl
                    if IsSpellInRange(GetSpellInfo(6795), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Bash (Growl)
                    elseif IsSpellInRange(GetSpellInfo(6795), unit) == 0 then
                        inRange = false
                    end

                -- [SHAMAN]
                elseif BlizzFaderDB.ShamanEnemy == 1 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Lightning Bolt
					-- Check if within melee range for Voodoo Charm item or Stormstrike
					if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(32176), unit) == nil) or (IsSpellInRange(GetSpellInfo(32176), unit) == 1)  then
                        inMeleeRange = true
                    -- Check if out of range for Lightning Bolt
                    elseif IsSpellInRange(GetSpellInfo(403), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.ShamanEnemy == 2 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Purge
                    -- Check if within melee range for Voodoo Charm item or Stormstrike
                    if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(32176), unit) == nil) or (IsSpellInRange(GetSpellInfo(32176), unit) == 1)  then
                        inMeleeRange = true
                    -- Check if out of range for Purge
                    elseif IsSpellInRange(GetSpellInfo(370), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.ShamanEnemy == 3 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Earth Shock
                    -- Check if within melee range for Voodoo Charm item or Stormstrike
                    if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(32176), unit) == nil) or (IsSpellInRange(GetSpellInfo(32176), unit) == 1)  then
                       inMeleeRange = true
                    -- Check if out of range for Earth Shock
                    elseif IsSpellInRange(GetSpellInfo(8042), unit) == 0 then
                        inRange = false
                    end
				elseif BlizzFaderDB.ShamanEnemy == 4 and select(2, UnitClass("player")) == "SHAMAN" then 
                    -- Stormstrike
                    -- Check if within melee range for Voodoo Charm item or Stormstrike
                    if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(32176), unit) == nil) or (IsSpellInRange(GetSpellInfo(32176), unit) == 1)  then
                       inMeleeRange = true
                    -- Check if out of range for Stormstrike
                    elseif IsSpellInRange(GetSpellInfo(32176), unit) == 0 then
                        inRange = false
                    end
					
				
				-- [MAGE]
                elseif BlizzFaderDB.MageEnemy == 1 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Fireball 
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Fireball
                    elseif IsSpellInRange(GetSpellInfo(133), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.MageEnemy == 2 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Frost Bolt
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Frost bolt
                    elseif IsSpellInRange(GetSpellInfo(116), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.MageEnemy == 3 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Scorch
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Scorch
                    elseif IsSpellInRange(GetSpellInfo(2948), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.MageEnemy == 4 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Shoot
                   -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Shoot
                    elseif IsSpellInRange(GetSpellInfo(5019), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.MageEnemy == 5 and select(2, UnitClass("player")) == "MAGE" then 
                    -- Fire Blast
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Fire Blast
                    elseif IsSpellInRange(GetSpellInfo(2136), unit) == 0 then
                        inRange = false
                    end
				
				-- [WARLOCK]
                elseif BlizzFaderDB.WarlockEnemy == 1 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Immolate 
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Immolate
                    elseif IsSpellInRange(GetSpellInfo(348), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.WarlockEnemy == 2 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Corruption
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Corruption 
                    elseif IsSpellInRange(GetSpellInfo(172), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.WarlockEnemy == 3 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Shoot
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Shoot
                    elseif IsSpellInRange(GetSpellInfo(5019), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.WarlockEnemy == 4 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Fear
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Fear
                    elseif IsSpellInRange(GetSpellInfo(5782), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.WarlockEnemy == 5 and select(2, UnitClass("player")) == "WARLOCK" then 
                    -- Shadowburn 
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Shadowburn
                    elseif IsSpellInRange(GetSpellInfo(17877), unit) == 0 then
                        inRange = false
                    end
				
				
				-- [ROGUE]
                elseif BlizzFaderDB.RogueEnemy == 1 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Slice and Dice 
                     -- Check if within melee range for Eviscerate
                    if IsSpellInRange(GetSpellInfo(2098), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Slice and Dice
                    elseif IsSpellInRange(GetSpellInfo(5171), unit) == 0 then
                        inRange = false
                    end
                               
				elseif BlizzFaderDB.RogueEnemy == 2 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Throw
                    -- Check if within melee range for Eviscerate
                    if IsSpellInRange(GetSpellInfo(2098), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Throw
                    elseif IsSpellInRange(GetSpellInfo(2764), unit) == 0 then
                        inRange = false
					end
                
                elseif BlizzFaderDB.RogueEnemy == 3 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Shadow Step
                    -- Check if within melee range for Eviscerate
                    if IsSpellInRange(GetSpellInfo(2098), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Shadow Step
                    elseif IsSpellInRange(GetSpellInfo(36554), unit) == 0 then
                        inRange = false
                    end
				elseif BlizzFaderDB.RogueEnemy == 4 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Blind
                    -- Check if within melee range for Eviscerate
                    if IsSpellInRange(GetSpellInfo(2098), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Blind
                    elseif IsSpellInRange(GetSpellInfo(2094), unit) == 0 then
                        inRange = false
                    end
                    
                  elseif BlizzFaderDB.RogueEnemy == 5 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Sap
                    -- Check if within melee range for Eviscerate
                    if IsSpellInRange(GetSpellInfo(2098), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Sap
                    elseif IsSpellInRange(GetSpellInfo(6770), unit) == 0 then
                        inRange = false
                    end
                    
                elseif BlizzFaderDB.RogueEnemy == 6 and select(2, UnitClass("player")) == "ROGUE" then 
                    -- Eviscerate
                    -- Check if within melee range for Eviscerate
				if IsSpellInRange(GetSpellInfo(2098), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range 
                    elseif IsSpellInRange(GetSpellInfo(2098), unit) == 0 then
                        inRange = false
                    end
					
					
				-- [PRIEST]
                elseif BlizzFaderDB.PriestEnemy == 1 and select(2, UnitClass("player")) == "PRIEST" then 
                    -- Smite 
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Smite
                    elseif IsSpellInRange(GetSpellInfo(585), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.PriestEnemy == 2 and select(2, UnitClass("player")) == "PRIEST" then 
                    -- Shadow Word: Pain
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Shadow Word: Pain
                    elseif IsSpellInRange(GetSpellInfo(589), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.PriestEnemy == 3 and select(2, UnitClass("player")) == "PRIEST" then 
                    -- Shoot
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Shoot
                    elseif IsSpellInRange(GetSpellInfo(5019), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.PriestEnemy == 4 and select(2, UnitClass("player")) == "PRIEST" then 
                    -- Mind Flay
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Mind Flay
                    elseif IsSpellInRange(GetSpellInfo(15407), unit) == 0 then
                        inRange = false
                    end
                    elseif BlizzFaderDB.PriestEnemy == 5 and select(2, UnitClass("player")) == "PRIEST" then 
                    -- Mind Control
                    -- Check if within melee range for Voodoo Charm item
                    if IsItemInRange(8149, unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Mind Control
                    elseif IsSpellInRange(GetSpellInfo(605), unit) == 0 then
                        inRange = false
                    end
					
					
					-- [HUNTER]
                elseif BlizzFaderDB.HunterEnemy == 1 and select(2, UnitClass("player")) == "HUNTER" then 
                    -- Hunter's Mark
                    -- Check if within melee range for Wing clip
                    if IsSpellInRange(GetSpellInfo(2974), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Hunter's Mark
                    elseif IsSpellInRange(GetSpellInfo(1130), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.HunterEnemy == 2 and select(2, UnitClass("player")) == "HUNTER" then 
                    -- Kill Command
                    -- Check if within melee range for Wing clip
                    if IsSpellInRange(GetSpellInfo(2974), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Kill Command
                    elseif IsSpellInRange(GetSpellInfo(34026), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.HunterEnemy == 3 and select(2, UnitClass("player")) == "HUNTER" then 
                    -- Auto Shot
                    -- Check if within melee range for Wing clip
                    if IsSpellInRange(GetSpellInfo(2974), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Auto Shot
                    elseif IsSpellInRange(GetSpellInfo(75), unit) == 0 then
                        inRange = false
                    end
               elseif BlizzFaderDB.HunterEnemy == 4 and select(2, UnitClass("player")) == "HUNTER" then 
                    -- Throw
                    -- Check if within melee range for Wing clip
                    if IsSpellInRange(GetSpellInfo(2974), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Throw
                    elseif IsSpellInRange(GetSpellInfo(2764), unit) == 0 then
                        inRange = false
                    end                    
                elseif BlizzFaderDB.HunterEnemy == 5 and select(2, UnitClass("player")) == "HUNTER" then 
                    -- Scatter Shot
                    -- Check if within melee range for Wing clip
                    if IsSpellInRange(GetSpellInfo(2974), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Scatter Shot
                    elseif IsSpellInRange(GetSpellInfo(19503), unit) == 0 then
                        inRange = false
                    end                    
                 elseif BlizzFaderDB.HunterEnemy == 6 and select(2, UnitClass("player")) == "HUNTER" then 
                    -- Wing clip
                    -- Check if within melee range for Wing clip
                    if IsSpellInRange(GetSpellInfo(2974), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Scatter Shot
                    elseif IsSpellInRange(GetSpellInfo(2974), unit) == 0 then
                        inRange = false
                    end
				
				
				-- [PALADIN]
                elseif BlizzFaderDB.PaladinEnemy == 1 and select(2, UnitClass("player")) == "PALADIN" then 
                    -- Hammer of Wrath
                    -- Check if within melee range for Voodoo Charm item or Crusader Strike
					if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(35395), unit) == nil) or (IsSpellInRange(GetSpellInfo(35395), unit) == 1)  then
						inMeleeRange = true
                    -- Check if out of range for Hammer of Wrath
                    elseif IsSpellInRange(GetSpellInfo(24275), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.PaladinEnemy == 2 and select(2, UnitClass("player")) == "PALADIN" then 
                    -- Turn Undead
                    -- Check if within melee range for Voodoo Charm item or Crusader Strike
					if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(35395), unit) == nil) or (IsSpellInRange(GetSpellInfo(35395), unit) == 1)  then
						inMeleeRange = true
                    -- Check if out of range for Turn Undead
                    elseif IsSpellInRange(GetSpellInfo(2878), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.PaladinEnemy == 3 and select(2, UnitClass("player")) == "PALADIN" then 
                    -- Holy Shock
                     -- Check if within melee range for Voodoo Charm item or Crusader Strike
					if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(35395), unit) == nil) or (IsSpellInRange(GetSpellInfo(35395), unit) == 1)  then
						inMeleeRange = true
                    -- Check if out of range for Holy Shock
                    elseif IsSpellInRange(GetSpellInfo(20473), unit) == 0 then
                        inRange = false
                    end
				elseif BlizzFaderDB.PaladinEnemy == 4 and select(2, UnitClass("player")) == "PALADIN" then 
                    -- Repentance
                     -- Check if within melee range for Voodoo Charm item or Crusader Strike
					if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(35395), unit) == nil) or (IsSpellInRange(GetSpellInfo(35395), unit) == 1)  then
						inMeleeRange = true
                    -- Check if out of range for Repentance
                    elseif IsSpellInRange(GetSpellInfo(20066), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.PaladinEnemy == 5 and select(2, UnitClass("player")) == "PALADIN" then 
                    -- Judgement
                     -- Check if within melee range for Voodoo Charm item or Crusader Strike
					if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(35395), unit) == nil) or (IsSpellInRange(GetSpellInfo(35395), unit) == 1)  then
						inMeleeRange = true
                    -- Check if out of range for Judgement
                    elseif IsSpellInRange(GetSpellInfo(20271), unit) == 0 then
                        inRange = false
                    end
               elseif BlizzFaderDB.PaladinEnemy == 6 and select(2, UnitClass("player")) == "PALADIN" then 
                    -- Crusader Strike
                    -- Check if within melee range for Crusader Strike
                   if (IsItemInRange(8149, unit) == 1 and IsSpellInRange(GetSpellInfo(35395), unit) == nil) or (IsSpellInRange(GetSpellInfo(35395), unit) == 1)  then
						inMeleeRange = true
                    -- Check if out of range for Crusader Strike
                    elseif IsSpellInRange(GetSpellInfo(35395), unit) == 0 then
                        inRange = false
                    end
				
				
				-- [WARRIOR]
                elseif BlizzFaderDB.WarriorEnemy == 1 and select(2, UnitClass("player")) == "WARRIOR" then 
                    -- Shoot
                    -- Check if within melee range for Rend
                    if IsSpellInRange(GetSpellInfo(772), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Shoot
                    elseif IsSpellInRange(GetSpellInfo(3018), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.WarriorEnemy == 2 and select(2, UnitClass("player")) == "WARRIOR" then 
                    -- Charge
                   -- Check if within melee range for Rend
                    if IsSpellInRange(GetSpellInfo(772), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Netherweave Net item
                    elseif IsItemInRange(24268, unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.WarriorEnemy == 3 and select(2, UnitClass("player")) == "WARRIOR" then 
                    -- Intimidating Shout
                    -- Check if within melee range for Rend
                    if IsSpellInRange(GetSpellInfo(772), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Intimidating Shout
                    elseif IsSpellInRange(GetSpellInfo(5246), unit) == 0 then
                        inRange = false
                    end
                elseif BlizzFaderDB.WarriorEnemy == 4 and select(2, UnitClass("player")) == "WARRIOR" then 
                    -- Rend
					-- Check if within melee range for Rend
                    if IsSpellInRange(GetSpellInfo(772), unit) == 1 then
                        inMeleeRange = true
                    -- Check if out of range for Heroic Strike
                    elseif IsSpellInRange(GetSpellInfo(772), unit) == 0 then
                        inRange = false
                    end	
			    end
				
				-- Check if within deadzone range (5-8m)
				if IsItemInRange(32321, unit) == 1 then
						inDeadzone = true
                    end
				
                -- Fade out the frame if the player is out of range
                if not inRange and not BlizzFaderDB.DisableEnemySpells then
                    frame:SetAlpha(BlizzFaderDB.opacity)
					TargetFrameFlash:Hide();
					-- print("hide range")
						framesquare[i]:Hide()
						
                else
                    -- Fade in the frame if the player is in range
                    if frame:GetAlpha() < 0.91 then
                        frame:SetAlpha(1)
                    end
				
				-- Add a red border if in melee range
				if (inMeleeRange and BlizzFaderDB.enableRedBorder)  then

					local color = BlizzFaderDB.redBorderColor or { r = 1, g = 0, b = 0, a = 1 } -- Default red color
					
					TargetFrameFlash:SetVertexColor(color.r, color.g, color.b, color.a)
					TargetFrameFlash:Show();
				
					
				elseif inDeadzone and BlizzFaderDB.enableDeadzoneHighlight and not inMeleeRange then

				local color = BlizzFaderDB.yellowBorderColor or { r = 1, g = 1, b = 0, a = 1 } -- Default yellow color
					
					
					TargetFrameFlash:SetVertexColor(color.r, color.g, color.b, color.a)
					TargetFrameFlash:Show()
				
					

						
				
				else
					
							
					TargetFrameFlash:Hide();
				end
				
				if (inMeleeRange and BlizzFaderDB.enableSquare)  then	
					local color = BlizzFaderDB.redBorderColor or { r = 1, g = 0, b = 0, a = 1 } -- Default red color
							framesquare[i].bg:SetTexture(color.r, color.g, color.b, color.a)
							framesquare[i]:Show()
						-- print("show melee")
				elseif inDeadzone and BlizzFaderDB.enableSquare and not inMeleeRange then

						local color = BlizzFaderDB.yellowBorderColor or { r = 1, g = 1, b = 0, a = 1 } -- Default yellow color
							framesquare[i].bg:SetTexture(color.r, color.g, color.b, color.a)
							framesquare[i]:Show()
						-- print("show deadzone")
				elseif not BlizzFaderDB.enableSquare then
					framesquare[i]:Hide()
					else
					
							framesquare[i]:Hide()
						-- print("hide else")
				end
					
			end
			
		end
                

            -- Determine if the player is friend and in range
            if (UnitExists(unit) and not UnitIsDead(unit) and not UnitIsDeadOrGhost(unit) and not UnitIsGhost(unit) and UnitIsConnected(unit) and UnitIsFriend("player", unit)) then
                local inRange = true
                -- [DRUID]
                 if BlizzFaderDB.DruidFriendly == 1 and select(2, UnitClass("player")) == "DRUID" then 
                    -- Healing touch
					if IsSpellInRange(GetSpellInfo(5185), unit) == 0 then
                        inRange = false
					end
				elseif BlizzFaderDB.DruidFriendly == 2 and select(2, UnitClass("player")) == "DRUID" then
                    -- Thorns
                    if IsSpellInRange(GetSpellInfo(467), unit) == 0 then
                        inRange = false
					end
                elseif BlizzFaderDB.DruidFriendly == 3 and select(2, UnitClass("player")) == "DRUID" then
                    -- Mark of the Wild
					if IsSpellInRange(GetSpellInfo(1126), unit) == 0 then
                        inRange = false
					end


                -- [SHAMAN]
               elseif BlizzFaderDB.ShamanFriendly == 1 and select(2, UnitClass("player")) == "SHAMAN" then
                    -- Healing Wave
                    if IsSpellInRange(GetSpellInfo(331), unit) == 0 then
                        inRange = false
					end
               elseif BlizzFaderDB.ShamanFriendly == 2 and select(2, UnitClass("player")) == "SHAMAN" then
                    -- Ancestral Spirit
					if IsSpellInRange(GetSpellInfo(2008), unit) == 0 then
                        inRange = false
					end
					
					
				-- [MAGE]
               elseif BlizzFaderDB.MageFriendly == 1 and select(2, UnitClass("player")) == "MAGE" then
                    -- Arcane Brilliance
                    if IsSpellInRange(GetSpellInfo(23028), unit) == 0 then
                        inRange = false
					end
               elseif BlizzFaderDB.MageFriendly == 2 and select(2, UnitClass("player")) == "MAGE" then
                    -- Arcane Intellect
                    if IsSpellInRange(GetSpellInfo(1459), unit) == 0 then
                        inRange = false
					end
				elseif BlizzFaderDB.MageFriendly == 3 and select(2, UnitClass("player")) == "MAGE" then
                    -- Bandage
					if IsItemInRange(21991, unit) == 0 then
                        inRange = false
					end

				-- [WARLOCK]
               elseif BlizzFaderDB.WarlockFriendly == 1 and select(2, UnitClass("player")) == "WARLOCK" then
                    -- Unending Breath
					if IsSpellInRange(GetSpellInfo(5697), unit) == 0 then
                        inRange = false
					end
				elseif BlizzFaderDB.WarlockFriendly == 2 and select(2, UnitClass("player")) == "WARLOCK" then
                    -- Bandage
					if IsItemInRange(21991, unit) == 0 then
                        inRange = false
					end
				
				-- [ROGUE]
               elseif BlizzFaderDB.RogueFriendly == 1 and select(2, UnitClass("player")) == "ROGUE" then
                    -- Bandage
					if IsItemInRange(21991, unit) == 0 then
                        inRange = false
					end
					
					
				-- [PRIEST]
               elseif BlizzFaderDB.PriestFriendly == 1 and select(2, UnitClass("player")) == "PRIEST" then
                    -- Lesser Heal
                    if IsSpellInRange(GetSpellInfo(2050), unit) == 0 then
                        inRange = false
					           end
                elseif BlizzFaderDB.PriestFriendly == 2 and select(2, UnitClass("player")) == "PRIEST" then
                    -- Power Word: Fortitude
                    if IsSpellInRange(GetSpellInfo(1243), unit) == 0 then
                        inRange = false
					end	
						
					
				-- [HUNTER]
               elseif BlizzFaderDB.HunterFriendly == 1 and select(2, UnitClass("player")) == "HUNTER" then
                    -- Misdirection 
                    if IsSpellInRange(GetSpellInfo(34477), unit) == 0 then
                        inRange = false
					 end
               elseif BlizzFaderDB.HunterFriendly == 2 and select(2, UnitClass("player")) == "HUNTER" then
                    -- Mend pet
                    if IsSpellInRange(GetSpellInfo(136), unit) == 0 then
                        inRange = false
					end
               elseif BlizzFaderDB.HunterFriendly == 3 and select(2, UnitClass("player")) == "HUNTER" then
                    -- Bandage 
                    if IsItemInRange(21991, unit) == 0 then
                        inRange = false
					end
               elseif BlizzFaderDB.HunterFriendly == 4 and select(2, UnitClass("player")) == "HUNTER" then
                    -- Dismiss pet
                    if IsSpellInRange(GetSpellInfo(2641), unit) == 0 then
                        inRange = false
					end
				

				-- [PALADIN]
               elseif BlizzFaderDB.PaladinFriendly == 1 and select(2, UnitClass("player")) == "PALADIN" then
                    -- Holy Light 
                    if IsSpellInRange(GetSpellInfo(635), unit) == 0 then
                        inRange = false
					end
               elseif BlizzFaderDB.PaladinFriendly == 2 and select(2, UnitClass("player")) == "PALADIN" then
                    -- Blessing of Might
                    if IsSpellInRange(GetSpellInfo(19740), unit) == 0 then
                        inRange = false
					end
               elseif BlizzFaderDB.PaladinFriendly == 3 and select(2, UnitClass("player")) == "PALADIN" then
                    -- Holy Shock 
                    if IsSpellInRange(GetSpellInfo(20473), unit) == 0 then
                        inRange = false
					end
				
				
				-- [WARRIOR]
               elseif BlizzFaderDB.WarriorFriendly == 1 and select(2, UnitClass("player")) == "WARRIOR" then
                    -- Intervene
					-- Check if within melee range for Attuned Crystal Cores item
                    if IsItemInRange(34368, unit) == 1 then
                        inRange = true
                    elseif IsSpellInRange(GetSpellInfo(3411), unit) == 0 then
                        inRange = false
					end
				elseif BlizzFaderDB.WarriorFriendly == 2 and select(2, UnitClass("player")) == "WARRIOR" then
                    -- Battle and Commanding Shout
					if IsItemInRange(21519, unit) == 0 then
                        inRange = false
					end			   			    
               elseif BlizzFaderDB.WarriorFriendly == 3 and select(2, UnitClass("player")) == "WARRIOR" then
                    -- Bandage
					if IsItemInRange(21991, unit) == 0 then
                        inRange = false
					end			   			   
                end
			 
                -- Fade out the frame if the player is out of range
                if not inRange and not BlizzFaderDB.DisableFriendlySpells then
                    frame:SetAlpha(BlizzFaderDB.opacity)
                else
                    -- Fade in the frame if the player is in range
                    if frame:GetAlpha() < 0.91 then
                        frame:SetAlpha(1)
						
                    end
                end
            end
        end
    end
end

local squareFrame = {}



for i = 1, 5 do 
    squareFrame[i] = CreateFrame("Frame", nil, TargetFrame)
    squareFrame[i]:SetWidth(32)
    squareFrame[i]:SetHeight(32)

    squareFrame[i].bg = squareFrame[i]:CreateTexture(nil, "ARTWORK")
    squareFrame[i].border = squareFrame[i]:CreateTexture(nil, "BORDER")

    squareFrame[i].bg:SetAllPoints()
    squareFrame[i].bg:SetTexture(1)

    squareFrame[i].border:SetPoint("CENTER")
    squareFrame[i].border:SetTexture(0, 0, 0, 1)
    squareFrame[i].border:SetWidth(36)
    squareFrame[i].border:SetHeight(36)
    squareFrame[i]:SetPoint("LEFT", TargetFrame, "RIGHT")
    squareFrame[i]:Hide()
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
    --===== Check if BlizzFaderDB is empty, if yes then initialize deafults. =====--
    if event == "PLAYER_ENTERING_WORLD" then
        if not BlizzFaderDB.opacity then
            BlizzFaderDB = defaultBlizzFaderDB 
        end
		local queryitem = {8149, 24268, 34368, 21991, 21519, 32321};
	if (queryitem) and (queryitem ~= nil) and (queryitem ~= "") and (queryitem ~= 0) then
    for i, itemID in ipairs(queryitem) do
        local itemName = GetItemInfo(itemID)
        -- print(itemName)
        GameTooltip:SetHyperlink("item:"..itemID..":0:0:0:0:0:0:0");
    end
	
end
    end

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

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PARTY_MEMBERS_CHANGED")
f:RegisterEvent("PLAYER_TARGET_CHANGED")
f:SetScript("OnEvent", OnEvent)
f:SetScript("OnUpdate", OnUpdate)