extends CharacterBody2D

@onready var movementHandler = $Velocity


func _process(_delta):
	movementHandler.accelerateToPlayer()
	movementHandler.moveBouncy(self)
