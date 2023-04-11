extends CanvasLayer

signal upgradeSelected(upgrade: AbilityUpgrade)

@export var upgradeCardScene: PackedScene

@onready var cardContainer: HBoxContainer = $%UpgradeCardContainer


func _ready():
	get_tree().paused = true


func setAbilityUpgrades(upgrades: Array[AbilityUpgrade]):
#	print(cardContainer)
	for upgrade in upgrades:
		var cardInstance = upgradeCardScene.instantiate() as UpgradeCard
		cardContainer.add_child(cardInstance)
		cardInstance.setAbilityUpgrade(upgrade)

		cardInstance.selected.connect(onUpgradeSelected.bind(upgrade))


func onUpgradeSelected(upgrade: AbilityUpgrade):
	upgradeSelected.emit(upgrade)
	get_tree().paused = false
	queue_free()
