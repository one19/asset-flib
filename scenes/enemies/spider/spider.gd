extends CharacterBody2D

const MAX_SPEED = 75

# Called when the node enters the scene tree for the first time.
func _ready():
	# get_node("area2D")
	$Area2D.area_entered.connect(onAreaEntered)


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


func onAreaEntered(_swordArea):
	queue_free()
