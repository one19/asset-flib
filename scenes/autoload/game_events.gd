extends Node

signal experienceCollected(experienceValue: float)
signal abilityUpgraded(upgrade: AbilityUpgrade, currentUpgrades: Dictionary)


func emitExperienceCollected(experienceValue: float):
	experienceCollected.emit(experienceValue)


func emitAbilityUpgraded(upgrade: AbilityUpgrade, currentUpgrades: Dictionary):
	abilityUpgraded.emit(upgrade, currentUpgrades)
