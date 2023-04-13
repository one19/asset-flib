extends Node

const DIFFICULTY_INTERVAL = 5 # seconds

signal arenaDifficultyUpdated(arenaDifficulty: int)

@export var endScreen: PackedScene

# no longer do we need to do a lookup in the function call
# it's bound to a var
@onready var timer = $Timer


# this seems much more process-costly than setting a timer
var arenaDifficulty = 0


func _ready():
	timer.timeout.connect(outOfTime)


func _process(_delta):
	var nextTimeTarget = timer.wait_time - ((arenaDifficulty + 1) * DIFFICULTY_INTERVAL)
	if timer.time_left <= nextTimeTarget:
		arenaDifficulty += 1
		arenaDifficultyUpdated.emit(arenaDifficulty)


func getTimeElapsed():
	return timer.wait_time - timer.time_left


func outOfTime():
	var endScreenScene = endScreen.instantiate()
	add_child(endScreenScene)
