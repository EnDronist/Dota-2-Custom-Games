LinkLuaModifier("modifier_gyroshaker_slam_down_lua","modifiers/modifier_gyroshaker_slam_down_lua",LUA_MODIFIER_MOTION_NONE)
gyroshaker_slam_down_lua = class({})
function gyroshaker_slam_down_lua:IsHidden() return false end
function gyroshaker_slam_down_lua:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_6
end
function gyroshaker_slam_down_lua:OnSpellStart()
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("slam_down_damage")
	local range = self:GetSpecialValueFor("slam_down_range")
	local duration = self:GetSpecialValueFor("second_slam_max_delay")
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
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
			local damageTable = {
				victim = enemy,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,}
			ApplyDamage(damageTable)
			isenemy = true
		end
	end
	self:PlayEffects(isenemy)
	caster:AddNewModifier(caster,self,"modifier_gyroshaker_slam_down_lua",{duration=duration})
end
function gyroshaker_slam_down_lua:PlayEffects(isenemy)
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf"
	local sound_cast = "Hero_EarthShaker.EchoSlam"
	if not isenemy then sound_cast = "Hero_EarthShaker.EchoSlamSmall" EmitSoundOn(sound_cast,self:GetCaster()) return end
	EmitSoundOn(sound_cast,self:GetCaster())
	local effect_cast = ParticleManager:CreateParticle(particle_cast,PATTACH_ABSORIGIN_FOLLOW,self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast,1,Vector(echoes,0,0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end