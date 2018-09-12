if modifier_item_desolator_maelstrom_corruption == nil then
   modifier_item_desolator_maelstrom_corruption = class({})
end
function modifier_item_desolator_maelstrom_corruption:IsHidden()
   return false
end
function modifier_item_desolator_maelstrom_corruption:IsDebuff()
   return true
end
function modifier_item_desolator_maelstrom_corruption:IsPurgable()
   return true
end
function modifier_item_desolator_maelstrom_corruption:GetTexture()
   return "desolator_maelstrom_corruption"
end
function modifier_item_desolator_maelstrom_corruption:OnCreated()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_maelstrom_corruption:OnRefresh()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_maelstrom_corruption:DeclareFunctions()
   local funcs = {
      MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
   }
   return funcs
end
function modifier_item_desolator_maelstrom_corruption:GetModifierPhysicalArmorBonus()
   return self.corruption_armor
end