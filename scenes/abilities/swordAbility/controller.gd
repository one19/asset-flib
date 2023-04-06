extends Node

@export var swordAbility: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# get_node("Timer")
	$Timer.timeout.connect(onTimerTimeout)


func onTimerTimeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D

	if player == null:
		return

	var swordInstance = swordAbility.instantiate() as Node2D
	player.get_parent().add_child(swordInstance)
	swordInstance.global_position = player.global_position
