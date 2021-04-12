extends KinematicBody2D

var curHp : int = 5
var maxHp : int = 5

var moveSpeed : int = 30
var xpToGive : int = 30

var damage : int = 1
var attackRate : float = 1.0
var attackDist : int = 80
var chaseDist : int = 400

onready var timer = $Timer
onready var target = get_tree().root.get_node("WorldMap/Player")

func _physics_process (delta):
	var vel : Vector2
	var dist = position.distance_to(target.position)
	if dist < chaseDist:
		vel = (target.position - position).normalized()
		print(vel)
		move_and_slide(vel * moveSpeed)
		
	animate_NPC(vel)

func get_animation_direction(direction: Vector2):
	var norm_direction = direction.normalized()
	if norm_direction.y >= 0.707:
		return "down"
	elif norm_direction.y <= -0.707:
		return "up"
	elif norm_direction.x <= -0.707:
		return "left"
	elif norm_direction.x >= 0.707:
		return "right"
	return "down"

func animate_NPC(direction: Vector2):
	if direction != Vector2.ZERO:
		var last_direction = direction

		# Choose walk animation based on movement direction
		#var animation = get_animation_direction(last_direction) + "_walk"
		var animation = "Walk_" + get_animation_direction(last_direction)
		print(animation)
		# Play the walk animation
		$AnimationPlayer.play(animation)
	else:
#		# Choose idle animation based on last movement direction and play it
#		var animation = get_animation_direction(last_direction) + "_idle"
#		$AnimatedSprite.play(animation)
		$AnimationPlayer.stop(false)
