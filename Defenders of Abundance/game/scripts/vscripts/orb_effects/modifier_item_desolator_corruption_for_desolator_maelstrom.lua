if modifier_item_desolator_corruption_for_desolator_maelstrom == nil then
   modifier_item_desolator_corruption_for_desolator_maelstrom = class({})
end
function modifier_item_desolator_corruption_for_desolator_maelstrom:IsHidden()
   return false
end
function modifier_item_desolator_corruption_for_desolator_maelstrom:IsDebuff()
   return true
end
function modifier_item_desolator_corruption_for_desolator_maelstrom:IsPurgable()
   return true
end
function modifier_item_desolator_corruption_for_desolator_maelstrom:GetTexture()
   return "desolator_maelstrom_corruption"
end
function modifier_item_desolator_corruption_for_desolator_maelstrom:OnCreated()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_corruption_for_desolator_maelstrom:OnRefresh()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_corruption_for_desolator_maelstrom:DeclareFunctions()
   local funcs = {
      MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
   }
   return funcs
end
function modifier_item_desolator_corruption_for_desolator_maelstrom:GetModifierPhysicalArmorBonus()
   return self.corruption_armor
end