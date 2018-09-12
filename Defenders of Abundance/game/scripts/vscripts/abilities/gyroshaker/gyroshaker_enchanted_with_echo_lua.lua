gyroshaker_enchanted_with_echo_lua = class({})
LinkLuaModifier("modifier_gyroshaker_enchanted_with_echo_lua","modifiers/modifier_gyroshaker_enchanted_with_echo_lua",LUA_MODIFIER_MOTION_NONE )
--LinkLuaModifier( "modifier_earthshaker_enchant_totem_lua_movement", "lua_abilities/earthshaker_enchant_totem_lua/modifier_earthshaker_enchant_totem_lua_movement", LUA_MODIFIER_MOTION_NONE )
function gyroshaker_enchanted_with_echo_lua:OnSpellStart()
	self.caster = self:GetCaster()
	--local target = self:GetCursorTarget()
	--local point = self:GetCursorPosition()
	local duration = self:GetDuration()
	self.caster:AddNewModifier(self.caster,self,"modifier_gyroshaker_enchanted_with_echo_lua",{duration = duration})
	local sound_cast = "Hero_EarthShaker.Totem"
	EmitSoundOn(sound_cast, self.caster)
end
function gyroshaker_enchanted_with_echo_lua:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_2
end
function gyroshaker_enchanted_with_echo_lua:OnProjectileHit_ExtraData(target,location,extraData)
	local damage_perc = self:GetSpecialValueFor("echo_slam_echo_damage_percentage")
	print(damage_perc)
	--Талант
	if self.caster:FindAbilityByName("special_bonus_unique_gyroshaker_enchanted_with_echo_damage_percentage"):GetLevel() > 0 then
			talent = self.caster:FindAbilityByName("special_bonus_unique_gyroshaker_enchanted_with_echo_damage_percentage")
			damage_perc = damage_perc + talent:GetSpecialValueFor("value")
	end
	--------
	print(damage_perc)
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = extraData.hit_damage*(damage_perc/100),
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self,}
	ApplyDamage(damageTable)
end