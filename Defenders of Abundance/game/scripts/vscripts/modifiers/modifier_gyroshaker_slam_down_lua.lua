modifier_gyroshaker_slam_down_lua = class({})
function modifier_gyroshaker_slam_down_lua:IsDebuff() return false end
function modifier_gyroshaker_slam_down_lua:OnCreated()
	self.caster = self:GetCaster()
	self.target = self:GetParent()
	self.ability = self:GetAbility()
	if self.ability.replacing == nil then self.ability.replacing = false end
	if self.ability.replacing == false then
		--print("Changed to gyroshaker_slam_down_lua_second")
		self:ReplaceAbilities("gyroshaker_slam_down_lua","gyroshaker_slam_down_lua_second","gyroshaker_slam_down_lua")
	end
	self:StartIntervalThink(0.03)
	self:OnIntervalThink()
end
function modifier_gyroshaker_slam_down_lua:OnDestroy()
	if self.ability.replacing == false then
		--print("Changed to gyroshaker_slam_down_lua")
		self:ReplaceAbilities("gyroshaker_slam_down_lua_second","gyroshaker_slam_down_lua","gyroshaker_slam_down_lua")
	end
end
function modifier_gyroshaker_slam_down_lua:OnIntervalThink()
	local second_ability
	for i=1,8 do
		if self.caster:GetAbilityByIndex(i-1):GetAbilityName() == "gyroshaker_slam_down_lua_second" then
			second_ability = self.caster:GetAbilityByIndex(i-1)
		end
	end
	local start_duration = self:GetAbility():GetSpecialValueFor("second_slam_max_delay")
	local self_duration = self:GetDuration()
	--print("Start Duration =",start_duration,"Self Duration =",self_duration)
	second_ability.remaining_time = self:GetRemainingTime() + (start_duration - self_duration)
	--print("Remaining Time =",second_ability.remaining_time)
end
function modifier_gyroshaker_slam_down_lua:ReplaceAbilities(main_ability_name,sub_ability_name,check_ability)
	self.caster:SwapAbilities(main_ability_name,sub_ability_name,false,true)
	if main_ability_name == check_ability then
		local level_ability = self.caster:FindAbilityByName(sub_ability_name)
		if level_ability:GetLevel() ~= 1 then level_ability:SetLevel(1) end
		--self.caster:FindAbilityByName(sub_ability_name):SetLevel(self.caster:FindAbilityByName(main_ability_name):GetLevel())
	end
end