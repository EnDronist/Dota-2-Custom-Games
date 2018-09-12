LinkLuaModifier("modifier_item_thasdorah_speed_buff","modifiers/modifier_item_thasdorah_speed_buff",LUA_MODIFIER_MOTION_NONE)
modifier_item_thasdorah_speed_aura = class({})
function modifier_item_thasdorah_speed_aura:IsPassive() 			return false end
function modifier_item_thasdorah_speed_aura:IsHidden() 				return true end
function modifier_item_thasdorah_speed_aura:IsDebuff()				return false end
function modifier_item_thasdorah_speed_aura:OnCreated(params)
	self:OnIntervalThink()
	self:StartIntervalThink(0.03)
end
function modifier_item_thasdorah_speed_aura:OnIntervalThink(params)
	if IsServer() then
		if not self:GetParent():HasModifier("modifier_item_thasdorah_speed_buff") then
			self:GetParent():AddNewModifier(self:GetParent(),self:GetAbility(),"modifier_item_thasdorah_speed_buff",{duration = -1})
		--else
			--Timers:CreateTimer(0.06,function()
			--	self:GetParent():AddNewModifier(self:GetParent(),self:GetAbility(),"modifier_item_thasdorah_speed_buff",{duration = -1})
			--end)
		end
	end
end