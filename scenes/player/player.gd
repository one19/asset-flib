extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOOTHING = 15


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movementVector = getMovementVector()
	var direction = movementVector.normalized()

	var targetVelocity = direction * MAX_SPEED

	velocity = velocity.lerp(targetVelocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func getMovementVector():
	var xDirection = Input.get_action_strength("our-move-right") - Input.get_action_strength("our-move-left")
	var yDirection = Input.get_action_strength("our-move-down") - Input.get_action_strength("our-move-up")
	return Vector2(xDirection, yDirection)
