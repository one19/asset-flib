extends Node

@export var upgradePool: Array[AbilityUpgrade]
@export var expManager: Node
@export var upgradeScreenScene: PackedScene

var currentUpgrades = {}


func _ready():
	expManager.levelUp.connect(onLevelUp)


func getUpgrades():
	var chosenUpgrades: Array[AbilityUpgrade] = []
	var filteredUpgrades = upgradePool.duplicate()
	for i in 2:
		var chosenUpgrade = filteredUpgrades.pick_random()
		filteredUpgrades = filteredUpgrades.filter(func (upgrade: AbilityUpgrade): return upgrade.id != chosenUpgrade.id)

		chosenUpgrades.append(chosenUpgrade)

	chosenUpgrades.sort_custom(func (a: AbilityUpgrade, b: AbilityUpgrade): return a.id < b.id)
	return chosenUpgrades


func onLevelUp(_currentLevel: int):
	var upgradeScreen = upgradeScreenScene.instantiate()
	add_child(upgradeScreen)
	# holy wow it does type checking
	# and sucks at it, what a pain. time for more casting :grimacing:
	upgradeScreen.setAbilityUpgrades(getUpgrades())

	upgradeScreen.upgradeSelected.connect(applyUpgrade)


func applyUpgrade(upgrade: AbilityUpgrade):
	var hasUpgrade = currentUpgrades.has(upgrade.id)
	if !hasUpgrade:
		currentUpgrades[upgrade.id] = {
			"upgrade": upgrade,
			"quantity": 1
		}
	else:
		currentUpgrades[upgrade.id].quantity += 1

	GameEvents.emitAbilityUpgraded(upgrade, currentUpgrades)
