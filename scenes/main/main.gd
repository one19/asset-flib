extends Node

@export var endScreen: PackedScene

func _ready():
	$%Player.health.died.connect(onPlayerDeath)


func onPlayerDeath():
	var endScreenScene = endScreen.instantiate()
	endScreenScene.setDefeat() # if this begins failing, put it after adding child
	add_child(endScreenScene)
