extends CanvasLayer


func _ready():
	get_tree().paused = true
	$%RestartButton.pressed.connect(restart)
	$%QuitButton.pressed.connect(quit)


func setDefeat():
	$%EndTitleLabel.text = "Defeat"
	$%EndDescriptionLabel.text = "You lost!"


func restart():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func quit():
	get_tree().quit()
