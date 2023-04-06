extends Node

@export var swordAbility: PackedScene

@export var maxRange: float

# Called when the node enters the scene tree for the first time.
func _ready():
	# get_node("Timer")
	$Timer.timeout.connect(onTimerTimeout)


func onTimerTimeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	var enemies = get_tree().get_nodes_in_group("enemies")
	
	if player == null:
		return
	
	enemies = enemies.filter(func (enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(maxRange, 2)
	)

	if enemies.size() == 0:
		return
		
	enemies.sort_custom(func (a: Node2D, b: Node2D):
		var aDistance = a.global_position.distance_squared_to(player.global_position)
		var bDistance = b.global_position.distance_squared_to(player.global_position)
		return aDistance < bDistance
	)

	var swordInstance = swordAbility.instantiate() as Node2D
	player.get_parent().add_child(swordInstance)
	swordInstance.global_position = enemies[0].global_position
