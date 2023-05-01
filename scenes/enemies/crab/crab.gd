extends CharacterBody2D

@onready var movementHandler = $Velocity

var isMoving = false

func _process(_delta):
	if isMoving:
		movementHandler.accelerateToPlayer()
	else:
		movementHandler.decelerate()

	movementHandler.move(self)

func setMoving(moving: bool):
	isMoving = moving
