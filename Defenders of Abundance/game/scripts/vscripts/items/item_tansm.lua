function item_tansm_on_spell_start(keys)	
	keys.caster:EmitSound("DOTA_Item.Tango.Activate")
	ParticleManager:CreateParticle("particles/tansm.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.caster)

	local nearby_ally = FindUnitsInRadius(keys.caster:GetTeam(), keys.caster:GetAbsOrigin(), nil, keys.HealRadius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO , DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		
	for i, nearby_ally in ipairs(nearby_ally) do  --Restore health and play a particle effect for every found ally.
		if not nearby_ally:HasModifier("modifier_item_tansm_heal_debuff") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, nearby_ally, "modifier_item_tansm_active", nil)
		end
		nearby_ally:EmitSound("DOTA_Item.Tango.Target")
		ParticleManager:CreateParticle("particles/tansm.vpcf", PATTACH_ABSORIGIN_FOLLOW, nearby_ally)
		keys.ability:ApplyDataDrivenModifier(keys.caster, nearby_ally, "modifier_item_tansm_heal_debuff", nil)
	end
end