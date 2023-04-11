extends Node

@export var endScreen: PackedScene

func _ready():
	$%Player.health.died.connect(onPlayerDeath)


func onPlayerDeath():
	var endScreenScene = endScreen.instantiate()
	endScreenScene.setDefeat()
	add_child(endScreenScene)
