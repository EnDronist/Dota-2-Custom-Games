modifier_gyroshaker_missile_totem_datadriven_thinker = class({})
function modifier_gyroshaker_missile_totem_datadriven_thinker:IsHidden() return true end
function modifier_gyroshaker_missile_totem_datadriven_thinker:IsPurgable() return false end
function modifier_gyroshaker_missile_totem_datadriven_thinker:OnCreated( kv ) end
function modifier_gyroshaker_missile_totem_datadriven_thinker:OnRefresh( kv ) end
function modifier_gyroshaker_missile_totem_datadriven_thinker:OnDestroy( kv )
	if IsServer() then
		local sound_cast = "Hero_EarthShaker.FissureDestroy"
		EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
		UTIL_Remove(self:GetParent())
	end
end