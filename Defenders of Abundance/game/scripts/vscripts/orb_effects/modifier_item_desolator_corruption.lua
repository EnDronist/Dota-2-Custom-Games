if modifier_item_desolator_corruption == nil then
   modifier_item_desolator_corruption = class({})
end
function modifier_item_desolator_corruption:IsHidden()
   return false
end
function modifier_item_desolator_corruption:IsDebuff()
   return true
end
function modifier_item_desolator_corruption:IsPurgable()
   return true
end
function modifier_item_desolator_corruption:GetTexture()
   return "desolator_corruption"
end
function modifier_item_desolator_corruption:OnCreated()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
	--if IsServer() then
	--	local a = {
	--		--"modifier_item_desolator_corruption",
	--		"modifier_item_skadi_corruption",
	--		"modifier_item_desolator_skadi_corruption",
	--		"modifier_item_desolator_corruption_for_desolator_skadi",
	--		"modifier_item_desolator_maelstrom_corruption",
	--		"modifier_item_skadi_maelstrom_corruption",
	--		"modifier_item_desolator_skadi_maelstrom_corruption",
	--		"modifier_item_desolator_corruption_for_desolator_skadi_maelstrom"
	--	}
	--	for i=1, 7, 1 do
	--	if self:GetCaster():HasModifier(a[i]) then
	--		self:GetCaster():RemoveModifierByName(a[i])
	--	end
	--end
end
function modifier_item_desolator_corruption:OnRefresh()
	self.corruption_armor = self:GetAbility():GetSpecialValueFor("desolator_corruption_armor")
end
function modifier_item_desolator_corruption:DeclareFunctions()
   local funcs = {
      MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
   }
   return funcs
end
function modifier_item_desolator_corruption:GetModifierPhysicalArmorBonus()
   return self.corruption_armor
end
--function modifier_item_desolator_corruption:Activate()
--	joint_cooperation:modifier_item_desolator_corruption()
--end