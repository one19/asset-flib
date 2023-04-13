extends Node

@export var spiderScene: PackedScene
@export var arenaTimeManager: Node

@onready var spawnTimer = $Timer

var baseSpawnTime = 0
var spawnRadius = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	arenaTimeManager.arenaDifficultyUpdated.connect(onUpdatedDifficulty)

	# set the spawn radius to juuuuust over the diagonal of the viewport
	spawnRadius = Vector2(get_tree().get_root().get_visible_rect().size).length() / 2 + 15
	spawnTimer.timeout.connect(spawnEnemy)
	baseSpawnTime = spawnTimer.wait_time


func spawnEnemy():
	spawnTimer.start() # restart the timer on spawn

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


func onUpdatedDifficulty(difficulty: int):
	# we don't restart the timer on change, because it could cause a longer wait
	# very slow timer growth, nearly a minute for 0.1 second reduction
	var timeReduction = (0.1 / 12) * difficulty

	# clamp minimum spawn time to 5 a second, prettttty hard stuff
	spawnTimer.wait_time = max(baseSpawnTime - timeReduction, 0.2)
	print(spawnTimer.wait_time)
