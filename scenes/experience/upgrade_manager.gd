extends Node

@export var upgradePool: Array[AbilityUpgrade]
@export var expManager: Node
@export var upgradeScreenScene: PackedScene

var currentUpgrades = {}


func _ready():
	expManager.levelUp.connect(onLevelUp)


func onLevelUp(_currentLevel: int):
	var chosenUpgrade = upgradePool.pick_random()

	if chosenUpgrade == null:
		return

	var upgradeScreen = upgradeScreenScene.instantiate()
	add_child(upgradeScreen)
	# holy wow it does type checking
	# and sucks at it, what a pain. time for more casting :grimacing:
	upgradeScreen.setAbilityUpgrades([chosenUpgrade] as Array[AbilityUpgrade])

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
