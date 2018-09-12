modifier_gyroshaker_enchanted_with_echo_lua = class({})
function modifier_gyroshaker_enchanted_with_echo_lua:IsHidden() return false end
function modifier_gyroshaker_enchanted_with_echo_lua:IsDebuff() return false end
function modifier_gyroshaker_enchanted_with_echo_lua:IsPurgable() return true end
function modifier_gyroshaker_enchanted_with_echo_lua:OnCreated(kv)
	self.bonus = self:GetAbility():GetSpecialValueFor("totem_damage_percentage")
	if IsServer() and self:GetParent() == self:GetCaster() then
		local duration = self:GetAbility():GetDuration()
		--self:GetCaster():AddNewModifier(self:GetCaster(),self:GetAbility(),"modifier_earthshaker_enchant_totem",{duration = duration})
		self:PlayEffects()
	end
end
function modifier_gyroshaker_enchanted_with_echo_lua:OnRefresh(kv)
	self.bonus = self:GetAbility():GetSpecialValueFor("totem_damage_percentage")
end
function modifier_gyroshaker_enchanted_with_echo_lua:OnDestroy(kv) end
function modifier_gyroshaker_enchanted_with_echo_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK}
	return funcs
end
function modifier_gyroshaker_enchanted_with_echo_lua:GetOverrideAnimation()
	return ACT_DOTA_EARTHSHAKER_TOTEM_ATTACK
end
function modifier_gyroshaker_enchanted_with_echo_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.bonus
end
function modifier_gyroshaker_enchanted_with_echo_lua:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		local sound_cast = "Hero_EarthShaker.Totem.Attack"
		EmitSoundOn(sound_cast,params.target)
		local caster = self:GetCaster()
		local damage_range = self:GetAbility():GetSpecialValueFor("echo_slam_damage_range")
		local init_range = self:GetAbility():GetSpecialValueFor("echo_slam_echo_search_range")
		local echo_range = self:GetAbility():GetSpecialValueFor("echo_slam_echo_range")
		local projectile_name = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam.vpcf"
		local projectile_speed = 600
		extraData = {hit_damage = params.damage}
		local info = {
			--Target = target,
			--Source = caster,
			Ability = self:GetAbility(),
			EffectName = projectile_name,
			iMoveSpeed = projectile_speed,
			bDodgeable = true,
			--vSourceLoc = caster:GetAbsOrigin(),
			bReplaceExisting = false,
			ExtraData = extraData,
		}
		ProjectileManager:CreateTrackingProjectile(info)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			params.target:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			init_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
		if #enemies<1 then
			self:PlayEchoEffects(0,params.target)
			self:Destroy()
			return nil
		end
		local echoes = 0
		for _,enemy in pairs(enemies) do
			--[[if not enemy:IsMagicImmune() then
				local damageTable = {
					victim = enemy,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self, --Optional.
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
				false	-- bool, can grow cache
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
		self:PlayEchoEffects(echoes,params.target)
		self:Destroy()
	end
end
function modifier_gyroshaker_enchanted_with_echo_lua:CheckState()
	local state = {
		[MODIFIER_STATE_CANNOT_MISS] = true,}
	return state
end
function modifier_gyroshaker_enchanted_with_echo_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast,PATTACH_POINT_FOLLOW,self:GetParent())
	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment("attach_totem")~=0 then attach = "attach_totem" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0),
		true)
	self:AddParticle(effect_cast,false,false,-1,false,false)
end
function modifier_gyroshaker_enchanted_with_echo_lua:PlayEchoEffects(echoes,target)
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