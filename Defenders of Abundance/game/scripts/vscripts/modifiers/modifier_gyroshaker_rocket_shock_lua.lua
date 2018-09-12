LinkLuaModifier("modifier_generic_stunned_lua","generic/modifier_generic_stunned_lua",LUA_MODIFIER_MOTION_NONE)
modifier_gyroshaker_rocket_shock_lua = class ({})
function modifier_gyroshaker_rocket_shock_lua:IsHidden() 			return false end
function modifier_gyroshaker_rocket_shock_lua:IsDebuff() 			return false end
function modifier_gyroshaker_rocket_shock_lua:IsPurgable()			return false end
function modifier_gyroshaker_rocket_shock_lua:IsPurgeException()	return true end
function modifier_gyroshaker_rocket_shock_lua:OnCreated(kv)
	self.delay = self:GetAbility():GetSpecialValueFor("delay")
	if self:GetAbility():GetSpecialValueFor("duration")==self:GetRemainingTime() then
		self:StartIntervalThink(self.delay)
	else
		self:StartIntervalThink(self:GetRemainingTime()%self.delay)
		if self:GetRemainingTime()>=self.delay then
			Timers:CreateTimer(self:GetRemainingTime()%self.delay,function()
				self:OnIntervalThink(kv)
				self:StartIntervalThink(self.delay) return nil
			end)
		end
	end
end
function modifier_gyroshaker_rocket_shock_lua:OnRefresh(kv)
	self:StartIntervalThink(self.delay)
end
function modifier_gyroshaker_rocket_shock_lua:OnIntervalThink(kv)
	if IsServer() then
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
		self.enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false)
		self.damageTable = {
			victim = nil,
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		}
		for _,enemy in pairs(self.enemies) do
			self.damageTable.victim = enemy
			ApplyDamage(self.damageTable)
			enemy:AddNewModifier(self:GetCaster(),self,"modifier_generic_stunned_lua",{duration=self.stun_duration})
		end
		-- Звуки и эффекты
		self.sound = "Hero_EarthShaker.Totem"
		EmitSoundOn(self.sound,self:GetParent())
		self:PlayEffects()
	end
end
function modifier_gyroshaker_rocket_shock_lua:PlayEffects()
	self.particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(self.particle_cast, PATTACH_POINT_FOLLOW, self:GetParent())
	self.attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment("attach_totem")~=nil then self.attach = "attach_totem" end
	if self:GetParent()==self:GetCaster() then
		ParticleManager:SetParticleControlEnt(
			self.effect_cast,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			self.attach,
			Vector(0,0,0),
			true)
		self:AddParticle(self.effect_cast,false,false,-1,false,false)
	end
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast,1,Vector(self.radius, self.radius, self.radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end
function modifier_gyroshaker_rocket_shock_lua:DeclareFunctions()
	local funcs = {MODIFIER_PROPERTY_TOOLTIP,}
	return funcs
end
function modifier_gyroshaker_rocket_shock_lua:OnTooltip()
	return self.delay
end
