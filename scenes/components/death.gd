extends Node2D

@export var healthComponent: Node
@export var sprite: Sprite2D

func _ready():
	$GPUParticles2D.texture = sprite.texture
	healthComponent.died.connect(onDeath)


func onDeath():
	if owner == null || not owner is Node2D:
		return

	var spawnPosition = owner.global_position

	var entities = get_tree().get_first_node_in_group("entitiesLayer")
	get_parent().remove_child(self)

	entities.add_child(self)
	global_position = spawnPosition
	$AnimationPlayer.play("default")
	
	# TODO: fix issue where splat doesn't play every time
