extends Node

signal experienceCollected(experienceValue: float)

func emitExperienceCollected(experienceValue: float):
	experienceCollected.emit(experienceValue)
