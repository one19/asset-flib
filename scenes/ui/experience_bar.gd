extends CanvasLayer

@export var expManager: Node
@onready var progressBar = $MarginContainer/ProgressBar


func _ready():
	progressBar.value = 0
	expManager.expUpdated.connect(onEXPUpdated)


func onEXPUpdated(currentExp: float, targetExp: float):
	progressBar.value = currentExp / targetExp
