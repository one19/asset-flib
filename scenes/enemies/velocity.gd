extends Node

@export var maxSpeed: int = 40
@export var acceleration: float = 5

var velocity = Vector2.ZERO


func accelerateToPlayer():
	var ownerNode2D = owner as Node2D
	if ownerNode2D == null:
		return

	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var direction = (player.global_position - ownerNode2D.global_position).normalized()
	accelerateInDirection(direction)


func accelerateInDirection(direction: Vector2):
	var desiredVelocity = direction * maxSpeed
	velocity = velocity.lerp(desiredVelocity, 1 - exp(-acceleration * get_process_delta_time()))


func move(characterBody: CharacterBody2D):
	characterBody.velocity = velocity
	characterBody.move_and_slide()
	velocity = characterBody.velocity
