extends CharacterBody2D

const MAX_SPEED = 75

@onready var healthComponent: Health = $HealthComponent


func _ready():
	global_position = Vector2.INF


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = getDirectionToPlayer()
	velocity = direction * MAX_SPEED
	move_and_slide()
	
	# can rotate to face the player, but it gets janky up close
#	rotation = direction.angle()


func getDirectionToPlayer():
	var playerNode = get_tree().get_first_node_in_group("player") as Node2D
	if playerNode != null:
		return (playerNode.global_position - global_position).normalized()
	return Vector2.ZERO
