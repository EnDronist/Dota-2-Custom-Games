LinkLuaModifier("modifier_item_thasdorah_aura_aura","modifiers/modifier_item_thasdorah_aura_aura",LUA_MODIFIER_MOTION_NONE)
modifier_item_thasdorah_aura = class({})
function modifier_item_thasdorah_aura:IsPassive() 		return false end
function modifier_item_thasdorah_aura:IsHidden() 		return true end
function modifier_item_thasdorah_aura:IsDebuff()		return false end
function modifier_item_thasdorah_aura:RemoveOnDeath()		return true end
function modifier_item_thasdorah_aura:IsAura() 				return true end
function modifier_item_thasdorah_aura:IsAuraActiveOnDeath()	return false end
function modifier_item_thasdorah_aura:GetAuraRadius()		return self.radius end
function modifier_item_thasdorah_aura:GetAuraSearchTeam()	return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_item_thasdorah_aura:GetAuraSearchType()	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_thasdorah_aura:GetAuraSearchFlags()	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_item_thasdorah_aura:GetModifierAura()		return "modifier_item_thasdorah_aura_aura" end
function modifier_item_thasdorah_aura:OnCreated(params)
	self.radius = self:GetAbility():GetSpecialValueFor("aura_radius")
end