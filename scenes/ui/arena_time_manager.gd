extends Node

# no longer do we need to do a lookup in the function call
# it's bound to a var
@onready var timer = $Timer

func getTimeElapsed():
	return timer.wait_time - timer.time_left
