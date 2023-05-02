extends CharacterBody2D

@onready var movementHandler: VelocityManager = $Velocity
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var leapTimer: Timer = $LeapTimer

var isJumping = false
var isPrepping = false

func _ready():
	leapTimer.connect('timeout', doLeapAnimation)

func _process(_delta):
	if isJumping:
		movementHandler.leap()
	elif isPrepping:
		movementHandler.decelerate()
	else:
		movementHandler.accelerateToPlayer()
		movementHandler.rotateAlongDirection(self)

	movementHandler.moveBouncy(self)


func setJumping(jumping: bool):
	isJumping = jumping
	isPrepping = false

	if jumping == false:
		leapTimer.start(10)


func setPrepping(prepping: bool = true):
	isPrepping = prepping


func doLeapAnimation():
	leapTimer.stop()
	animationPlayer.play('leap')
