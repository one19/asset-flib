extends Node

@export var axeAbility: PackedScene

var damage = 50
var thrownAxes = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(throwTheAxe)


func throwTheAxe():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	var _enemies = get_tree().get_nodes_in_group("enemies")

	if player == null:
		return

	var foreground = get_tree().get_first_node_in_group("foregroundLayer") as Node2D
	var axe = axeAbility.instantiate() as Node2D
	
	foreground.add_child(axe)
	axe.global_position = player.global_position
	axe.hitboxComponent.damage = damage
	axe.parity = thrownAxes % 2

	thrownAxes += 1
	print(axe.parity, thrownAxes)
	
