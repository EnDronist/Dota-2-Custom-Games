item_arcane_armlet = class({})
LinkLuaModifier("modifier_item_arcane_armlet_disassemble", "items/item_arcane_armlet_active", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_arcane_armlet", "items/item_arcane_armlet", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_arcane_armlet_pay", "items/item_arcane_armlet", LUA_MODIFIER_MOTION_NONE)
function item_arcane_armlet:IsDisassemblable() return false end
function item_arcane_armlet:GetIntrinsicModifierName()
	return "modifier_item_arcane_armlet"
end
--[[function item_arcane_armlet:IsDisassemblable()
	print(123)
	if self:GetPurchaser():HasModifier("modifier_item_arcane_armlet_disassemble") then return false
	else return true end
end]]
function item_arcane_armlet:OnSpellStart()
	self.caster = self:GetPurchaser()
	if not self.caster:HasModifier("modifier_item_arcane_armlet_disassemble") then
		self.caster:AddNewModifier(self.caster, self, "modifier_item_arcane_armlet_disassemble", {duration = -1})
	end
	EmitSoundOnClient("DOTA_Item.Armlet.Activate",self.caster)
	swap_to_item(self,"item_arcane_armlet_active")
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
modifier_item_arcane_armlet = class({})
function modifier_item_arcane_armlet:IsHidden()		return true end
function modifier_item_arcane_armlet:IsDebuff()		return false end
function modifier_item_arcane_armlet:IsPurgable()	return false end
function modifier_item_arcane_armlet:GetEffectAttachType()
	return follow_origin
end
function modifier_item_arcane_armlet:OnCreated(kv)
	--Переменные
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.bonus_health_regen = self.ability:GetSpecialValueFor("bonus_health_regen")
	self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
	self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
	self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
	self.bonus_agility = self.ability:GetSpecialValueFor("bonus_agility")
	self.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
end
function modifier_item_arcane_armlet:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_arcane_armlet:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,}
	return funcs
end
function modifier_item_arcane_armlet:GetModifierConstantHealthRegen()
	return self.bonus_health_regen
end
function modifier_item_arcane_armlet:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_arcane_armlet:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_item_arcane_armlet:GetModifierBonusStats_Strength()
	return self.bonus_strength
end
function modifier_item_arcane_armlet:GetModifierBonusStats_Agility()
	return self.bonus_agility
end
function modifier_item_arcane_armlet:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end