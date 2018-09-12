function mana_cost(keys)
	local caster = keys.caster
	local ability = keys.ability
	local mana_cost = ability:GetLevelSpecialValueFor("mana_cost", (ability:GetLevel() - 1)) + (ability:GetLevelSpecialValueFor("mana_cost_percent", (ability:GetLevel() - 1))/100)*caster:GetMaxMana()
	local caster_current_mana = caster:GetMana()
	if caster_current_mana >= mana_cost*2 then
		caster:ReduceMana(mana_cost)
		ability:ApplyDataDrivenModifier(caster,caster,"modifier_coup_de_grace_crit_2", {{duration = -1}})
	elseif caster_current_mana >= mana_cost then
		caster:ReduceMana(mana_cost)
		ability:ApplyDataDrivenModifier(caster,caster,"modifier_coup_de_grace_crit_2", {{duration = -1}})
		ability:ToggleAbility()
	else ability:ToggleAbility()
	end
end

function modifier_coup_de_grace_toogle(keys)
	local caster = keys.caster
	local ability = keys.ability
	local mana_cost = ability:GetLevelSpecialValueFor("mana_cost", (ability:GetLevel() - 1))
	local caster_current_mana = caster:GetMana()
	if caster_current_mana < mana_cost then
		ability:ToggleAbility()
	end
end

function swap(keys)
	local caster = keys.caster
	local skill_ult = keys.skill_ult
	local skill_normal = keys.skill_normal
	caster:SwapAbilities(skill_normal, skill_ult, false, true)
end

function ult_swap(keys)
	local caster = keys.caster
	local skill_ult = keys.skill_ult
	local skill_normal = keys.skill_normal
	caster:SwapAbilities(skill_ult, skill_normal, false, true)
end

function modifier_coup_de_grace_upgrade(keys)
	local caster = keys.caster
	local ability = keys.ability
	if ToggleAbility() == 1 then
		ability:ToggleAbility()
	end
end