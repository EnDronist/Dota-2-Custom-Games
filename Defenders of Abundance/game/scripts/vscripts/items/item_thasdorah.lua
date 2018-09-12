LinkLuaModifier("modifier_item_thasdorah_attack_range", "modifiers/modifier_item_thasdorah_attack_range", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_thasdorah_speed", "modifiers/modifier_item_thasdorah_speed", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_thasdorah_aura", "modifiers/modifier_item_thasdorah_aura", LUA_MODIFIER_MOTION_NONE)
function modifier_item_thasdorah_on_destroy(keys)
	keys.target:RemoveModifierByName("modifier_item_thasdorah_attack_range")
	keys.target:RemoveModifierByName("modifier_item_thasdorah_speed")
	keys.target:RemoveModifierByName("modifier_item_thasdorah_speed_aura")
	keys.target:RemoveModifierByName("modifier_item_thasdorah_speed_buff")
	keys.target:RemoveModifierByName("modifier_item_thasdorah_aura")
	keys.target:RemoveModifierByName("modifier_item_thasdorah_aura_aura")
end
function modifier_item_thasdorah_on_interval_think(keys)
	if not keys.caster:IsRangedAttacker() then
		if keys.caster:HasModifier("modifier_item_thasdorah_attack_range") then
			keys.caster:RemoveModifierByName("modifier_item_thasdorah_attack_range")
		end
	else
		if not keys.caster:HasModifier("modifier_item_thasdorah_attack_range") then
			keys.caster:AddNewModifier(keys.caster, keys.ability, "modifier_item_thasdorah_attack_range", {duration = -1})
		end
	end

	if not keys.target:HasModifier("modifier_item_thasdorah_speed") then
		keys.caster:AddNewModifier(keys.caster, keys.ability, "modifier_item_thasdorah_speed", {duration = -1})
	end

	if keys.target:HasModifier("modifier_item_ring_of_basilius_aura_bonus") or keys.target:HasModifier("modifier_item_ring_of_aquila_aura_bonus") or keys.target:HasModifier("modifier_item_vladmir_aura") then
		if keys.target:HasModifier("modifier_item_thasdorah_aura") then
			keys.target:RemoveModifierByName("modifier_item_thasdorah_aura")
		end
	elseif not keys.target:HasModifier("modifier_item_thasdorah_aura") then
		if not keys.target:HasModifier("modifier_item_thasdorah_aura") then
			keys.target:AddNewModifier(keys.caster, keys.ability, "modifier_item_thasdorah_aura", {duration = -1})
		end
	end
end