extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOOTHING = 15

@onready var damageTimer = $DamageIntervalTimer
@onready var healthBar = $HealthBar
@onready var health = $Health

var numberOfCollidingBodies = 0


func _ready():
	$CollisionArea2D.body_entered.connect(onEnemyEntered)
	$CollisionArea2D.body_exited.connect(onEnemyExited)
	damageTimer.timeout.connect(handleContinuousDamage)
	health.healthChanged.connect(onHealthChanged)
	healthBar.value = health.getPercent() # this is meh, but children are already ready
# if they weren't we couldn't instantiate the parent, so there'd be nothing to listen to
# data only flows after everything is made. This is an acceptable solution for dynamic health


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


func handleContinuousDamage():
	if numberOfCollidingBodies == 0 || !damageTimer.is_stopped():
		return

	health.takeDamage(1)
	damageTimer.start()
	print("health ", health.currentHealth)


func onEnemyEntered(_enemyArea: Node2D):
	numberOfCollidingBodies += 1
	handleContinuousDamage()

func onEnemyExited(_enemyArea: Node2D):
	numberOfCollidingBodies -= 1

func onHealthChanged(healthPercent: float):
	healthBar.value = healthPercent
