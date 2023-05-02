extends Node
class_name VelocityManager

@export var maxSpeed: int = 40
@export var maxAngularVelocity: float = PI / 2 # 1/4 rot per second
@export var acceleration: float = 5.0
@export var angularAcceleration: float = 5.0

var velocity = Vector2.ZERO
var angularVelocity: float = 0.0


func accelerateToPlayer():
	var ownerNode2D = owner as Node2D
	if ownerNode2D == null:
		return

	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var direction = (player.global_position - ownerNode2D.global_position).normalized()
	accelerateInDirection(direction)


func accelerateInDirection(direction: Vector2, acc: float = acceleration):
	var desiredVelocity = direction * maxSpeed
	velocity = velocity.lerp(desiredVelocity, 1 - exp(-acc * get_process_delta_time()))


func rotateAlongDirection(characterBody: CharacterBody2D):
	var delta = get_process_delta_time()

	var desiredAngle = characterBody.velocity.angle()
	var angleDiff = fmod(desiredAngle - characterBody.rotation + PI, TAU) - PI

	if abs(angleDiff) < 0.002:
		return

	var targetAngularVelocity = maxAngularVelocity * sign(angleDiff)
	angularVelocity = lerp(angularVelocity, targetAngularVelocity, 1 - exp(-angularAcceleration * delta))
	characterBody.rotation += angularVelocity * delta
	


func decelerate():
	accelerateInDirection(Vector2.ZERO)


func leap():
	accelerateInDirection(velocity.normalized(), 200)


func move(characterBody: CharacterBody2D):
	characterBody.velocity = velocity
	characterBody.move_and_slide()
	velocity = characterBody.velocity


func moveBouncy(characterBody: CharacterBody2D):
	var collision = characterBody.move_and_collide(velocity * get_process_delta_time())
	if collision:
		characterBody.velocity = velocity.bounce(collision.get_normal())
	else:
		characterBody.velocity = velocity

	velocity = characterBody.velocity
