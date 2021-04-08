extends KinematicBody2D

var speed = 100
var look_direction = "down"
onready var animation = $AnimationPlayer

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
