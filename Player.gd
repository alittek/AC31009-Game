extends KinematicBody2D

var artifacts : int = 3
var speed = 100
var look_direction = "down"
onready var animation = $AnimationPlayer
onready var rayCast = $RayCast2D

func _physics_process(_delta):
	var movement = Vector2()
	movement.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	var velocity = movement.clamped(1) * speed 
	velocity = move_and_slide(velocity)

	if movement == Vector2.DOWN:
			look_direction = "down"
			animation.play(str("Walk_", look_direction ))

	elif movement == Vector2.UP:
			look_direction = "up"
			animation.play(str("Walk_", look_direction ))

	elif movement == Vector2.LEFT:
			look_direction = "left"
			animation.play(str("Walk_", look_direction ))

	elif movement == Vector2.RIGHT:
			look_direction = "right"
			animation.play(str("Walk_", look_direction ))

	elif movement == Vector2.ZERO:
		animation.stop(false)
		#animation.play(str("Idle_", look_direction ))

# TODO player picks up items
func get_artifact(amount):
	artifacts += amount

# player meets enemy
func lose_artifact(amount):
	artifacts -= amount
	if artifacts <= 0:
		die()
		
func die():
	#TODO back to menu?
	get_tree().reload_current_scene()
