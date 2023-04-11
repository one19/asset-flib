extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOOTHING = 15

@onready var damageTimer = $DamageIntervalTimer

var numberOfCollidingBodies = 0


func _ready():
	$CollisionArea2D.body_entered.connect(onEnemyEntered)
	$CollisionArea2D.body_exited.connect(onEnemyExited)
	damageTimer.timeout.connect(handleContinuousDamage)


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


func onEnemyEntered(enemyArea: Node2D):
	print(enemyArea)
	numberOfCollidingBodies += 1
	handleContinuousDamage()

func onEnemyExited(enemyArea: Node2D):
	print('exited', enemyArea)
	numberOfCollidingBodies -= 1


func handleContinuousDamage():
	print(numberOfCollidingBodies, !damageTimer.is_stopped())
	if numberOfCollidingBodies == 0 || !damageTimer.is_stopped():
		return

	$Health.takeDamage(1)
	damageTimer.start()
	print("health", $Health.currentHealth)
