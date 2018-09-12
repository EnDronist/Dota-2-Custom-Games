modifier_gyroshaker_slam_down_lua_slowdown = class({})
function modifier_gyroshaker_slam_down_lua_slowdown:IsDebuff() 		return true end
function modifier_gyroshaker_slam_down_lua_slowdown:RemoveOnDeath()	return true end
function modifier_gyroshaker_slam_down_lua_slowdown:OnCreated()
	if self:GetAbility().ms~=nil then
		self.movespeed = -self:GetAbility().ms
	end
	--print("Movespeed: ",self.movespeed)
end
function modifier_gyroshaker_slam_down_lua_slowdown:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
	return funcs
end
function modifier_gyroshaker_slam_down_lua_slowdown:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end