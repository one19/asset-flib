extends Node2D

var currentExperience = 0


func _ready():
	GameEvents.experienceCollected.connect(incrementExperience)


func incrementExperience(addedExperience: float):
	currentExperience += addedExperience
	print(currentExperience)

