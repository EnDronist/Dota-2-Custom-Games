function lavish_raindrop_getgold(keys)
	local caster = keys.caster
	local player = PlayerResource:GetPlayer( caster:GetPlayerID() )
	local ability = keys.ability
	local bounty = ability:GetLevelSpecialValueFor("gold_bonus", ability:GetLevel())
	local particleName = "particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf"		
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN, caster)
	caster:SetGold(caster:GetGold() + bounty, false)
	ParticleManager:SetParticleControl( particle, 0, caster:GetAbsOrigin() )
	ParticleManager:SetParticleControl( particle, 1, caster:GetAbsOrigin() )
end