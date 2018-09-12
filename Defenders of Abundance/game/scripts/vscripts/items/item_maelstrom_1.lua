if item_maelstrom_1 == nil then
_G.item_maelstrom_1 = class({}) end
function modifier_item_orb(keys)
if not keys.caster:HasModifier("modifier_item_desolator_thinker") and not keys.caster:HasModifier("modifier_item_skadi_thinker") then
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
		if desolator == 0 and skadi == 0 --[[and maelstrom == 1]] then
			if not keys.caster:HasModifier("modifier_item_maelstrom_orb") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_maelstrom_orb", nil)
				keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
				--keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
			end
		end
		--if desolator == 0 and skadi == 1 --[[and maelstrom == 0]] then
		--	if not keys.caster:HasModifier("modifier_item_skadi_orb") then
		--	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_skadi_orb", nil)
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
		--		--keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
		--	end
		--end
		if desolator == 0 and skadi == 1 --[[and maelstrom == 1]] then
			if not keys.caster:HasModifier("modifier_item_skadi_maelstrom_orb") then
			keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_skadi_maelstrom_orb", nil)
				keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
				keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
				--keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
				keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
			end
		end
		--if desolator == 1 and skadi == 0 --[[and maelstrom == 0]] then
		--	if not keys.caster:HasModifier("modifier_item_desolator_orb") then
		--	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_desolator_orb", nil)
		--		--keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
		--	end
		--end
		if desolator == 1 and skadi == 0 --[[and maelstrom == 1]] then
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
		--if desolator == 1 and skadi == 1 --[[and maelstrom == 0]] then
		--	if not keys.caster:HasModifier("modifier_item_desolator_skadi_orb") then
		--	keys.ability:ApplyDataDrivenModifier(keys.caster, keys.caster, "modifier_item_desolator_skadi_orb", nil)
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
		--		--keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_skadi_maelstrom_orb")
		--		keys.caster:RemoveModifierByName("modifier_item_desolator_skadi_maelstrom_orb")
		--	end
		--end
		if desolator == 1 and skadi == 1 --[[and maelstrom == 1]] then
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
end
end
--If item loses
function modifier_item_maelstrom_lose(keys)
	local tick = 0.03
	Timers:CreateTimer(tick, function()
		local a = 0
		for i=0, 5, 1 do
			local current_item = keys.caster:GetItemInSlot(i)

			if current_item ~= nil then
				if current_item:GetName() == "item_maelstrom_1" then a = 1 end
			end
		end
		if a == 0 then
			keys.caster:RemoveModifierByName("modifier_item_maelstrom_thinker")
			keys.caster:RemoveModifierByName("modifier_item_maelstrom_orb")
		end
	end)
end
	
function item_maelstrom_1:maelstrom(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local sound_proc = "Item.Maelstrom.Chain_Lightning"
	local sound_bounce = "Item.Maelstrom.Chain_Lightning.Jump"
	local particle_bounce = 0
	--Effects
	local desolator = 0
	local skadi = 0
	for i=0, 5, 1 do 
		local current_item = caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_desolator_1" then desolator = 1 end
			if current_item:GetName() == "item_skadi_1" then skadi = 1 end
			--if current_item:GetName() == "item_maelstrom_1" or current_item:GetName() == "item_mjollnir_1" then maelstrom = 1 end --Всё, кроме Maelstrom и Mjollnir
		end
	end
	if desolator == 0 and skadi == 0 then
		particle_bounce = "particles/items_fx/chain_lightning.vpcf"
	elseif desolator == 0 and skadi == 1 then
		particle_bounce = "particles/items_fx/chain_lightning.vpcf"
		if target.GetInvulnCount == nil then
			if caster:IsRangedAttacker() then
				target:AddNewModifier(caster, ability, "modifier_item_skadi_maelstrom_corruption", {duration = _G.item_skadi_cold_duration_ranged})
			else
				target:AddNewModifier(caster, ability, "modifier_item_skadi_maelstrom_corruption", {duration = _G.item_skadi_cold_duration_melee})
			end
		end
	elseif desolator == 1 and skadi == 0 then
		particle_bounce = "particles/items_fx/desolator_chain_lightning.vpcf"
		target:AddNewModifier(caster, ability, "modifier_item_desolator_maelstrom_corruption", {duration = _G.item_desolator_corruption_duration})
	elseif desolator == 1 and skadi == 1 then
		particle_bounce = "particles/items_fx/desolator_chain_lightning.vpcf"
		if target.GetInvulnCount == nil then
			if caster:IsRangedAttacker() then
				target:AddNewModifier(caster, ability, "modifier_item_desolator_skadi_maelstrom_corruption", {duration = _G.item_skadi_cold_duration_ranged})
			else
				target:AddNewModifier(caster, ability, "modifier_item_desolator_skadi_maelstrom_corruption", {duration = _G.item_skadi_cold_duration_melee})
			end
		end
		target:AddNewModifier(caster, ability, "modifier_item_desolator_skadi_maelstrom_corruption", {duration = _G.item_desolator_corruption_duration})
	end
	
	-- If the target is a building, do nothing
	if target:IsBuilding() then
		return nil
	end

	-- Parameters
	local proc_chance = ability:GetSpecialValueFor("maelstrom_proc_chance")
	local bounce_damage = ability:GetSpecialValueFor("maelstrom_bounce_damage")
	local bounce_radius = ability:GetSpecialValueFor("maelstrom_bounce_radius")
	local bounce_delay = ability:GetSpecialValueFor("maelstrom_bounce_delay")
	local static_strikes = ability:GetSpecialValueFor("maelstrom_static_strikes")
	local this_chance = nil
	local sum_chance = proc_chance
	local items = 0
	for i=0, 5, 1 do 
		local current_item = caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_maelstrom_1" then items = items + 1 end
			if items > 1 then sum_chance = sum_chance + ((100 - sum_chance) * (proc_chance / 100)) end
		end
	end
	this_chance = RandomInt(0,100)
	--print (this_chance)
	if this_chance <= sum_chance then
		-- Play initial sound
		caster:EmitSound(sound_proc)

		-- Play first bounce sound
		target:EmitSound(sound_bounce)
	
		-- Play first particle
		local bounce_pfx = ParticleManager:CreateParticle(particle_bounce, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControlEnt(bounce_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(bounce_pfx, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(bounce_pfx, 2, Vector(1, 1, 1))
		ParticleManager:ReleaseParticleIndex(bounce_pfx)

		-- Damage initial target
		ApplyDamage({attacker = caster, victim = target, ability = ability, damage = bounce_damage, damage_type = DAMAGE_TYPE_MAGICAL})

		-- Initialize targets hit table
		local enemies_hit = {}
		enemies_hit[1] = target

		-- Start bouncing
		local keep_bouncing = false
		local current_bounce_source = target
		local current_bounce_source_loc = target:GetAbsOrigin()
		Timers:CreateTimer(bounce_delay, function()
			
			-- Search for valid bounce targets
			local nearby_enemies = FindUnitsInRadius(caster:GetTeamNumber(), current_bounce_source_loc, nil, bounce_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
			for _,enemy in pairs(nearby_enemies) do
				local is_valid_target = true
				for _,hit_enemy in pairs(enemies_hit) do
					if enemy == hit_enemy then is_valid_target = false end
				end

				-- If this enemy is a valid bounce target, stop searching and bounce
				if is_valid_target then
					
					-- Play bounce sound
					enemy:EmitSound(sound_bounce)

					-- Play bounce particle
					bounce_pfx = ParticleManager:CreateParticle(particle_bounce, PATTACH_ABSORIGIN_FOLLOW, target)
					ParticleManager:SetParticleControlEnt(bounce_pfx, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
					ParticleManager:SetParticleControlEnt(bounce_pfx, 1, current_bounce_source, PATTACH_POINT_FOLLOW, "attach_hitloc", current_bounce_source_loc, true)
					ParticleManager:SetParticleControl(bounce_pfx, 2, Vector(1, 1, 1))
					ParticleManager:ReleaseParticleIndex(bounce_pfx)

					-- Damage bounce target
					ApplyDamage({attacker = caster, victim = enemy, ability = ability, damage = bounce_damage, damage_type = DAMAGE_TYPE_MAGICAL})

					-- Update bounce parameters
					current_bounce_source = enemy
					current_bounce_source_loc = enemy:GetAbsOrigin()
					enemies_hit[#enemies_hit + 1] = enemy
					static_strikes = static_strikes - 1
					keep_bouncing = true
					break
				end
			end

			-- If we should keep bouncing, wait [bounce_delay] and restart the loop
			if keep_bouncing then
				if static_strikes > 0 then
					keep_bouncing = false
					return bounce_delay
				end
			end
		end)
	end
end

function Mjollnir( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local modifier_shield = keys.modifier_shield
	local sound_cast = keys.sound_cast
	local sound_loop = keys.sound_loop

	-- Apply the modifier to the target
	ability:ApplyDataDrivenModifier(caster, target, modifier_shield, {})

	-- Play cast sound
	target:EmitSound(sound_cast)

	-- End any previously existing sound loop, and create a new one
	StopSoundEvent(sound_loop, target)
	target:EmitSound(sound_loop)
end

function MjollnirProc( keys )
	local attacker = keys.attacker
	local shield_owner = keys.unit
	local ability = keys.ability
	local sound_hit = keys.sound_hit
	local particle_static = keys.particle_static
	local modifier_slow = keys.modifier_slow

	-- If the attacker and the shield owner are in the same team, do nothing
	if attacker:GetTeam() == shield_owner:GetTeam() then
		return nil
	end

	-- Parameters
	local static_chance = ability:GetSpecialValueFor("static_chance")
	local static_damage = ability:GetSpecialValueFor("static_damage")
	local static_radius = ability:GetSpecialValueFor("static_radius")

	-- "Pseudo-random" (not really), processing time-saving proc chance calculation
	if not shield_owner.mjollnir_proc_count then
		shield_owner.mjollnir_proc_count = static_chance
	else
		shield_owner.mjollnir_proc_count = shield_owner.mjollnir_proc_count + static_chance
	end

	-- If enough for a proc, ZAP THEM!
	if shield_owner.mjollnir_proc_count >= 100 then

		-- Reset proc chance
		shield_owner.mjollnir_proc_count = shield_owner.mjollnir_proc_count - 100

		local shield_owner_loc = shield_owner:GetAbsOrigin()
		local static_origin = shield_owner_loc + Vector(0, 0, 200)
		
		-- Search for nearby valid targets
		local nearby_enemies = FindUnitsInRadius(shield_owner:GetTeamNumber(), shield_owner_loc, nil, static_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
		for _,enemy in pairs(nearby_enemies) do
			
			-- Play hit sound
			enemy:EmitSound(sound_hit)

			-- Play particle
			local static_pfx = ParticleManager:CreateParticle(particle_static, PATTACH_ABSORIGIN_FOLLOW, shield_owner)
			ParticleManager:SetParticleControlEnt(static_pfx, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
			ParticleManager:SetParticleControl(static_pfx, 1, static_origin)
			ParticleManager:ReleaseParticleIndex(static_pfx)

			-- Apply damage
			ApplyDamage({attacker = shield_owner, victim = enemy, ability = ability, damage = static_damage, damage_type = DAMAGE_TYPE_MAGICAL})

			-- Apply slow modifier
			ability:ApplyDataDrivenModifier(shield_owner, enemy, modifier_slow, {})
		end
	end
end

function MjollnirEnd( keys )
	local target = keys.target
	local sound_end = keys.sound_end
	local sound_loop = keys.sound_loop

	-- Play end sound
	target:EmitSound(sound_end)

	-- Stop sound loop
	StopSoundEvent(sound_loop, target)
end