extends Node2D


const SMALL_EXP_VALUE = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(enteredEXPArea)

func enteredEXPArea(_playerArea: Area2D):
	GameEvents.emitExperienceCollected(SMALL_EXP_VALUE)
	queue_free()
