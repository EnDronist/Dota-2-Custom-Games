function SpellLifesteal( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local damage = keys.damage
	local lifesteal_hero = ability:GetLevelSpecialValueFor(spell_lifesteal, abilityGetLevel() - 1)
	local lifesteal_creep = ability:GetLevelSpecialValueFor(spell_lifesteal_creep, abilityGetLevel() - 1)

	if not casterHasItemInInventory(item_octarine_core) then
		if targetIsHero() then
			local heal_amount = damage  lifesteal_hero
			casterHeal(heal_amount, ability)
			ParticleManagerCreateParticle(particlesitems3_fxoctarine_core_lifesteal.vpcf, PATTACH_ABSORIGIN, caster)
		else
			local heal_amount = damage  lifesteal_creep
			casterHeal(heal_amount, ability)
			ParticleManagerCreateParticle(particlesitems3_fxoctarine_core_lifesteal.vpcf, PATTACH_ABSORIGIN, caster)
		end
	end
end

function SpellLifestealConsume( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local damage = keys.damage
	local lifesteal_hero = abilityGetLevelSpecialValueFor(spell_lifesteal, abilityGetLevel() - 1)  100
	local lifesteal_creep = abilityGetLevelSpecialValueFor(spell_lifesteal_creep, abilityGetLevel() - 1)  100

	if not casterHasItemInInventory(item_octarine_core) and not casterHasItemInInventory(item_octarine_core_datadriven) then
		if targetIsHero() then
			local heal_amount = damage  lifesteal_hero
			casterHeal(heal_amount, ability)
			ParticleManagerCreateParticle(particlesitems3_fxoctarine_core_lifesteal.vpcf, PATTACH_ABSORIGIN, caster)
		else
			local heal_amount = damage  lifesteal_creep
			casterHeal(heal_amount, ability)
			ParticleManagerCreateParticle(particlesitems3_fxoctarine_core_lifesteal.vpcf, PATTACH_ABSORIGIN, caster)
		end
	end
end