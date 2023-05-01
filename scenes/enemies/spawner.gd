extends Node

@export var tarantulaScene: PackedScene
@export var spiderScene: PackedScene
@export var crabScene: PackedScene
@export var arenaTimeManager: Node

@onready var spawnTimer = $Timer

var baseSpawnTime = 0
var spawnRadius = 0

var enemyTable = WeightedTable.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	arenaTimeManager.arenaDifficultyUpdated.connect(onUpdatedDifficulty)
	enemyTable.addItem(spiderScene, 90)
	enemyTable.addItem(tarantulaScene, 5)
	enemyTable.addItem(crabScene, 5)

	# set the spawn radius to juuuuust over the diagonal of the viewport
	spawnRadius = Vector2(get_tree().get_root().get_visible_rect().size).length() / 2 + 15
	spawnTimer.timeout.connect(spawnEnemy)
	baseSpawnTime = spawnTimer.wait_time


func getSpawnPosition():
	var player = get_tree().get_first_node_in_group("player") as Node2D

	if player == null:
		return

	var spawnPosition = Vector2.ZERO
	var randomDirection = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	# check in all 4 cardinal directions, guaranteed to give us a value
	for i in 4:
			# Just FYI TAU is 2*pi
		spawnPosition = randomDirection * spawnRadius + player.global_position

		# handy dandy bitwise operator to get things like 20, which is 1 << 19
		# or 524288, which is alot more esoteric
		var queryParams = PhysicsRayQueryParameters2D.create(player.global_position, spawnPosition, 1 << 0)
		var collisionCheck = get_tree().root.world_2d.direct_space_state.intersect_ray(queryParams)

		if collisionCheck.is_empty():
			# early exits, no need to worry about no-returns
			# break and final return also possible, but unnecessary
			return spawnPosition
		else:
			randomDirection = randomDirection.rotated(deg_to_rad(90))


func spawnEnemy():
	spawnTimer.start() # restart the timer on spawn

	var enemyScene = enemyTable.pickItem()
	var enemy = enemyScene.instantiate() as Node2D
	
	var entitiesLayer = get_tree().get_first_node_in_group("entitiesLayer")

	entitiesLayer.add_child(enemy)
	enemy.global_position = getSpawnPosition()


func onUpdatedDifficulty(difficulty: int):
	print('difficulty updated', difficulty)
	# we don't restart the timer on change, because it could cause a longer wait
	# very slow timer growth, nearly a minute for 0.1 second reduction
	var timeReduction = (0.2 / 12) * difficulty

	# clamp minimum spawn time to 5 a second, prettttty hard stuff
	spawnTimer.wait_time = max(baseSpawnTime - timeReduction, 0.2)

	if difficulty == 8:
		enemyTable.updateWeight(tarantulaScene, 90)
		enemyTable.updateWeight(spiderScene, 5)
		enemyTable.updateWeight(crabScene, 5)

	# THE CRAB WAVE
	if difficulty >= 16 || difficulty < 24:
		spawnTimer.wait_time = 0.2
		enemyTable.updateWeight(crabScene, 90)
		enemyTable.updateWeight(spiderScene, 5)
		enemyTable.updateWeight(tarantulaScene, 5)
