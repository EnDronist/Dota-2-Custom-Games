LinkLuaModifier("modifier_gyroshaker_rocket_shock_lua","modifiers/modifier_gyroshaker_rocket_shock_lua",LUA_MODIFIER_MOTION_NONE)
gyroshaker_rocket_shock_lua = class ({})
function gyroshaker_rocket_shock_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end
function gyroshaker_rocket_shock_lua:ProcsMagicStick()	return true end
function gyroshaker_rocket_shock_lua:GetCastAnimation()
	return nil
end
function gyroshaker_rocket_shock_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	--Талант
	if caster:FindAbilityByName("special_bonus_unique_gyroshaker_rocket_shock_duration"):GetLevel() > 0 then
		talent = caster:FindAbilityByName("special_bonus_unique_gyroshaker_rocket_shock_duration")
		duration = duration + talent:GetSpecialValueFor("duration_bonus")
	end
	--------
	caster:AddNewModifier(caster,self,"modifier_gyroshaker_rocket_shock_lua",{duration=duration})
end