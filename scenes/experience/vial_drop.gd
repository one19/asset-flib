extends Node

@export_range(0, 1) var dropPercent: float = 0.9
@export var healthComponent: Health
@export var vialScene: PackedScene

func _ready():
	healthComponent.died.connect(onDeath)


func onDeath():
	if randf() > dropPercent:
		return

	if vialScene == null:
		return

	if not owner is Node2D:
		return

	var spawnPosition = (owner as Node2D).global_position
	var newVial = vialScene.instantiate() as Node2D

	var entitiesLayer = get_tree().get_first_node_in_group("entitiesLayer")
	entitiesLayer.add_child(newVial)
#	owner.get_parent().add_child(newVial)
	newVial.global_position = spawnPosition
