extends Area2D
class_name Hurtbox

@export var healthComponent: Node


func _ready():
	area_entered.connect(hurtboxEntered)


func hurtboxEntered(otherArea: Area2D):
	if not otherArea is Hitbox:
		return

	if healthComponent == null:
		return

	var hitboxComponent = otherArea as Hitbox
	healthComponent.takeDamage(hitboxComponent.damage)
