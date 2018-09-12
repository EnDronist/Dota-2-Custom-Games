modifier_item_thasdorah_attack_range = class({})
function modifier_item_thasdorah_attack_range:IsPassive() 			return false end
function modifier_item_thasdorah_attack_range:IsHidden() 			return false end
function modifier_item_thasdorah_attack_range:GetTexture() 			return "thasdorah" end
function modifier_item_thasdorah_attack_range:RemoveOnDeath()		return true end
function modifier_item_thasdorah_attack_range:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,}
	return funcs
end
--function modifier_item_thasdorah_attack_range:GetAttributes()
--    return MODIFIER_ATTRIBUTE_MULTIPLE
--end
function modifier_item_thasdorah_attack_range:OnCreated(params)
	self.per_time = self:GetAbility():GetSpecialValueFor("bonus_attack_range_per_time")
	self.need_time = self:GetAbility():GetSpecialValueFor("bonus_attack_range_time")
	self:OnIntervalThink()
	self:StartIntervalThink(1.0)
end
function modifier_item_thasdorah_attack_range:OnIntervalThink(params)
	self.bonus_attack_range = self.per_time*math.floor(GameRules:GetGameTime()/self.need_time)
end
function modifier_item_thasdorah_attack_range:GetModifierAttackRangeBonus()
	return self.bonus_attack_range
end