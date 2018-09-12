function phantom_assassin_stifling_dagger_ult_damage
	local caster = keys.caster
	local attacker = keys.attacker
	local target = keys.target
	local ability = keys.ability
	local attack_factor_tooltip = ability:GetLevelSpecialValueFor("attack_factor_tooltip", (ability:GetLevel() - 1))
	local hero_damage = caster:GetDamageDoneToHero()

	local damage_table = {}

		damage_table.attacker = caster
		damage_table.victim = target
		damage_table.ability = ability
		damage_table.damage_type = ability:GetAbilityDamageType()
		damage_table.damage = ability.damage + (attack_factor_tooltip * hero_damage / 100)
		
	ApplyDamage(damage_table)
end