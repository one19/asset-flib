extends Node
class_name Health

signal died
signal healthChanged(healthPercent: float)

@export var maxHealth: float = 10
var currentHealth

func _ready():
	currentHealth = maxHealth

func takeDamage(damage: float):
	currentHealth = max(currentHealth - damage, 0)
	healthChanged.emit(getPercent()) # must add on healing method too.
	
	# something in our death handling is mutating
	# this deferral waits for death until the spider animation is idle
	Callable(checkIfDead).call_deferred()


func getPercent():
	return min(currentHealth / maxHealth, 1)


func checkIfDead():
	if currentHealth == 0:
		died.emit()
		owner.queue_free()
