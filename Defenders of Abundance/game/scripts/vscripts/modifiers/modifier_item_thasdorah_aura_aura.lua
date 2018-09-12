modifier_item_thasdorah_aura_aura = class({})
function modifier_item_thasdorah_aura_aura:IsPassive() 		return false end
function modifier_item_thasdorah_aura_aura:IsHidden() 		return true end
function modifier_item_thasdorah_aura_aura:IsDebuff()		return false end
function modifier_item_thasdorah_aura_aura:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,}
	return funcs
end
function modifier_item_thasdorah_aura_aura:OnCreated(params)
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("aura_mana_regen")
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("aura_bonus_armor")
end
function modifier_item_thasdorah_aura_aura:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_item_thasdorah_aura_aura:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end