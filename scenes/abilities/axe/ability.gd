extends Node2D
class_name AxeAbility

# to throw randomly, which is less satisfying than alternating
#const ROTATION_ENDPOINTS = [2.0, -2.0]
#	tween.tween_method(spiralAxe, 0.0, ROTATION_ENDPOINTS.pick_random(), 3)

const ROTATION_DIRECTIONS = [-1, 1]
const MAX_RADIUS = 100

@onready var hitboxComponent = $Hitbox

# TODO: create custom _init() to handle parity more gracefully in the "_ready"
@export var parity: int = 0

var baseRotation = Vector2.RIGHT

func _ready():
	baseRotation = Vector2.RIGHT.rotated(randf_range(0, TAU))

	var tween = create_tween()
	tween.tween_method(spiralAxe, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)


func spiralAxe(rotations: float):
	# alternate throwing left and right based on parity
	var currentRadius = (rotations / 2) * MAX_RADIUS
	var leftOrRight = ROTATION_DIRECTIONS[parity]
	var currentDirection = baseRotation.rotated(rotations * TAU * leftOrRight)

	var rootVector = Vector2.ZERO
	var player = get_tree().get_first_node_in_group("player")

	if player != null:
		rootVector = player.global_position

	global_position = rootVector + (currentDirection * currentRadius)
#	rotation_degrees = rotations * 4 * 360
