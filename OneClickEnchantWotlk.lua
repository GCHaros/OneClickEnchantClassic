--[[
	OneClickEnchantWotlk
	Copyright (c) 2020, All rights reserved.
	
	Maintained by:
		H3adcracker#21987
		
		
	You may use this AddOn free of monetary charge and modify this AddOn for personal use.
	
	THIS ADDON IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
]]

local scrollText = "Scroll"; -- default english button text
local enchantingTradeSkillNames = {
    [GetSpellInfo(7411)] = true, -- Apprentice
    [GetSpellInfo(7412)] = true, -- Journeyman
    [GetSpellInfo(7413)] = true, -- Expert
	[GetSpellInfo(13920)] = true, -- Artisan
	[GetSpellInfo(28029)] = true, -- Master
	[GetSpellInfo(51313)] = true, -- Grand Master
}
local loc = GetLocale();
if loc == "deDE" then
	scrollText = "Rolle";
elseif loc == "frFR" then
	scrollText = "Parchemin";
elseif loc == "itIT" then
	scrollText = "Pergamene";
elseif (loc == "esES") or (loc == "esMX") then
	scrollText = "Pergamino";
elseif (loc == "ptBR") or (loc == "ptPT") then
	scrollText = "Pergaminho";
elseif loc == "ruRU" then
	scrollText = "Свиток";
elseif loc == "koKR" then
	scrollText = "두루마리";
elseif loc == "zhCN" then
	scrollText = "卷轴";
elseif loc == "zhTW" then
	scrollText = "卷軸";
end

local mapSpellToItem = {
    [7745] = 38772, -- Enchant 2H Weapon - Minor Impact
    [7786] = 38779, -- Enchant Weapon - Minor Beastslayer
    [7788] = 38780, -- Enchant Weapon - Minor Striking
    [7793] = 38781, -- Enchant 2H Weapon - Lesser Intellect
    [13380] = 38788, -- Enchant 2H Weapon - Lesser Versatility
    [13503] = 38794, -- Enchant Weapon - Lesser Striking
    [13529] = 38796, -- Enchant 2H Weapon - Lesser Impact
    [13653] = 38813, -- Enchant Weapon - Lesser Beastslayer
    [13655] = 38814, -- Enchant Weapon - Lesser Elemental Slayer
    [13693] = 38821, -- Enchant Weapon - Striking
    [13695] = 38822, -- Enchant 2H Weapon - Impact
    [13898] = 38838, -- Enchant Weapon - Fiery Weapon
    [13915] = 38840, -- Enchant Weapon - Demonslaying
    [13937] = 38845, -- Enchant 2H Weapon - Greater Impact
    [13943] = 38848, -- Enchant Weapon - Greater Striking
    [20029] = 38868, -- Enchant Weapon - Icy Chill
    [20030] = 38869, -- Enchant 2H Weapon - Superior Impact
    [20031] = 38870, -- Enchant Weapon - Superior Striking
    [20032] = 38871, -- Enchant Weapon - Lifestealing
    [20033] = 38872, -- Enchant Weapon - Unholy Weapon
    [20034] = 38873, -- Enchant Weapon - Crusader
    [20035] = 38874, -- Enchant 2H Weapon - Major Versatility
    [20036] = 38875, -- Enchant 2H Weapon - Major Intellect
    [21931] = 38876, -- Enchant Weapon - Winter's Might
    [22749] = 38877, -- Enchant Weapon - Spellpower
    [22750] = 38878, -- Enchant Weapon - Healing Power
    [23799] = 38879, -- Enchant Weapon - Strength
    [23800] = 38880, -- Enchant Weapon - Agility
    [23803] = 38883, -- Enchant Weapon - Mighty Versatility
    [23804] = 38884, -- Enchant Weapon - Mighty Intellect
    [27837] = 38896, -- Enchant 2H Weapon - Agility
    [64441] = 46026, -- Enchant Weapon - Blade Ward
    [64579] = 46098, -- Enchant Weapon - Blood Draining
    [7418] = 38679, -- Enchant Bracer - Minor Health
    [7420] = 38766, -- Enchant Chest - Minor Health
    [7426] = 38767, -- Enchant Chest - Minor Absorption
    [7428] = 38768, -- Enchant Bracer - Minor Dodge
    [7443] = 38769, -- Enchant Chest - Minor Mana
    [7457] = 38771, -- Enchant Bracer - Minor Stamina
    [7748] = 38773, -- Enchant Chest - Lesser Health
    [7766] = 38774, -- Enchant Bracer - Minor Versatility
    [7771] = 38775, -- Enchant Cloak - Minor Protection
    [7776] = 38776, -- Enchant Chest - Lesser Mana
    [7779] = 38777, -- Enchant Bracer - Minor Agility
    [7782] = 38778, -- Enchant Bracer - Minor Strength
    [7857] = 38782, -- Enchant Chest - Health
    [7859] = 38783, -- Enchant Bracer - Lesser Versatility
    [7863] = 38785, -- Enchant Boots - Minor Stamina
    [7867] = 38786, -- Enchant Boots - Minor Agility
    [13378] = 38787, -- Enchant Shield - Minor Stamina
    [13419] = 38789, -- Enchant Cloak - Minor Agility
    [13421] = 38790, -- Enchant Cloak - Lesser Protection
    [13464] = 38791, -- Enchant Shield - Lesser Protection
    [13485] = 38792, -- Enchant Shield - Lesser Versatility
    [13501] = 38793, -- Enchant Bracer - Lesser Stamina
    [13536] = 38797, -- Enchant Bracer - Lesser Strength
    [13538] = 38798, -- Enchant Chest - Lesser Absorption
    [13607] = 38799, -- Enchant Chest - Mana
    [13612] = 38800, -- Enchant Gloves - Mining
    [13617] = 38801, -- Enchant Gloves - Herbalism
    [13620] = 38802, -- Enchant Gloves - Fishing
    [13622] = 38803, -- Enchant Bracer - Lesser Intellect
    [13626] = 38804, -- Enchant Chest - Minor Stats
    [13631] = 38805, -- Enchant Shield - Lesser Stamina
    [13635] = 38806, -- Enchant Cloak - Defense
    [13637] = 38807, -- Enchant Boots - Lesser Agility
    [13640] = 38808, -- Enchant Chest - Greater Health
    [13642] = 38809, -- Enchant Bracer - Versatility
    [13644] = 38810, -- Enchant Boots - Lesser Stamina
    [13646] = 38811, -- Enchant Bracer - Lesser Dodge
    [13648] = 38812, -- Enchant Bracer - Stamina
    [13659] = 38816, -- Enchant Shield - Versatility
    [13661] = 38817, -- Enchant Bracer - Strength
    [13663] = 38818, -- Enchant Chest - Greater Mana
    [13687] = 38819, -- Enchant Boots - Lesser Versatility
    [13689] = 38820, -- Enchant Shield - Lesser Parry
    [13698] = 38823, -- Enchant Gloves - Skinning
    [13700] = 38824, -- Enchant Chest - Lesser Stats
    [13746] = 38825, -- Enchant Cloak - Greater Defense
    [13815] = 38827, -- Enchant Gloves - Agility
    [13817] = 38828, -- Enchant Shield - Stamina
    [13822] = 38829, -- Enchant Bracer - Intellect
    [13836] = 38830, -- Enchant Boots - Stamina
    [13841] = 38831, -- Enchant Gloves - Advanced Mining
    [13846] = 38832, -- Enchant Bracer - Greater Versatility
    [13858] = 38833, -- Enchant Chest - Superior Health
    [13868] = 38834, -- Enchant Gloves - Advanced Herbalism
    [13882] = 38835, -- Enchant Cloak - Lesser Agility
    [13887] = 38836, -- Enchant Gloves - Strength
    [13890] = 38837, -- Enchant Boots - Minor Speed
    [13905] = 38839, -- Enchant Shield - Greater Versatility
    [13917] = 38841, -- Enchant Chest - Superior Mana
    [13931] = 38842, -- Enchant Bracer - Dodge
    [13935] = 38844, -- Enchant Boots - Agility
    [13939] = 38846, -- Enchant Bracer - Greater Strength
    [13941] = 38847, -- Enchant Chest - Stats
    [13945] = 38849, -- Enchant Bracer - Greater Stamina
    [13947] = 38850, -- Enchant Gloves - Riding Skill
    [13948] = 38851, -- Enchant Gloves - Minor Haste
    [20008] = 38852, -- Enchant Bracer - Greater Intellect
    [20009] = 38853, -- Enchant Bracer - Superior Versatility
    [20010] = 38854, -- Enchant Bracer - Superior Strength
    [20011] = 38855, -- Enchant Bracer - Superior Stamina
    [20012] = 38856, -- Enchant Gloves - Greater Agility
    [20013] = 38857, -- Enchant Gloves - Greater Strength
    [20015] = 38859, -- Enchant Cloak - Superior Defense
    [20016] = 38860, -- Enchant Shield - Vitality
    [20017] = 38861, -- Enchant Shield - Greater Stamina
    [20020] = 38862, -- Enchant Boots - Greater Stamina
    [20023] = 38863, -- Enchant Boots - Greater Agility
    [20024] = 38864, -- Enchant Boots - Versatility
    [20025] = 38865, -- Enchant Chest - Greater Stats
    [20026] = 38866, -- Enchant Chest - Major Health
    [20028] = 38867, -- Enchant Chest - Major Mana
    [23801] = 38881, -- Enchant Bracer - Argent Versatility
    [23802] = 38882, -- Enchant Bracer - Healing Power
    [25072] = 38885, -- Enchant Gloves - Threat
    [25073] = 38886, -- Enchant Gloves - Shadow Power
    [25074] = 38887, -- Enchant Gloves - Frost Power
    [25078] = 38888, -- Enchant Gloves - Fire Power
    [25079] = 38889, -- Enchant Gloves - Healing Power
    [25080] = 38890, -- Enchant Gloves - Superior Agility
    [25083] = 38893, -- Enchant Cloak - Stealth
    [25084] = 38894, -- Enchant Cloak - Subtlety
    [44506] = 38960, -- Enchant Gloves - Gatherer
    [63746] = 45628, -- Enchant Boots - Lesser Accuracy
    [71692] = 50816, -- Enchant Gloves - Angler
    [27967] = 38917, -- Enchant Weapon - Major Striking
    [27968] = 38918, -- Enchant Weapon - Major Intellect
    [27971] = 38919, -- Enchant 2H Weapon - Savagery
    [27972] = 38920, -- Enchant Weapon - Potency
    [27975] = 38921, -- Enchant Weapon - Major Spellpower
    [27977] = 38922, -- Enchant 2H Weapon - Major Agility
    [27981] = 38923, -- Enchant Weapon - Sunfire
    [27982] = 38924, -- Enchant Weapon - Soulfrost
    [27984] = 38925, -- Enchant Weapon - Mongoose
    [28003] = 38926, -- Enchant Weapon - Spellsurge
    [28004] = 38927, -- Enchant Weapon - Battlemaster
    [34010] = 38946, -- Enchant Weapon - Major Healing
    [42620] = 38947, -- Enchant Weapon - Greater Agility
    [27951] = 37603, -- Enchant Boots - Dexterity
    [25086] = 38895, -- Enchant Cloak - Dodge
    [27899] = 38897, -- Enchant Bracer - Brawn
    [27905] = 38898, -- Enchant Bracer - Stats
    [27906] = 38899, -- Enchant Bracer - Greater Dodge
    [27911] = 38900, -- Enchant Bracer - Superior Healing
    [27913] = 38901, -- Enchant Bracer - Versatility Prime
    [27914] = 38902, -- Enchant Bracer - Fortitude
    [27917] = 38903, -- Enchant Bracer - Spellpower
    [27944] = 38904, -- Enchant Shield - Lesser Dodge
    [27945] = 38905, -- Enchant Shield - Intellect
    [27946] = 38906, -- Enchant Shield - Parry
    [27948] = 38908, -- Enchant Boots - Vitality
    [27950] = 38909, -- Enchant Boots - Fortitude
    [27954] = 38910, -- Enchant Boots - Surefooted
    [27957] = 38911, -- Enchant Chest - Exceptional Health
    [27960] = 38913, -- Enchant Chest - Exceptional Stats
    [27961] = 38914, -- Enchant Cloak - Major Armor
    [33990] = 38928, -- Enchant Chest - Major Versatility
    [33991] = 38929, -- Enchant Chest - Versatility Prime
    [33992] = 38930, -- Enchant Chest - Major Resilience
    [33993] = 38931, -- Enchant Gloves - Blasting
    [33994] = 38932, -- Enchant Gloves - Precise Strikes
    [33995] = 38933, -- Enchant Gloves - Major Strength
    [33996] = 38934, -- Enchant Gloves - Assault
    [33997] = 38935, -- Enchant Gloves - Major Spellpower
    [33999] = 38936, -- Enchant Gloves - Major Healing
    [34001] = 38937, -- Enchant Bracer - Major Intellect
    [34002] = 38938, -- Enchant Bracer - Lesser Assault
    [34003] = 38939, -- Enchant Cloak - PvP Power
    [34004] = 38940, -- Enchant Cloak - Greater Agility
    [34007] = 38943, -- Enchant Boots - Cat's Swiftness
    [34008] = 38944, -- Enchant Boots - Boar's Speed
    [34009] = 38945, -- Enchant Shield - Major Stamina
    [44383] = 38949, -- Enchant Shield - Resilience
    [46594] = 38999, -- Enchant Chest - Dodge
    [47051] = 39000, -- Enchant Cloak - Greater Dodge
    [42974] = 38948, -- Enchant Weapon - Executioner
    [44510] = 38963, -- Enchant Weapon - Exceptional Versatility
    [44524] = 38965, -- Enchant Weapon - Icebreaker
    [44576] = 38972, -- Enchant Weapon - Lifeward
    [44595] = 38981, -- Enchant 2H Weapon - Scourgebane
    [44621] = 38988, -- Enchant Weapon - Giant Slayer
    [44629] = 38991, -- Enchant Weapon - Exceptional Spellpower
    [44630] = 38992, -- Enchant 2H Weapon - Greater Savagery
    [44633] = 38995, -- Enchant Weapon - Exceptional Agility
    [46578] = 38998, -- Enchant Weapon - Deathfrost
    [59625] = 43987, -- Enchant Weapon - Black Magic
    [60621] = 44453, -- Enchant Weapon - Greater Potency
    [60691] = 44463, -- Enchant 2H Weapon - Massacre
    [60707] = 44466, -- Enchant Weapon - Superior Potency
    [60714] = 44467, -- Enchant Weapon - Mighty Spellpower
    [59621] = 44493, -- Enchant Weapon - Berserking
    [59619] = 44497, -- Enchant Weapon - Accuracy
    [62948] = 45056, -- Enchant Staff - Greater Spellpower
    [62959] = 45060, -- Enchant Staff - Spellpower
    [27958] = 38912, -- Enchant Chest - Exceptional Mana
    [44484] = 38951, -- Enchant Gloves - Haste
    [44488] = 38953, -- Enchant Gloves - Precision
    [44489] = 38954, -- Enchant Shield - Dodge
    [44492] = 38955, -- Enchant Chest - Mighty Health
    [44500] = 38959, -- Enchant Cloak - Superior Agility
    [44508] = 38961, -- Enchant Boots - Greater Versatility
    [44509] = 38962, -- Enchant Chest - Greater Versatility
    [44513] = 38964, -- Enchant Gloves - Greater Assault
    [44528] = 38966, -- Enchant Boots - Greater Fortitude
    [44529] = 38967, -- Enchant Gloves - Major Agility
    [44555] = 38968, -- Enchant Bracer - Exceptional Intellect
    [60616] = 38971, -- Enchant Bracer - Assault
    [44582] = 38973, -- Enchant Cloak - Minor Power
    [44584] = 38974, -- Enchant Boots - Greater Vitality
    [44588] = 38975, -- Enchant Chest - Exceptional Resilience
    [44589] = 38976, -- Enchant Boots - Superior Agility
    [44591] = 38978, -- Enchant Cloak - Superior Dodge
    [44592] = 38979, -- Enchant Gloves - Exceptional Spellpower
    [44593] = 38980, -- Enchant Bracer - Major Versatility
    [44598] = 38984, -- Enchant Bracer - Haste
    [60623] = 38986, -- Enchant Boots - Icewalker
    [44616] = 38987, -- Enchant Bracer - Greater Stats
    [44623] = 38989, -- Enchant Chest - Super Stats
    [44625] = 38990, -- Enchant Gloves - Armsman
    [44631] = 38993, -- Enchant Cloak - Shadow Armor
    [44635] = 38997, -- Enchant Bracer - Greater Spellpower
    [47672] = 39001, -- Enchant Cloak - Mighty Stamina
    [47766] = 39002, -- Enchant Chest - Greater Dodge
    [47898] = 39003, -- Enchant Cloak - Greater Speed
    [47899] = 39004, -- Enchant Cloak - Wisdom
    [47900] = 39005, -- Enchant Chest - Super Health
    [47901] = 39006, -- Enchant Boots - Tuskarr's Vitality
    [60606] = 44449, -- Enchant Boots - Assault
    [60653] = 44455, -- Shield Enchant - Greater Intellect
    [60609] = 44456, -- Enchant Cloak - Speed
    [60663] = 44457, -- Enchant Cloak - Major Agility
    [60668] = 44458, -- Enchant Gloves - Crusher
    [60692] = 44465, -- Enchant Chest - Powerful Stats
    [60763] = 44469, -- Enchant Boots - Greater Assault
    [60767] = 44470, -- Enchant Bracer - Superior Spellpower
    [44575] = 44815, -- Enchant Bracer - Greater Assault
    [62256] = 44947, -- Enchant Bracer - Major Stamina



}

local f = CreateFrame("Button", "TradeSkillCreateScrollButton", TradeSkillFrame, "MagicButtonTemplate");
f:SetPoint("TOPRIGHT", TradeSkillFrame.DetailsFrame.CreateButton, "TOPLEFT");
if IsAddOnLoaded("ElvUI") and ElvUI then
	ElvUI[1]:GetModule('Skins'):HandleButton(f);
	f:ClearAllPoints();
	f:SetPoint("TOPRIGHT", TradeSkillFrame.DetailsFrame.CreateButton, "TOPLEFT", -1, 0);
end
f:SetScript("OnClick", function()
    if (IsShiftKeyDown() and f.itemID) then
        local activeEditBox = ChatEdit_GetActiveWindow();
        if activeEditBox then
            local _,link = GetItemInfo(f.itemID);
            ChatEdit_InsertLink(link);
        end;
    else
        C_TradeSkillUI.CraftRecipe(TradeSkillFrame.DetailsFrame.selectedRecipeID);
        UseItemByName(38682);
    end;
end);
f:SetScript("OnEnter", function()
    if f.itemID then
        GameTooltip:SetOwner(f);
        GameTooltip:SetItemByID(f.itemID);
    end;
end);
f:SetScript("OnLeave", function()
    GameTooltip:Hide();
end);

f:SetMotionScriptsWhileDisabled(true);
f:Hide();

local function OCE_RefreshButtons(self)
	if C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() or C_TradeSkillUI.IsTradeSkillLinked() then
		f:Hide();
	else
        local recipeInfo = self.selectedRecipeID and C_TradeSkillUI.GetRecipeInfo(self.selectedRecipeID);
        if recipeInfo and recipeInfo.alternateVerb then
            local tradeSkillName = select(2, C_TradeSkillUI.GetTradeSkillLine());
            if enchantingTradeSkillNames[tradeSkillName] then
                f.itemID = mapSpellToItem[recipeInfo.recipeID];
                if (not f.itemID) then
                    print(string.format("OneClickEnchantWotlk: Missing scroll item for spellID %d. Please report this at Curseforge.", recipeInfo.recipeID));
                end;
                f:Show();
                local numCreateable = recipeInfo.numAvailable;
                local numScrollsAvailable = GetItemCount(38682);
                TradeSkillCreateScrollButton:SetText(string.format("%s (%d)", scrollText, numScrollsAvailable));
                if numScrollsAvailable == 0 then
                    numCreateable = 0;
                end
                if numCreateable > 0 then
                    TradeSkillCreateScrollButton:Enable();
                else
                    TradeSkillCreateScrollButton:Disable();
                end
            else
                f:Hide();
            end
        else
            f:Hide();
        end
    end
end

hooksecurefunc(TradeSkillFrame.DetailsFrame, "RefreshButtons", OCE_RefreshButtons);
