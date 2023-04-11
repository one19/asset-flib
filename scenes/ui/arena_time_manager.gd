extends Node

@export var endScreen: PackedScene

# no longer do we need to do a lookup in the function call
# it's bound to a var
@onready var timer = $Timer


func _ready():
	timer.timeout.connect(outOfTime)


func getTimeElapsed():
	return timer.wait_time - timer.time_left


func outOfTime():
	var endScreenScene = endScreen.instantiate()
	add_child(endScreenScene)
