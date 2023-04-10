extends Node

# create the signals we emit here
signal expUpdated(currentExperience: float, targetExperience: float)
signal levelUp(newLevel: int)

const TARGET_GROWTH_MULT = 1.1

var currentExperience = 0
var targetExperience = 1
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
		levelUp.emit(currentLevel)
