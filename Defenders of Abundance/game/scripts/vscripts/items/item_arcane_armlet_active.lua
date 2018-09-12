item_arcane_armlet_active = class({})
LinkLuaModifier("modifier_item_arcane_armlet_active", "items/item_arcane_armlet_active", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_arcane_armlet_active_tick", "items/item_arcane_armlet_active", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_arcane_armlet_active_pay", "items/item_arcane_armlet_active", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_arcane_armlet_disassemble", "items/item_arcane_armlet_active", LUA_MODIFIER_MOTION_NONE)
function item_arcane_armlet_active:IsDisassemblable() return false end
function item_arcane_armlet_active:GetIntrinsicModifierName()
	return "modifier_item_arcane_armlet_active"
end
function item_arcane_armlet_active:OnSpellStart()
	self.caster = self:GetPurchaser()
	if not self.caster:HasModifier("modifier_item_arcane_armlet_disassemble") then
		self.caster:AddNewModifier(self.caster, self, "modifier_item_arcane_armlet_disassemble", {duration = -1})
	end
	EmitSoundOnClient("DOTA_Item.Armlet.DeActivate",self.caster)
	swap_to_item(self,"item_arcane_armlet")
end
function swap_to_item(self,ItemName)
	for i=0, 5, 1 do
		local current_item = self.caster:GetItemInSlot(i)
		if current_item == nil then
			self.caster:AddItem(CreateItem("item_dummy_datadriven", self.caster, self.caster))
		end
	end
	self.caster:RemoveItem(self)
	local newitem = self.caster:AddItem(CreateItem(ItemName, self.caster, self.caster))
	newitem:SetPurchaseTime(0.0)
	for i=0, 5, 1 do
		local current_item = self.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_datadriven" then
				self.caster:RemoveItem(current_item)
			end
		end
	end
end

--Пассивный модификатор предмета
modifier_item_arcane_armlet_active = class({})
LinkLuaModifier("modifier_item_arcane_armlet_active_tick", "items/item_arcane_armlet_active", LUA_MODIFIER_MOTION_NONE)
function modifier_item_arcane_armlet_active:IsHidden()		return false end
function modifier_item_arcane_armlet_active:IsDebuff()		return false end
function modifier_item_arcane_armlet_active:IsPurgable()	return false end
function modifier_item_arcane_armlet_active:GetTexture()	return "arcane_armlet_active" end
function modifier_item_arcane_armlet_active:GetEffectName()
	return "particles/items_fx/arcane_armlet.vpcf"
end
function modifier_item_arcane_armlet_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_arcane_armlet_active:OnCreated(kv)
	--Переменные
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.bonus_health_regen = self.ability:GetSpecialValueFor("bonus_health_regen")
	self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
	self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
	self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
	self.bonus_agility = self.ability:GetSpecialValueFor("bonus_agility")
	self.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
	self.pay_intellect_duration = self.ability:GetSpecialValueFor("pay_intellect_duration")
	self.unholy_mana_drain_interval = self.ability:GetSpecialValueFor("unholy_mana_drain_interval")
	self.unholy_mana_drain_per_second = self.ability:GetSpecialValueFor("unholy_mana_drain_per_second")
	self.unholy_mana_drain_percent_per_second = self.ability:GetSpecialValueFor("unholy_mana_drain_percent_per_second")
	self.unholy_bonus_intellect = self.ability:GetSpecialValueFor("unholy_bonus_intellect")
	self.unholy_bonus_cast_radius = self.ability:GetSpecialValueFor("unholy_bonus_cast_radius")
	self.unholy_ticks_to_full_effect = self.ability:GetSpecialValueFor("unholy_ticks_to_full_effect")
	self.lvls_for_bonus_ticks = self.ability:GetSpecialValueFor("lvls_for_bonus_ticks")
	self.bonus_ticks_bonus = self.ability:GetSpecialValueFor("bonus_ticks_bonus")
	self.lvl_bonus = math.floor(self.caster:GetLevel()/self.lvls_for_bonus_ticks)
	self.tooltips_number = 0
	--Действия
	self.caster:AddNewModifier(self.caster, self.ability, "modifier_item_arcane_armlet_active_pay",{duration=self.pay_intellect_duration})
	self:StartIntervalThink(self.unholy_mana_drain_interval)
end
function modifier_item_arcane_armlet_active:OnIntervalThink(kv)
	--Снижение маны
	local new_mp = self.caster:GetMana() - (self.unholy_mana_drain_per_second * self.unholy_mana_drain_interval) - (self.caster:GetMaxMana() * self.unholy_mana_drain_percent_per_second * self.unholy_mana_drain_interval / 100)
	if new_mp < 0 then new_mp = 0 end
	self.caster:SetMana(new_mp)
	--Увеличение интеллекта
	if self.ability.ArmletTicksActive == nil or self.ability.ArmletTicksActive < self.unholy_ticks_to_full_effect + (self.bonus_ticks_bonus * self.lvl_bonus) then
		self.caster:AddNewModifier(self.caster, self.ability, "modifier_item_arcane_armlet_active_tick",{duration = -1})
		if self.ability.ArmletTicksActive == nil then
			self.ability.ArmletTicksActive = 1
		else
			self.ability.ArmletTicksActive = self.ability.ArmletTicksActive + 1
		end
		local currentMP = self.caster:GetMana()
		local maxMP = self.caster:GetMaxMana()
		local mana_bonus_interval_ratio = (self.unholy_bonus_intellect / self.unholy_ticks_to_full_effect) * 12
		local amount_to_restore = ((currentMP + mana_bonus_interval_ratio) / (maxMP + mana_bonus_interval_ratio)) * maxMP - currentMP
		self.caster:SetMana(currentMP + amount_to_restore)
	end
end
function modifier_item_arcane_armlet_active:OnDestroy()
	if self.ability.ArmletTicksActive ~= nil then
		for i=1,self.ability.ArmletTicksActive,1 do
			self.caster:RemoveModifierByName("modifier_item_arcane_armlet_active_tick")
		end
		for i=1,self.ability.ArmletTicksActive,1 do
			local currentMP = self.caster:GetMana()
			local maxMP = self.caster:GetMaxMana()
			local mana_bonus_interval_ratio = (self.unholy_bonus_intellect / self.unholy_ticks_to_full_effect) * 12
			local amount_to_restore = ((currentMP + mana_bonus_interval_ratio) / (maxMP + mana_bonus_interval_ratio)) * maxMP - currentMP
			local new_mp = currentMP - amount_to_restore
			if new_mp < 0 then
				new_mp = 0
			end
			self.caster:SetMana(new_mp)
		end
		self.ability.ArmletTicksActive = nil
	end
end
function modifier_item_arcane_armlet_active:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_arcane_armlet_active:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,}
	return funcs
end
function modifier_item_arcane_armlet_active:GetModifierConstantHealthRegen()
	return self.bonus_health_regen
end
function modifier_item_arcane_armlet_active:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_arcane_armlet_active:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_item_arcane_armlet_active:GetModifierBonusStats_Strength()
	return self.bonus_strength
end
function modifier_item_arcane_armlet_active:GetModifierBonusStats_Agility()
	return self.bonus_agility
end
function modifier_item_arcane_armlet_active:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end
function modifier_item_arcane_armlet_active:OnTooltip(kv)
	--(f)Бонусный интеллект для описания
	self.tooltip1 = self.unholy_bonus_intellect + self.unholy_bonus_intellect * self.bonus_ticks_bonus * self.lvl_bonus / self.unholy_ticks_to_full_effect
	--(d)Бонусная дальность использования способностей для описания
	self.tooltip2 = self.unholy_bonus_cast_radius + self.unholy_bonus_cast_radius * self.bonus_ticks_bonus * self.lvl_bonus / self.unholy_ticks_to_full_effect
	--(d)Снижение маны в секунду для описания
	self.tooltip3 = self.unholy_mana_drain_per_second + (self.unholy_mana_drain_percent_per_second * self.caster:GetMaxMana() / 100)
	if self.tooltips_number >= 3 then self.tooltips_number=0 end
	if self.tooltips_number == 0 then self.tooltips_number=self.tooltips_number+1 return self.tooltip1 end
	if self.tooltips_number == 1 then self.tooltips_number=self.tooltips_number+1 return self.tooltip2 end
	if self.tooltips_number == 2 then self.tooltips_number=self.tooltips_number+1 return self.tooltip3 end
end

--Модификатор дополнительного интеллекта и дальности применения спопобностей
modifier_item_arcane_armlet_active_tick = class({})
function modifier_item_arcane_armlet_active_tick:IsHidden() return true end
function modifier_item_arcane_armlet_active_tick:OnCreated(kv)
	self.intellect = 	self:GetAbility():GetSpecialValueFor("unholy_bonus_intellect")
	self.cast_range = 	self:GetAbility():GetSpecialValueFor("unholy_bonus_cast_radius")
	self.ticks = 		self:GetAbility():GetSpecialValueFor("unholy_ticks_to_full_effect") 
end
function modifier_item_arcane_armlet_active_tick:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,}
	return funcs
end
function modifier_item_arcane_armlet_active_tick:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_arcane_armlet_active_tick:GetModifierBonusStats_Intellect()
	return self.intellect/self.ticks
end
function modifier_item_arcane_armlet_active_tick:GetModifierCastRangeBonusStacking()
	return self.cast_range/self.ticks
end

--Модификатор проверки на использованность предмета
modifier_item_arcane_armlet_disassemble = class({})
function modifier_item_arcane_armlet_disassemble:IsHidden() return true end
function modifier_item_arcane_armlet_disassemble:IsPurgable() return false end

--Модификатор штрафа интеллектом
modifier_item_arcane_armlet_active_pay = class({})
function modifier_item_arcane_armlet_active_pay:IsHidden() return true end
function modifier_item_arcane_armlet_active_pay:GetTexture()	return "arcane_armlet" end
function modifier_item_arcane_armlet_active_pay:OnCreated()
	self.intellect = self:GetAbility():GetSpecialValueFor("pay_intellect")
end
function modifier_item_arcane_armlet_active_pay:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_arcane_armlet_active_pay:DeclareFunctions()
	local funcs = {MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,}
	return funcs
end
function modifier_item_arcane_armlet_active_pay:GetModifierBonusStats_Intellect()
	return self.intellect
end