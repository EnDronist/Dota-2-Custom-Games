function modifier_item_orb(keys)
_G.item_desolator_corruption_duration = keys.ability:GetSpecialValueFor("desolator_corruption_duration")
--if --[[not keys.caster:HasModifier("modifier_item_desolator_thinker") or]] not keys.caster:HasModifier("modifier_item_skadi_thinker") or not keys.caster:HasModifier("modifier_item_maelstrom_thinker") then
	local desolator = 0
	local skadi = 0
	local maelstrom = 0
	--if keys.caster:HasModifier("modifier_item_desolator_thinker") end
	--if keys.caster:HasModifier("modifier_item_skadi_thinker") end
	for i=0, 5, 1 do 
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_desolator_1" then desolator = 1 end
			if current_item:GetName() == "item_skadi_1" then skadi = 1 end
			if current_item:GetName() == "item_maelstrom_1" then maelstrom = 1 end
		end
	end
		--if --[[desolator == 0 and]] skadi == 0 and maelstrom == 1 then
		--	if not keys.caster:HasModifier("modifier_item_maelstrom_orb") then
		--	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_maelstrom_orb", nil)
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
		--		--keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
		--  	keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
		--	end
		--end
		--if --[[desolator == 0 and]] skadi == 1 and maelstrom == 0 then
		--	if not keys.caster:HasModifier("modifier_item_skadi_orb") then
		--	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_skadi_orb", nil)
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
		--		--keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
		--  	keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
		--	end
		--end
		--if --[[desolator == 0 and]] skadi == 1 and maelstrom == 1 then
		--	if not keys.caster:HasModifier("modifier_item_skadi_maelstrom_orb") then
		--	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_skadi_maelstrom_orb", nil)
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
		-- 	 --keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
		--	end
		--end
		if --[[desolator == 1 and]] skadi == 0 and maelstrom == 0 then
			if not keys.caster:HasModifier("modifier_item_desolator_orb") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_desolator_orb", nil)
				--keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
			end
		end
		if --[[desolator == 1 and]] skadi == 0 and maelstrom == 1 then
			if not keys.caster:HasModifier("modifier_item_desolator_maelstrom_orb") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_desolator_maelstrom_orb", nil)
				keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
				--keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
			end
		end
		if --[[desolator == 1 and]] skadi == 1 and maelstrom == 0 then
			if not keys.caster:HasModifier("modifier_item_desolator_skadi_orb") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_desolator_skadi_orb", nil)
				keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
				--keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
			end
		end
		if --[[desolator == 1 and]] skadi == 1 and maelstrom == 1 then
			if not keys.caster:HasModifier("modifier_item_desolator_skadi_maelstrom_orb") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_desolator_skadi_maelstrom_orb", nil)
				keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
				--keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
			end
		end
--end
end
--If item loses
function modifier_item_desolator_lose(keys)
	local tick = 0.03
	Timers:CreateTimer(tick, function()
		local a = 0
		for i=0, 5, 1 do
			local current_item = keys.caster:GetItemInSlot(i)

			if current_item ~= nil then
				if current_item:GetName() == "item_desolator_1" then a = 1 end
			end
		end
		if a == 0 then
			keys.caster:RemoveModifierByName("modifier_item_desolator_thinker")
			keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
		end
	end)
end