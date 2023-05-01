extends Node

const REPEAT_TIME = 300 # ms

var rightRelease = 0
var leftRelease = 0
var downRelease = 0
var upRelease = 0

func _input(_event):
	var now = Time.get_ticks_msec()

	# step 1, store release time of the last button un-pressed
	if Input.is_action_just_released("our-move-right"):
		rightRelease = now
	if Input.is_action_just_released("our-move-left"):
		leftRelease = now
	if Input.is_action_just_released("our-move-down"):
		downRelease = now
	if Input.is_action_just_released("our-move-up"):
		upRelease = now

	# step 2, if action just pressed, check for firing teleport
	if Input.is_action_just_pressed("our-move-right") && now - rightRelease < REPEAT_TIME:
		teleportPlayer()
	if Input.is_action_just_pressed("our-move-left") && now - leftRelease < REPEAT_TIME:
		teleportPlayer()
	if Input.is_action_just_pressed("our-move-down") && now - downRelease < REPEAT_TIME:
		teleportPlayer()
	if Input.is_action_just_pressed("our-move-up") && now - upRelease < REPEAT_TIME:
		teleportPlayer()


func teleportPlayer():
	var player = get_tree().get_first_node_in_group("player")

	if player == null:
		return
	
	var xDirection = Input.get_action_strength("our-move-right") - Input.get_action_strength("our-move-left")
	var yDirection = Input.get_action_strength("our-move-down") - Input.get_action_strength("our-move-up")
	player.global_position = player.global_position + Vector2(xDirection, yDirection).normalized() * 50
