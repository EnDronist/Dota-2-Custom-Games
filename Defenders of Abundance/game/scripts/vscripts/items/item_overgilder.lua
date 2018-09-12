function modifier_item_overgilder_buff_on_attack(keys)
	if not keys.caster:IsRangedAttacker() then
		if not keys.caster:HasModifier("modifier_overgilder_cooldown") then
			if not keys.caster:HasModifier("modifier_item_overgilder_buff") then
				keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_overgilder_debuff", nil)
				modifier_item_overgilder_debuff_gold_damage(keys)
				keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_overgilder_buff", nil)
				keys.ability:StartCooldown(keys.ability:GetCooldown(keys.ability:GetLevel()))  --This is just for visual purposes.
				keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_overgilder_cooldown", nil)
			end
		elseif keys.caster:HasModifier("modifier_item_overgilder_buff") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.target, "modifier_item_overgilder_debuff", nil)
			modifier_item_overgilder_debuff_gold_damage(keys)
		end
	end
end

function modifier_item_overgilder_debuff_gold_damage(keys)
	keys.damage_percent_min = keys.ability:GetSpecialValueFor("damage_percent_min")
	keys.damage_percent_max = keys.ability:GetSpecialValueFor("damage_percent_max")
	keys.koef				= keys.ability:GetSpecialValueFor("overgilder_koef_percent")
	keys.exp_koef			= keys.ability:GetSpecialValueFor("overgilder_koef_exponentiation")
	keys.illus				= keys.ability:GetSpecialValueFor("overgilder_koef_from_illusions_percent")
	keys.build				= keys.ability:GetSpecialValueFor("overgilder_koef_to_buildings_percent")
	local player = PlayerResource:GetPlayer(keys.caster:GetPlayerID())
	local hero_gold = player:GetAssignedHero():GetGold()
	local this_chance = RandomInt(keys.damage_percent_min,keys.damage_percent_max)
	if keys.caster:HasModifier("modifier_alchemist_goblins_greed") then
		keys.koef = keys.koef/1.5
	end
	
	--[[Подсчёт урона]]
	local app_dam = math.ceil((this_chance/100)*(hero_gold*(keys.koef/100))^(keys.exp_koef))
	if keys.caster:IsIllusion() then app_dam = math.ceil(app_dam * (keys.illus/100)) end
	if keys.target:IsBuilding() then app_dam = math.ceil(app_dam * (keys.build/100)) end
		local damageTable = {
		victim = keys.target,
		attacker = keys.caster,
		damage = app_dam,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		}
	ApplyDamage(damageTable)
	--[[-------------]]
	if app_dam > 700 then app_dam = 700 end
	local symbol = 9 -- "+" presymbol
	if app_dam >= 200 then symbol = 5 end
	local color = Vector(255, 0.2*(700 - app_dam), 33) -- Gold
	local lifetime = 2
	local digits = string.len(damageTable.damage) + 1
	local particleName = "particles/overgilder_msg_gold_damage.vpcf"
	local particle = ParticleManager:CreateParticleForPlayer(particleName, PATTACH_ABSORIGIN, keys.target, player)
	ParticleManager:SetParticleControl(particle, 1, Vector(symbol, damageTable.damage, symbol))
    ParticleManager:SetParticleControl(particle, 2, Vector(lifetime, digits, 0))
    ParticleManager:SetParticleControl(particle, 3, color)
end

function modifier_item_overgilder_recalculate(keys)
	Timers:CreateTimer({
		callback = function()
			local overgilder = nil
			for i=0, 5, 1 do
				local current_item = keys.caster:GetItemInSlot(i)
				if current_item ~= nil then
					local item_name = current_item:GetName()
					if item_name == "item_overgilder" then
						overgilder = current_item
					end
				end
			end
		end
	})
end