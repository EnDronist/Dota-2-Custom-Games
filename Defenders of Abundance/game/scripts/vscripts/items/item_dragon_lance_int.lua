function modifier_item_dragon_lance_int_on_destroy(keys)
	keys.caster:RemoveModifierByName("modifier_item_dragon_lance_int_attack_range")
end
function modifier_item_dragon_lance_int_on_interval_think(keys)
	if not keys.caster:IsRangedAttacker() then
		if keys.caster:HasModifier("modifier_item_dragon_lance_int_attack_range") then
			keys.caster:RemoveModifierByName("modifier_item_dragon_lance_int_attack_range")
		end
	end
	local block_item = false
	local block_this_item = 2
	for i=0, 5, 1 do
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dragon_lance_1" then block_item = true end
			if current_item:GetName() == "item_dragon_lance_str" then block_item = true end
			if current_item:GetName() == "item_dragon_lance_agi" then block_item = true end
			if current_item:GetName() == "item_dragon_lance_int" then 
				block_this_item = block_this_item - 1
				if block_this_item == 0 then block_item = true end
			end
			if current_item:GetName() == "item_hurricane_pike" then block_item = true end
		end
	end
	if block_item == false and keys.caster:IsRangedAttacker() then
		if not keys.caster:HasModifier("modifier_item_dragon_lance_int_attack_range") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_dragon_lance_int_attack_range", {duration = -1})
		end
	else
		if keys.caster:HasModifier("modifier_item_dragon_lance_int_attack_range") then keys.caster:RemoveModifierByName("modifier_item_dragon_lance_int_attack_range") end
	end
end