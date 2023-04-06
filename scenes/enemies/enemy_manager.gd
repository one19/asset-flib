extends Node

@export var spiderScene: PackedScene

const HALF_SCREEN_WIDTH = 320
const SPAWN_RADIUS = HALF_SCREEN_WIDTH + 40

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(spawnEnemy)

func spawnEnemy():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null:
		return

	# Just FYI TAU is 2*pi
	var randomDirection = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawnPosition = randomDirection * SPAWN_RADIUS + player.global_position

	# create the enemy using its instantiate method
	var enemy = spiderScene.instantiate() as Node2D
	# pop it onto the parent node (main)
	get_parent().add_child(enemy)
	enemy.global_position = spawnPosition
