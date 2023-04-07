extends CanvasLayer

@export var arenaTimeManager: Node
# the long form of accessing this thing
#@onready var label = $MarginContainer/Label

# the brittle named way of accessing this thing
@onready var label = $%Label

func _process(_delta):
	var timeElapsed = arenaTimeManager.getTimeElapsed()
#	label.text = str(floor(timeElapsed))
	label.text = formatSeconds(timeElapsed)

func formatSeconds(seconds: float):
	var minutes = floor(seconds/60)
	var remainingSeconds = seconds - minutes * 60
#	return str(minutes) + ":" + str(floor(remainingSeconds))
	return str(minutes) + ":" + ("%02d" % floor(remainingSeconds))
