--[[Author: YOLOSPAGHETTI
	Date: March 28, 2016
	Creates the missile]]
LinkLuaModifier("modifier_generic_stunned_lua","generic/modifier_generic_stunned_lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_gyroshaker_missile_totem_datadriven_thinker","modifiers/modifier_gyroshaker_missile_totem_datadriven_thinker",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_gyroshaker_enchanted_with_echo_lua","modifiers/modifier_gyroshaker_enchanted_with_echo_lua",LUA_MODIFIER_MOTION_NONE)
function CreateMissile(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	if caster.missile~=nil then
		if not caster.missile:IsNull() then
			ability.ab4.missile = nil
			caster.missile:ForceKill(false)
			caster:RemoveModifierByName("modifier_gyroshaker_missile_totem_datadriven_buff")
			target:RemoveModifierByName("modifier_gyroshaker_missile_totem_datadriven_target")
		end
	end
	local starting_distance = ability:GetLevelSpecialValueFor("starting_distance",ability:GetLevel()-1)
	local direction = caster:GetForwardVector()
	local position = caster:GetAbsOrigin() + starting_distance * direction
	ability.target = target
	ability.starting_position = position
	ability.level = ability:GetLevel()-1
	ability.hits_to_kill = ability:GetLevelSpecialValueFor("hits_to_kill",ability:GetLevel()-1)
	ability.hit = false
	ability.back = false
	ability.hit_effects = false
	caster.missile = CreateUnitByName("npc_dota_gyrocopter_homing_missile",position,true,caster,nil,caster:GetTeam())
	ability:ApplyDataDrivenModifier(caster,caster.missile,"modifier_gyroshaker_missile_totem_datadriven",{})
	caster.missile:SetOwner(caster)
	ability.time_passed = 0
	ability.distance_back_wall = ability.starting_position
	ability.block_width = 128
	ability.distance_to_wall = ability.block_width
	ability.totem_damage_buff = 0--%
	local particle = ParticleManager:CreateParticle(keys.particle,PATTACH_ABSORIGIN_FOLLOW,caster.missile) 
	ParticleManager:SetParticleControlEnt(particle,1,caster.missile,PATTACH_POINT_FOLLOW,"attach_hitloc",caster.missile:GetAbsOrigin(),true)
end
--[[Author: YOLOSPAGHETTI
	Date: March 28, 2016
	Moves the missile and senses when it hits the target]]
function MoveMissile(keys)
	local caster = keys.caster
	local ability = keys.ability
	local target
	if ability.hit == true or ability.target == nil then
		target = caster
	else
		target = ability.target
	end
	local interval = 0.03
	if caster.missile:IsNull() then return nil
	else
	if ability.back == true then
		-- Уничтожение Missile
		caster:RemoveModifierByNameAndCaster("modifier_gyroshaker_missile_totem_datadriven_target",caster)
		caster:RemoveModifierByName("modifier_gyroshaker_missile_totem_datadriven_buff")
		ability.ab4.missile = nil
		caster.missile:ForceKill(false)
	else
		local pre_flight_time = ability:GetLevelSpecialValueFor("pre_flight_time",ability.level)
		local stun_duration = ability:GetLevelSpecialValueFor("stun_duration",ability.level)
		local min_damage = ability:GetLevelSpecialValueFor("min_damage",ability.level)
		local max_distance = ability:GetLevelSpecialValueFor("max_distance",ability.level)
		local min_distance = ability:GetLevelSpecialValueFor("min_distance",ability.level)
		local speed = ability:GetLevelSpecialValueFor("speed",ability.level)*interval
		local acceleration = ability:GetLevelSpecialValueFor("acceleration",ability.level)*interval
		--Талант
		if caster:FindAbilityByName("special_bonus_unique_gyroshaker_missile_totem_acceleration"):GetLevel() > 0 then
				talent = caster:FindAbilityByName("special_bonus_unique_gyroshaker_missile_totem_acceleration")
				acceleration = acceleration + talent:GetSpecialValueFor("value")*interval
		end
		--------
		local vector_distance = target:GetAbsOrigin() - caster.missile:GetAbsOrigin()
		local distance = (vector_distance):Length2D()
		local direction = (vector_distance):Normalized()
		if not caster.missile:HasModifier("modifier_gyroshaker_enchanted_with_echo_lua") then ability.totem_damage_buff = 0 end
		ability.time_passed = ability.time_passed + interval
		if (caster.missile:GetAbsOrigin() - ability.distance_back_wall):Length2D() >= 128 then
			ability.distance_back_wall = caster.missile:GetAbsOrigin()
			local block_delta = ability.block_delta
			local block_width = ability.block_width
			local duration = 5 --ability:GetSpecialValueFor("duration")
			local block_vec = caster.missile:GetOrigin()
			local blocker = CreateModifierThinker(
				caster,
				ability,
				"modifier_gyroshaker_missile_totem_datadriven_thinker",
				{duration = duration},
				block_vec,
				caster:GetTeamNumber(),
				true
			)
			blocker:SetHullRadius(block_width)
			local units = FindUnitsInRadius(
				caster:GetTeamNumber(),
				blocker:GetOrigin(),
				nil,
				block_width,
				DOTA_UNIT_TARGET_TEAM_BOTH,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_CLOSEST,
				true
			)
			for _,unit in pairs(units) do
				FindClearSpaceForUnit(unit, unit:GetOrigin(), true)
			end
			PlayEffects(keys, caster.missile:GetOrigin(), duration, blocker)
		end
		if ability.time_passed >= pre_flight_time then
			if ability.time_passed == pre_flight_time then
				EmitSoundOn(keys.sound2, caster.missile)
			end
			if distance < 128 then
				local travel_vector_distance = caster.missile:GetAbsOrigin() - ability.starting_position
				local travel_distance = travel_vector_distance:Length2D()
				local damage
				if travel_distance >= max_distance then
					damage = ability:GetAbilityDamage()
				elseif travel_distance > min_distance then
					damage = (travel_distance/max_distance) * ability:GetAbilityDamage()
				else
					damage = min_damage
				end
				if target == caster then
					target:RemoveModifierByNameAndCaster("modifier_gyroshaker_missile_totem_datadriven_target",caster)
					ability.back = true
				else
					if not target:IsMagicImmune() then
						--if damage < min_damage then damage = min_damage end
						target:AddNewModifier(caster,ability,"modifier_generic_stunned_lua",{duration = stun_duration})
						ApplyDamage({victim=target, attacker=caster, damage=damage*((100+ability.totem_damage_buff)/100), damage_type=ability:GetAbilityDamageType()})
					end
					ability:ApplyDataDrivenModifier(caster,caster,"modifier_gyroshaker_missile_totem_datadriven_target",{})
					target:RemoveModifierByNameAndCaster("modifier_gyroshaker_missile_totem_datadriven_target",caster)
					if caster.missile:HasModifier("modifier_gyroshaker_enchanted_with_echo_lua") then
						local a1 = "gyroshaker_enchanted_with_echo_lua",other_ability
						for i=1,6 do if caster:GetAbilityByIndex(i-1):GetAbilityName() == a1 then other_ability = caster:GetAbilityByIndex(i-1) end end
						local params = {target = target, damage = damage}
						if IsServer() then
							local sound_cast = "Hero_EarthShaker.Totem.Attack"
							EmitSoundOn(sound_cast,params.target)
							local damage_range = other_ability:GetSpecialValueFor("echo_slam_damage_range")
							local init_range = other_ability:GetSpecialValueFor("echo_slam_echo_search_range")
							local echo_range = other_ability:GetSpecialValueFor("echo_slam_echo_range")
							local echo_damage = other_ability:GetSpecialValueFor("echo_slam_echo_damage")
							local projectile_name = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam.vpcf"
							local projectile_speed = 600
							extraData = {hit_damage = params.damage}
							local info = {
								--Target = target,
								--Source = caster,
								Ability = other_ability,
								EffectName = projectile_name,
								iMoveSpeed = projectile_speed,
								bDodgeable = true,
								--vSourceLoc = caster:GetAbsOrigin(),
								bReplaceExisting = false,
								ExtraData = extraData,
							}
							ProjectileManager:CreateTrackingProjectile(info)
							-- find echoing units
							local enemies = FindUnitsInRadius(
								caster:GetTeamNumber(),	-- int, your team number
								target:GetOrigin(),	-- point, center point
								nil,	-- handle, cacheUnit. (not known)
								init_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
								DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
								DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
								DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
								0,	-- int, order filter
								false	-- bool, can grow cache
							)
							if #enemies<1 then
								PlayEchoEffects(0,params.target)
								caster.missile:RemoveModifierByName("modifier_gyroshaker_enchanted_with_echo_lua")
								return
							end
							local echoes = 0
							for _,enemy in pairs(enemies) do
								--[[if not enemy:IsMagicImmune() then
									local damageTable = {
										victim = enemy,
										attacker = caster,
										damage = damage,
										damage_type = DAMAGE_TYPE_MAGICAL,
										ability = other_ability,
									}
									ApplyDamage(damageTable)
								end]]
								local targets = FindUnitsInRadius(
									caster:GetTeamNumber(),	-- int, your team number
									enemy:GetOrigin(),	-- point, center point
									nil,	-- handle, cacheUnit. (not known)
									echo_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
									DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
									DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
									DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
									FIND_CLOSEST,	-- int, order filter
									false
								)
								for _,target in pairs(targets) do
									if target~=enemy then
										info.Target = target
										info.Source = enemy
										ProjectileManager:CreateTrackingProjectile(info)
										echoes = echoes + 1
										if enemy:IsRealHero() then
											ProjectileManager:CreateTrackingProjectile(info)
											echoes = echoes + 1
										end
									end
								end
							end
							PlayEchoEffects(echoes,params.target)
							caster.missile:RemoveModifierByName("modifier_gyroshaker_enchanted_with_echo_lua")
						end
					end
					ability.hit = true
				end
				if ability.hit == true and ability.hit_effects == false then
					ability.hit_effects = true
					local vision_time = ability:GetLevelSpecialValueFor("vision_time",ability.level)
					local vision_radius = ability:GetLevelSpecialValueFor("vision_radius",ability.level)
					AddFOWViewer(caster:GetTeam(),target:GetAbsOrigin(),vision_radius,vision_time,false)
					local particle = ParticleManager:CreateParticle(keys.particle2,PATTACH_ABSORIGIN_FOLLOW,target) 
					ParticleManager:SetParticleControlEnt(particle,1,target,PATTACH_POINT_FOLLOW,"attach_hitloc",target:GetAbsOrigin(),true)
					EmitSoundOn(keys.sound3,caster.missile)
				end
			else
				-- Turns the missile so it's facing the target
				caster.missile:SetForwardVector(Vector(direction.x/2,direction.y/2,0))
				-- Calculates the time after launch so we can solve for the new speed (after acceleration)
				local move_duration = math.modf(ability.time_passed - pre_flight_time)
				speed = speed + acceleration * move_duration
				-- Moves the missile
				caster.missile:SetAbsOrigin(caster.missile:GetAbsOrigin() + direction * speed)
			end
		end
	end
	end
end
function PlayEchoEffects(echoes,target)
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf"
	local sound_cast = "Hero_EarthShaker.EchoSlam"
	if echoes<1 then
		sound_cast = "Hero_EarthShaker.EchoSlamSmall"
	end
	local effect_cast = ParticleManager:CreateParticle(particle_cast,PATTACH_ABSORIGIN_FOLLOW,target)
	ParticleManager:SetParticleControl(effect_cast,1,Vector(echoes,0,0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast,target)
end
--[[Author: YOLOSPAGHETTI
	Date: March 28, 2016
	Keeps track of attacks on the missile and applies all death particles and sfx]]
function MissileAttacked(keys)
	local caster = keys.caster
	local attacker = keys.attacker
	local ability = keys.ability
	local target = ability.target
	local total_hits = ability:GetLevelSpecialValueFor("hits_to_kill",ability.level)
	if caster.missile:IsNull() then
		caster:RemoveModifierByName("modifier_gyroshaker_missile_totem_datadriven_buff")
	else
		if attacker:IsTower() then
			ability.hits_to_kill = ability.hits_to_kill - 0.5
			caster.missile:SetHealth(caster.missile:GetMaxHealth()*(ability.hits_to_kill/total_hits))
		elseif attacker == caster.missile then
			ability.hits_to_kill = 0
		elseif attacker:IsCreep() then
			ability.hits_to_kill = ability.hits_to_kill - 0.2
			caster.missile:SetHealth(caster.missile:GetMaxHealth()*(ability.hits_to_kill/total_hits))
		else
			ability.hits_to_kill = ability.hits_to_kill-1
			caster.missile:SetHealth(caster.missile:GetMaxHealth()*(ability.hits_to_kill/total_hits))
		end
		if ability.hits_to_kill <= 0 then
			if attacker ~= caster.missile then EmitSoundOn(keys.sound4,caster.missile) end
			local particle = ParticleManager:CreateParticle(keys.particle,PATTACH_ABSORIGIN_FOLLOW,caster.missile) 
			ParticleManager:SetParticleControlEnt(particle,1,caster.missile,PATTACH_POINT_FOLLOW,"attach_hitloc",caster.missile:GetAbsOrigin(),true)
			caster.missile:AddNoDraw()
			StopSoundEvent(keys.sound,caster.missile)
			StopSoundEvent(keys.sound2,caster.missile)
			-- Уничтожение Missile
			target:RemoveModifierByNameAndCaster("modifier_gyroshaker_missile_totem_datadriven_target",caster)
			if ability.back == false then
				ability:ApplyDataDrivenModifier(caster,caster,"modifier_gyroshaker_missile_totem_datadriven_target",{})
				caster:RemoveModifierByNameAndCaster("modifier_gyroshaker_missile_totem_datadriven_target",caster)
			end
			caster:RemoveModifierByName("modifier_gyroshaker_missile_totem_datadriven_buff")
			--if caster.missile:HasModifier("") then end
			ability.ab4.missile = nil
			caster.missile:ForceKill(false)
		end
	end
end
function MissileTotemCasterCheck(keys)
	if keys.target == keys.caster or keys.anyway == "yes" then
		keys.caster:SwapAbilities(keys.main_ability_name,keys.sub_ability_name,false,true)
		if keys.main_ability_name == keys.check_ability then
			local level_ability = keys.caster:FindAbilityByName(keys.sub_ability_name)
			if level_ability:GetLevel() ~= 1 then level_ability:SetLevel(1) end
		end
	end
end
function MissileTotemCasterEnd(keys)
	keys.ability:ToggleAbility()
	if keys.caster:GetAbilityByIndex(7-1):GetAbilityName() == "gyroshaker_missile_totem_datadriven" then
		main_ability = keys.caster:GetAbilityByIndex(7-1)
		main_ability:ApplyDataDrivenModifier(keys.caster,keys.caster,"modifier_gyroshaker_missile_totem_datadriven_target",{})
		main_ability.target:RemoveModifierByNameAndCaster("modifier_gyroshaker_missile_totem_datadriven_target",keys.caster)
		main_ability.hit = true
		if keys.caster.missile:IsNull() then keys.caster:RemoveModifierByName("modifier_gyroshaker_missile_totem_datadriven_target") end
	end
end
function MissileTotemInability(keys)
	local caster = keys.caster
	local ability = keys.ability
	local a1 = keys.first,ab1
	local a2 = keys.second,ab2
	local a3 = keys.third,ab3
	local a4 = keys.fourth,ability.ab4
	for i=1,8 do
		if caster:GetAbilityByIndex(i-1):GetAbilityName() == a1 then ab1 = caster:GetAbilityByIndex(i-1) end
		if caster:GetAbilityByIndex(i-1):GetAbilityName() == a2 then ab2 = caster:GetAbilityByIndex(i-1) end
		if caster:GetAbilityByIndex(i-1):GetAbilityName() == a3 then ab3 = caster:GetAbilityByIndex(i-1) end
		if caster:GetAbilityByIndex(i-1):GetAbilityName() == a4 then ability.ab4 = caster:GetAbilityByIndex(i-1) end
	end
	if ab1 ~= nil then if ab1:IsActivated() then
		ab1:SetActivated(false)
		if caster:HasModifier("modifier_gyroshaker_rocket_shock_lua") then
			caster.missile:AddNewModifier(caster,ab1,"modifier_gyroshaker_rocket_shock_lua",{duration=caster:FindModifierByName("modifier_gyroshaker_rocket_shock_lua"):GetRemainingTime()})
			caster:RemoveModifierByName("modifier_gyroshaker_rocket_shock_lua")
		end
	else
		ab1:SetActivated(true)
		if caster.missile:HasModifier("modifier_gyroshaker_rocket_shock_lua") then
			caster:AddNewModifier(caster,ab1,"modifier_gyroshaker_rocket_shock_lua",{duration=caster.missile:FindModifierByName("modifier_gyroshaker_rocket_shock_lua"):GetRemainingTime()})
			caster.missile:RemoveModifierByName("modifier_gyroshaker_rocket_shock_lua")
	end end end
	if ab2 ~= nil then if ab2:IsActivated() then
		ab2:SetActivated(false)
		if caster:HasModifier("modifier_gyroshaker_enchanted_with_echo_lua") then
			ability.totem_damage_buff = ab2:GetSpecialValueFor("totem_damage_percentage")
			caster.missile:AddNewModifier(caster,ab2,"modifier_gyroshaker_enchanted_with_echo_lua",{duration=caster:FindModifierByName("modifier_gyroshaker_enchanted_with_echo_lua"):GetRemainingTime()})
			caster:RemoveModifierByName("modifier_gyroshaker_enchanted_with_echo_lua")
		end
	else
		ab2:SetActivated(true)
		if caster.missile:HasModifier("modifier_gyroshaker_enchanted_with_echo_lua") then
			caster:AddNewModifier(caster,ab2,"modifier_gyroshaker_enchanted_with_echo_lua",{duration=caster.missile:FindModifierByName("modifier_gyroshaker_enchanted_with_echo_lua"):GetRemainingTime()})
			caster.missile:RemoveModifierByName("modifier_gyroshaker_enchanted_with_echo_lua")
	end end end
	if ab3 ~= nil then if ab3:IsActivated() then
		ab3:SetActivated(false)
		if caster:HasModifier("modifier_gyroshaker_slam_down_lua") then
			ab3.replacing = true
			ability.ab4.missile = caster.missile
			caster.missile:AddNewModifier(caster,ab3,"modifier_gyroshaker_slam_down_lua",{duration=caster:FindModifierByName("modifier_gyroshaker_slam_down_lua"):GetRemainingTime()})
			caster:RemoveModifierByName("modifier_gyroshaker_slam_down_lua")
			ab3.replacing = false
		end
	else
		ab3:SetActivated(true)
		if caster.missile:HasModifier("modifier_gyroshaker_slam_down_lua") then
			ab3.replacing = true
			ability.ab4.missile = nil
			caster:AddNewModifier(caster,ab3,"modifier_gyroshaker_slam_down_lua",{duration=caster.missile:FindModifierByName("modifier_gyroshaker_slam_down_lua"):GetRemainingTime()})
			caster.missile:RemoveModifierByName("modifier_gyroshaker_slam_down_lua")
			ab3.replacing = false
	end end end
end
function PlayEffects(keys,wall_vector,duration,entity)
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf"
	local sound_cast = "Hero_EarthShaker.Fissure"
	local caster = keys.ability:GetCaster()
	local direction = wall_vector:Normalized()
	local position = caster.missile:GetOrigin()
	local effect_cast = ParticleManager:CreateParticle(particle_cast,PATTACH_WORLDORIGIN,caster)
	ParticleManager:SetParticleControl(effect_cast,0,position)
	ParticleManager:SetParticleControl(effect_cast,1,position)
	ParticleManager:SetParticleControl(effect_cast,2,Vector(duration,0,0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	entity:EmitSoundParams(sound_cast,0.01,0.01,2)
	--EmitSoundOnLocationWithCaster(position, sound_cast, caster)
end