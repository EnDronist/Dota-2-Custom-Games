if item_maelstrom_1 == nil then
_G.item_maelstrom_1 = class({}) end
require('items/item_maelstrom_1')
LinkLuaModifier("modifier_item_desolator_corruption", "orb_effects/modifier_item_desolator_corruption.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_item_skadi_corruption", "orb_effects/modifier_item_skadi_corruption.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_item_desolator_skadi_corruption", "orb_effects/modifier_item_desolator_skadi_corruption.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_item_desolator_corruption_for_desolator_skadi", "orb_effects/modifier_item_desolator_corruption_for_desolator_skadi.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_item_desolator_maelstrom_corruption", "orb_effects/modifier_item_desolator_maelstrom_corruption", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_item_skadi_maelstrom_corruption", "orb_effects/modifier_item_skadi_maelstrom_corruption.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_item_desolator_skadi_maelstrom_corruption", "orb_effects/modifier_item_desolator_skadi_maelstrom_corruption.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_item_desolator_corruption_for_desolator_skadi_maelstrom", "orb_effects/modifier_item_desolator_corruption_for_desolator_skadi_maelstrom.lua", LUA_MODIFIER_MOTION_NONE )
--Joint Cooperation (Используется только орб-эффектами, накладывающими дебаффы)
function modifier_item_desolator_corruption(keys)
	--keys.target:RemoveModifierByName("modifier_item_desolator_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi_maelstrom")
end
function modifier_item_skadi_corruption(keys)
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption")
	--keys.target:RemoveModifierByName("modifier_item_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi_maelstrom")
end
function modifier_item_desolator_maelstrom_corruption(keys)
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_corruption")
	--keys.target:RemoveModifierByName("modifier_item_desolator_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi_maelstrom")
end
function modifier_item_skadi_maelstrom_corruption(keys)
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_maelstrom_corruption")
	--keys.target:RemoveModifierByName("modifier_item_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi_maelstrom")
end
function modifier_item_desolator_skadi_corruption(keys) -- Нужно удалить все остальные дебаффы, касающиеся Desolator и Skadi, кроме дебаффа от их объединённого взаимодействия
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_corruption")
	--keys.target:RemoveModifierByName("modifier_item_desolator_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_corruption")
	--keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi_maelstrom")
end
function modifier_item_desolator_skadi_maelstrom_corruption(keys)
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_skadi_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_skadi_maelstrom_corruption")
	--keys.target:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_corruption")
	keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi")
	--keys.target:RemoveModifierByName("modifier_item_desolator_corruption_for_desolator_skadi_maelstrom")
end

--Remover (При удалении одного из предметов, дающих орб-эффект, нужно удалить все орбы, потому что thinker уже не будет работать)
--function modifier_item_orb_thinking_remover(keys)
--	keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
--	keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
--	keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
--	keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
--	keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
--	keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
--	keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
--end

--Corruption Stratification (Наложение дебаффов)
function modifier_item_desolator_orb(keys)
--[[Desolator]]		keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_desolator_corruption", {duration = _G.item_desolator_corruption_duration})
--[[Joint Cooperation]]	modifier_item_desolator_corruption(keys)
end
function modifier_item_skadi_orb(keys)
--[[Skadi]]			if keys.target.GetInvulnCount == nil then
						if keys.caster:IsRangedAttacker() then
							keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_skadi_corruption", {duration = _G.item_skadi_cold_duration_ranged})
						else
							keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_skadi_corruption", {duration = _G.item_skadi_cold_duration_melee})
						end
					end
--[[Joint Cooperation]]	modifier_item_skadi_corruption(keys)
end
function modifier_item_maelstrom_orb(keys)
--[[Maelstrom]]		_G.item_maelstrom_1:maelstrom(keys)
end
function modifier_item_desolator_skadi_orb(keys)
--[[Desolator]]		keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_desolator_corruption_for_desolator_skadi", {duration = _G.item_desolator_corruption_duration})
--[[Skadi]]			if keys.target.GetInvulnCount == nil then
						if keys.caster:IsRangedAttacker() then
							keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_desolator_skadi_corruption", {duration = _G.item_skadi_cold_duration_ranged})
						else
							keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_desolator_skadi_corruption", {duration = _G.item_skadi_cold_duration_melee})
						end
					end
--[[Joint Cooperation]]	modifier_item_desolator_skadi_corruption(keys)
end
function modifier_item_desolator_maelstrom_orb(keys)
--[[Desolator]]		keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_desolator_maelstrom_corruption", {duration = _G.item_desolator_corruption_duration})
--[[Maelstrom]]		_G.item_maelstrom_1:maelstrom(keys)
--[[Joint Cooperation]]	modifier_item_desolator_maelstrom_corruption(keys)
end
function modifier_item_skadi_maelstrom_orb(keys)
--[[Skadi]]			if keys.target.GetInvulnCount == nil then
						if keys.caster:IsRangedAttacker() then
							keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_skadi_maelstrom_corruption", {duration = _G.item_skadi_cold_duration_ranged})
						else
							keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_skadi_maelstrom_corruption", {duration = _G.item_skadi_cold_duration_melee})
						end
					end
--[[Maelstrom]]		_G.item_maelstrom_1:maelstrom(keys)
--[[Joint Cooperation]]	modifier_item_skadi_maelstrom_corruption(keys)
end
function modifier_item_desolator_skadi_maelstrom_orb(keys)
--[[Desolator]]		keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_desolator_corruption_for_desolator_skadi_maelstrom", {duration = _G.item_desolator_corruption_duration})
--[[Skadi]]			if keys.target.GetInvulnCount == nil then
						if keys.caster:IsRangedAttacker() then
							keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_desolator_skadi_maelstrom_corruption", {duration = _G.item_skadi_cold_duration_ranged})
						else
							keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_desolator_skadi_maelstrom_corruption", {duration = _G.item_skadi_cold_duration_melee})
						end
					end
--[[Maelstrom]]		_G.item_maelstrom_1:maelstrom(keys)
--[[Joint Cooperation]]	modifier_item_desolator_skadi_maelstrom_corruption(keys)
end