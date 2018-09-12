LinkLuaModifier("modifier_item_thasdorah_speed_aura","modifiers/modifier_item_thasdorah_speed_aura",LUA_MODIFIER_MOTION_NONE)
modifier_item_thasdorah_speed = class({})
function modifier_item_thasdorah_speed:IsPassive() 				return false end
function modifier_item_thasdorah_speed:IsHidden() 				return true end
function modifier_item_thasdorah_speed:IsDebuff()				return false end
function modifier_item_thasdorah_speed:RemoveOnDeath()			return true end
function modifier_item_thasdorah_speed:IsAura() 				return true end
function modifier_item_thasdorah_speed:IsAuraActiveOnDeath()	return false end
function modifier_item_thasdorah_speed:GetAuraRadius()			return self.radius end
function modifier_item_thasdorah_speed:GetAuraSearchTeam()		return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_item_thasdorah_speed:GetAuraSearchType()		return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_thasdorah_speed:GetAuraSearchFlags()		return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_item_thasdorah_speed:GetModifierAura()		return "modifier_item_thasdorah_speed_aura" end
function modifier_item_thasdorah_speed:OnCreated(params)
	self.radius = self:GetAbility():GetSpecialValueFor("aura_radius")
end