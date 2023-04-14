extends Node

const ABILITIES_TO_CHOOSE = 2

@export var upgradePool: Array[AbilityUpgrade]
@export var expManager: Node
@export var upgradeScreenScene: PackedScene

var currentUpgrades = {}


func _ready():
	expManager.levelUp.connect(onLevelUp)


func getUpgrades():
	var chosenUpgrades: Array[AbilityUpgrade] = []
	var filteredUpgrades = upgradePool.duplicate()

	for i in ABILITIES_TO_CHOOSE:
		if filteredUpgrades.is_empty():
			break

		var chosenUpgrade = filteredUpgrades.pick_random()

		filteredUpgrades = filteredUpgrades.filter(func (upgrade: AbilityUpgrade): return upgrade.id != chosenUpgrade.id)
		chosenUpgrades.append(chosenUpgrade)

	chosenUpgrades.sort_custom(func (a: AbilityUpgrade, b: AbilityUpgrade): return a.id < b.id)
	return chosenUpgrades


func onLevelUp(_currentLevel: int):
	var selectableUpgrades = getUpgrades()

	if selectableUpgrades.is_empty():
		return

	var upgradeScreen = upgradeScreenScene.instantiate()
	add_child(upgradeScreen)
	upgradeScreen.setAbilityUpgrades(selectableUpgrades)

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

	if upgrade.maxQuantity > 0:
		var currentQuantity = currentUpgrades[upgrade.id].quantity
		if currentQuantity == upgrade.maxQuantity:
			upgradePool = upgradePool.filter(func (poolItem): return poolItem.id != upgrade.id)

	GameEvents.emitAbilityUpgraded(upgrade, currentUpgrades)
