extends Node

@export var spiderScene: PackedScene

var spawnRadius = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# set the spawn radius to juuuuust over the diagonal of the viewport
	spawnRadius = Vector2(get_tree().get_root().get_visible_rect().size).length() / 2 + 15
	$Timer.timeout.connect(spawnEnemy)

func spawnEnemy():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null:
		return

	# Just FYI TAU is 2*pi
	var randomDirection = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawnPosition = randomDirection * spawnRadius + player.global_position

	# create the enemy using its instantiate method
	var enemy = spiderScene.instantiate() as Node2D
	
	var entitiesLayer = get_tree().get_first_node_in_group("entitiesLayer")
	entitiesLayer.add_child(enemy)
	enemy.global_position = spawnPosition
