extends PanelContainer
class_name UpgradeCard

@onready var nameLabel: Label = $%NameLabel
@onready var descriptionLabel: Label = $%DescriptionLabel
# shorthand for $VBoxContainer/CHILD_COMPONENT 
# the Upgrade card parent nesting is implicit

func setAbilityUpgrade(upgrade: AbilityUpgrade):
	nameLabel.text = upgrade.name
	descriptionLabel.text = upgrade.description
