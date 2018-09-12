if modifier_item_desolator_skadi_maelstrom_corruption == nil then
   modifier_item_desolator_skadi_maelstrom_corruption = class({})
end
function modifier_item_desolator_skadi_maelstrom_corruption:IsHidden()
   return true
end
function modifier_item_desolator_skadi_maelstrom_corruption:IsDebuff()
   return true
end
function modifier_item_desolator_skadi_maelstrom_corruption:IsPurgable()
   return true
end
function modifier_item_desolator_skadi_maelstrom_corruption:GetTexture()
   return "desolator_skadi_maelstrom_corruption"
end
function modifier_item_desolator_skadi_maelstrom_corruption:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end
function modifier_item_desolator_skadi_maelstrom_corruption:HeroEffectPriority()
   return 1
end
function modifier_item_desolator_skadi_maelstrom_corruption:OnCreated()
	self.cold_movement_speed = self:GetAbility():GetSpecialValueFor("skadi_cold_movement_speed")
	self.cold_attack_speed = self:GetAbility():GetSpecialValueFor("skadi_cold_attack_speed")
end
function modifier_item_desolator_skadi_maelstrom_corruption:OnRefresh()
	self.cold_movement_speed = self:GetAbility():GetSpecialValueFor("skadi_cold_movement_speed")
	self.cold_attack_speed = self:GetAbility():GetSpecialValueFor("skadi_cold_attack_speed")
end
function modifier_item_desolator_skadi_maelstrom_corruption:GetAttributes()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function modifier_item_desolator_skadi_maelstrom_corruption:DeclareFunctions()
   local funcs = {
      MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
      MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
   }
   return funcs
end
function modifier_item_desolator_skadi_maelstrom_corruption:GetModifierMoveSpeedBonus_Percentage()
   return self.cold_movement_speed
end
function modifier_item_desolator_skadi_maelstrom_corruption:GetModifierAttackSpeedBonus_Constant()
   return self.cold_attack_speed
end