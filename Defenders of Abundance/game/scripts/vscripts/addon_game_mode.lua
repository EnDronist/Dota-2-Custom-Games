-- Generated from template
require("timers")
if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end
function Precache(context)
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end
-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
	ListenToGameEvent("game_init", Dynamic_Wrap(CAddonTemplateGameMode, 'ApplyGamemode'), CAddonTemplateGameMode)
	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(CAddonTemplateGameMode, 'Level6Message'), CAddonTemplateGameMode)
end
function OnCustomGamemodeChanged(eventSourceIndex,args)
	--print( "My event: ( ", eventSourceIndex, ", ", args['gamemode'], " )" )
	if args['gamemode'] == "1" then
		_G.custom_gamemode = 1
	elseif args['gamemode'] == "2" then
		_G.custom_gamemode = 2
	elseif args['gamemode'] == "3" then
		_G.custom_gamemode = 3
	end
	local event_data = {gamemode = _G.custom_gamemode}
	CustomGameEventManager:Send_ServerToAllClients("settings_change_other_players", event_data)
end
function CAddonTemplateGameMode:InitGameMode()
	print("Template addon is loaded.")
	_G.custom_gamemode = 1
	_G.gamemode_done = false
	_G.gamemode_described = false
	_G.heroes_done = false
	GameRules:SetRuneSpawnTime(120)
	GameRules:GetGameModeEntity():SetRuneEnabled(0,true) --Double Damage
	GameRules:GetGameModeEntity():SetRuneEnabled(1,true) --Haste
	GameRules:GetGameModeEntity():SetRuneEnabled(2,true) --Illusion
	GameRules:GetGameModeEntity():SetRuneEnabled(3,true) --Invis
	GameRules:GetGameModeEntity():SetRuneEnabled(4,true) --Regen
	GameRules:GetGameModeEntity():SetRuneEnabled(5,true) --Bounty
	GameRules:GetGameModeEntity():SetRuneEnabled(11,true) --Mystery
	--OnCustomGamemodeChanged(1, 1)
	GameRules:GetGameModeEntity():SetThink("OnThink",self,"GlobalThink",2)
	CustomGameEventManager:RegisterListener("custom_gamemode",OnCustomGamemodeChanged)
end
-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then
		if _G.gamemode_described == false then
			local str = ""
			local desc = ""
			if _G.custom_gamemode == 1 then 
				str = "NORMAL"
				desc = "Description: Normal match."
			elseif _G.custom_gamemode == 2 then
				GameRules:SetSameHeroSelectionEnabled(true)
				str = "1 VS 1"
				desc = "Description: Teams have couriers on start. Selecting the same heroes is activated."
			elseif _G.custom_gamemode == 3 then
				str = "TEST MATCH"
				desc = "Description: Heroes have more 50K gold on start."
			end			
			GameRules:SendCustomMessage("GAMEMODE: "..str,0,0)
			GameRules:SendCustomMessage(desc,0,0)
			--Say(nil, "GAMEMODE: " .. str, true)
			--Say(nil, desc, true)
			_G.gamemode_described = true
		end
	--elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then
	elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_STRATEGY_TIME then
		if _G.heroes_done == false then
			for i=0,9 do
				if PlayerResource:GetPlayer(i) ~= nil then
					if PlayerResource:GetSelectedHeroID(i) == -1 then
						PlayerResource:GetPlayer(i):MakeRandomHeroSelection()
					end
				end
			end
		end
		_G.heroes_done = true
	elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
		if _G.gamemode_done == false then
			CAddonTemplateGameMode:ApplyGamemode()
		end
	--elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
	--elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
	end
	return 1
end
function CAddonTemplateGameMode:ApplyGamemode(eventInfo)
	if _G.custom_gamemode == 1 then
		_G.gamemode_done = true
	elseif _G.custom_gamemode == 2 then
		Timers:CreateTimer(function()
			_G.gamemode_done = true
			local i = 1
			local player1 = PlayerResource:GetPlayer(0)
			if player1:GetAssignedHero() == nil then return 1 end
			local hero1 = player1:GetAssignedHero()
			if hero1:GetAbsOrigin() == nil then return 1 end
			local pos1 = hero1:GetAbsOrigin()
			if PlayerResource:GetPlayer(1) == nil then
				if i == 1 then
					Say(Gamemode, "Need 2 or more players", true)
					i = 0
				end
				return 1
			else
				local player2 = PlayerResource:GetPlayer(1)
				local i = 1
				while player2:GetTeamNumber() == player1:GetTeamNumber() and i < 10 do
					i = i + 1
					player2 = PlayerResource:GetPlayer(i)
				end
				if player2:GetAssignedHero() == nil then return 1 end
				local hero2 = player2:GetAssignedHero()
				if hero2:GetAbsOrigin() == nil then return 1 end
				local pos2 = hero2:GetAbsOrigin()
				local courier1 = CreateUnitByName("npc_dota_courier", pos1, true, player1, player1:GetOwner(), player1:GetTeamNumber())
				local courier2 = CreateUnitByName("npc_dota_courier", pos2, true, player2, player2:GetOwner(), player2:GetTeamNumber())
				courier1:SetControllableByPlayer(0, true)
				courier2:SetControllableByPlayer(1, true)
			end
		end)
	elseif _G.custom_gamemode == 3 then
		Timers:CreateTimer(0.1,function()
			local else_players = false
			for i=0,9 do
				local players = PlayerResource:GetPlayer(i)
				if players ~= nil then
					else_players = true
					if players:GetAssignedHero() ~= nil then
						local heroes = players:GetAssignedHero()
						heroes:SetGold(heroes:GetGold() + 50000, false)
						else_players = false
					end
				end
			end
			if else_players == true then return 1 end
			return nil
		end)
		_G.gamemode_done = true
	else
		_G.gamemode_done = true
	end
end
function CAddonTemplateGameMode:Level6Message(eventInfo)
	--for k,v in pairs(eventInfo) do
	--	print(eventInfo[k])
	--	print(k)
	--end
    --if eventInfo.level == 6 then
	--	Say(nil, "Someone just reached level 6", false)
    --end
end