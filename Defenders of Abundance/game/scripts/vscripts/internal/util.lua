function IllusionPassiveRemover( keys )
	local target = keys.target
	local modifier = keys.modifier
	if target:IsIllusion() or not target:GetPlayerOwner() then
		target:RemoveModifierByName(modifier)
	end
end