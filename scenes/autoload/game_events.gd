extends Node2D

signal experienceCollected(experienceValue: float)

func emitExperienceCollected(experienceValue: float):
	experienceCollected.emit(experienceValue)
