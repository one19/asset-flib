extends PanelContainer
class_name UpgradeCard

signal selected

@onready var nameLabel: Label = $%NameLabel
@onready var descriptionLabel: Label = $%DescriptionLabel
# shorthand for $VBoxContainer/CHILD_COMPONENT 
# the Upgrade card parent nesting is implicit


func _ready():
	gui_input.connect(onGuiInput)


func setAbilityUpgrade(upgrade: AbilityUpgrade):
	nameLabel.text = upgrade.name
	descriptionLabel.text = upgrade.description


func onGuiInput(event: InputEvent):
	print(event)
	if event.is_action_pressed("left-click"):
		selected.emit()
