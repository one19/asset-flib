extends Node

signal expUpdated(currentExperience: float, targetExperience: float)

const TARGET_GROWTH_MULT = 1.1

var currentExperience = 0
var targetExperience = 5
var currentLevel = 1

func _ready():
	GameEvents.experienceCollected.connect(incrementExperience)


func incrementExperience(addedExperience: float):
	currentExperience = min(currentExperience + addedExperience, targetExperience)
	expUpdated.emit(currentExperience, targetExperience)

	if currentExperience == targetExperience:
		currentLevel += 1
		targetExperience *= TARGET_GROWTH_MULT
		currentExperience = 0
		expUpdated.emit(currentExperience, targetExperience)
