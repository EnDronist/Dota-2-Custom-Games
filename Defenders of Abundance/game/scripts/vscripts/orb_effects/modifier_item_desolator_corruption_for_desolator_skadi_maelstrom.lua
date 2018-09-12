if modifier_item_desolator_corruption_for_desolator_skadi_maelstrom == nil then
   modifier_item_desolator_corruption_for_desolator_skadi_maelstrom = class({})
end
function modifier_item_desolator_corruption_for_desolator_skadi_maelstrom:IsHidden()
   return false
end
function modifier_item_desolator_corruption_for_desolator_skadi_maelstrom:IsDebuff()
   return true
end
function modifier_item_desolator_corruption_for_desolator_skadi_maelstrom:IsPurgable()
   return true
end
function modifier_item_desolator_corruption_for_desolator_skadi_maelstrom:GetTexture()
   return "desolator_skadi_maelstrom_corruption"
end
function modifier_item_desolator_corruption_for_desolator_skadi_maelstrom:OnCreated()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_corruption_for_desolator_skadi_maelstrom:OnRefresh()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_corruption_for_desolator_skadi_maelstrom:DeclareFunctions()
   local funcs = {
      MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
   }
   return funcs
end
function modifier_item_desolator_corruption_for_desolator_skadi_maelstrom:GetModifierPhysicalArmorBonus()
   return self.corruption_armor
end