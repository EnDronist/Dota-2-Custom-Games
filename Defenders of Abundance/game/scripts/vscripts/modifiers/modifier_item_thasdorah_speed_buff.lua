modifier_item_thasdorah_speed_buff = class({})
function modifier_item_thasdorah_speed_buff:IsPassive() 		return false end
function modifier_item_thasdorah_speed_buff:IsHidden() 			return false end
function modifier_item_thasdorah_speed_buff:GetTexture() 		return "thasdorah" end
function modifier_item_thasdorah_speed_buff:RemoveOnDeath()		return true end
function modifier_item_thasdorah_speed_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_TOOLTIP,}
	return funcs
end
function modifier_item_thasdorah_speed_buff:OnCreated()
	self.per_attack = self:GetAbility():GetSpecialValueFor("bonus_movespeed_per_attack")
	self.max_attacks = self:GetAbility():GetSpecialValueFor("bonus_movespeed_max_attacks")
	self.hited_stacks = self:GetAbility():GetSpecialValueFor("bonus_movespeed_hited_stacks")
	self.miss_time = self:GetAbility():GetSpecialValueFor("bonus_movespeed_miss_time")
		self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("aura_mana_regen")
		self.bonus_armor = self:GetAbility():GetSpecialValueFor("aura_bonus_armor")
		self.tooltips_number = 0
	self:SetStackCount(1)
	self:OnIntervalThink()
	self:StartIntervalThink(0.1)
end
function modifier_item_thasdorah_speed_buff:OnAttackLanded(params)
	if IsServer() then 
		if self:GetParent():HasModifier("modifier_item_thasdorah_speed_aura") then
			if params.attacker == self:GetParent() then
				if self:GetStackCount() < self.max_attacks then
				self:IncrementStackCount()
				end
			end
		end
		if params.target == self:GetParent() then
			if params.attacker:IsRealHero() then
				if self:GetStackCount() >= 6 then
					self:SetStackCount(self:GetStackCount() - self.hited_stacks)
				else
					self:SetStackCount(1)
				end
			end
		end
	end
end
function modifier_item_thasdorah_speed_buff:OnIntervalThink()
	if IsServer() then
		Timers:CreateTimer(0, function()
			if self:GetParent() ~= nil then
				if not self:GetParent():HasModifier("modifier_item_thasdorah_speed_aura") then
					if self:GetStackCount() > 0 then
						self:DecrementStackCount()
						self:StartIntervalThink(-1)
						if self:GetStackCount() == 0 then self:StartIntervalThink(-1) self:SetDuration(0.03,true) return nil end
						self.bonus_movespeed = self:GetStackCount()*self.per_attack
						return self.miss_time
					else self:StartIntervalThink(-1) self:SetDuration(0.1,true) return nil end
				else self:StartIntervalThink(0.1) return nil end
			else return nil end
		end)
	end
	self.bonus_movespeed = self:GetStackCount() * self.per_attack
end
function modifier_item_thasdorah_speed_buff:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_movespeed
end
function modifier_item_thasdorah_speed_buff:OnTooltip()
	if self.tooltips_number >= 3 then self.tooltips_number=0 end
	if self.tooltips_number == 0 then self.tooltips_number=self.tooltips_number+1 return self.bonus_armor end
	if self.tooltips_number == 1 then self.tooltips_number=self.tooltips_number+1 return self.bonus_mana_regen end
	if self.tooltips_number == 2 then self.tooltips_number=self.tooltips_number+1 return self:GetStackCount() end
end