extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(enteredEXPArea)

func enteredEXPArea(_playerArea: Area2D):
	print("yo you got jelly in my jam")
	queue_free()
