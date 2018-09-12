LinkLuaModifier("modifier_gyroshaker_slam_down_lua","modifiers/modifier_gyroshaker_slam_down_lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_gyroshaker_slam_down_lua_slowdown","modifiers/modifier_gyroshaker_slam_down_lua_slowdown",LUA_MODIFIER_MOTION_NONE)
gyroshaker_slam_down_lua_second = class({})
function gyroshaker_slam_down_lua_second:IsHidden()				return true end
--function gyroshaker_slam_down_lua_second:CanAbilityBeUpgraded()	return false end
function gyroshaker_slam_down_lua_second:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_6
end
function gyroshaker_slam_down_lua_second:OnToggle()
	if self:GetToggleState() then
		local caster = self:GetCaster()
		self.target = nil
		if self.missile~=nil then self.target = self.missile else self.target = self:GetCaster() end
		local target = self.target
		local main_self
		if caster:FindAbilityByName("gyroshaker_slam_down_lua") ~= nil then
			main_self = caster:FindAbilityByName("gyroshaker_slam_down_lua")
		end
		local range = main_self:GetSpecialValueFor("slam_down_range")
		local duration = main_self:GetSpecialValueFor("second_slam_max_delay")
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			target:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
		--[[if #enemies<1 then
			self:PlayEffects(0)
		end]]
		local isenemy = false
		for _,enemy in pairs(enemies) do
			if not enemy:IsMagicImmune() then
				local ms_min = main_self:GetSpecialValueFor("slam_down_slowdown_min")
				local ms_max = main_self:GetSpecialValueFor("slam_down_slowdown_max")
				local dmg_min = main_self:GetSpecialValueFor("second_slam_damage_min")
				local dmg_max = main_self:GetSpecialValueFor("second_slam_damage_max")
				local dur = duration
				local rem = self.remaining_time
				self.ms = ms_min + ((ms_max - ms_min) * (dur - rem) / dur)
				self.dmg = dmg_min + ((dmg_max - dmg_min) * (rem / dur))
				local damageTable = {
					victim = enemy,
					attacker = caster,
					damage = self.dmg,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self,}
				ApplyDamage(damageTable)
				isenemy = true
				--print(ms_min,ms_max,dmg_min,dmg_max,dur,rem)
				--print("Self.Movespeed =",self.ms)
				--print("Self.Damage =",self.dmg)
				enemy:AddNewModifier(caster,self,"modifier_gyroshaker_slam_down_lua_slowdown",{duration=duration})
			end
		end
		self:PlayEffects(isenemy)
		target:RemoveModifierByName("modifier_gyroshaker_slam_down_lua")
		self:ToggleAbility()
	end
end
function gyroshaker_slam_down_lua_second:PlayEffects(isenemy)
	local target = self.target
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf"
	local sound_cast = "Hero_EarthShaker.EchoSlam"
	if not isenemy then sound_cast = "Hero_EarthShaker.EchoSlamSmall" EmitSoundOn(sound_cast,target) return end
	EmitSoundOn(sound_cast,target)
	local effect_cast = ParticleManager:CreateParticle(particle_cast,PATTACH_ABSORIGIN_FOLLOW,target)
	ParticleManager:SetParticleControl(effect_cast,1,Vector(echoes,0,0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end