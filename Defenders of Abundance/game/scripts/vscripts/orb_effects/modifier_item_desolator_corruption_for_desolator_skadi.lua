if modifier_item_desolator_corruption_for_desolator_skadi == nil then
   modifier_item_desolator_corruption_for_desolator_skadi = class({})
end
function modifier_item_desolator_corruption_for_desolator_skadi:IsHidden()
   return false
end
function modifier_item_desolator_corruption_for_desolator_skadi:IsDebuff()
   return true
end
function modifier_item_desolator_corruption_for_desolator_skadi:IsPurgable()
   return true
end
function modifier_item_desolator_corruption_for_desolator_skadi:GetTexture()
   return "desolator_skadi_corruption"
end
function modifier_item_desolator_corruption_for_desolator_skadi:OnCreated()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_corruption_for_desolator_skadi:OnRefresh()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_corruption_for_desolator_skadi:DeclareFunctions()
   local funcs = {
      MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
   }
   return funcs
end
function modifier_item_desolator_corruption_for_desolator_skadi:GetModifierPhysicalArmorBonus()
   return self.corruption_armor
end