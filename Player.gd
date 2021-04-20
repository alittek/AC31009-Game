extends KinematicBody2D

onready var ui = get_tree().root.get_node("WorldMap/CanvasLayer/LevelUI")

var artifacts : int = 0
var level : int = 1
var speed = 100
var look_direction = "down"
var facingDir = Vector2()
var interact_dis : int = 40
onready var animation = $AnimationPlayer
onready var rayCast = $RayCast2D

func _ready ():
	ui.update_artNb_text(artifacts)
	ui.update_level_text(level)
	

func _physics_process(_delta):
	var movement = Vector2()
	movement.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	var velocity = movement.clamped(1) * speed 
	velocity = move_and_slide(velocity)

	if movement == Vector2.DOWN:
			look_direction = "down"
			facingDir = Vector2(0, 1)
			animation.play(str("Walk_", look_direction ))

	elif movement == Vector2.UP:
			look_direction = "up"
			facingDir = Vector2(0, -1)
			animation.play(str("Walk_", look_direction ))

	elif movement == Vector2.LEFT:
			look_direction = "left"
			facingDir = Vector2(-1, 0)
			animation.play(str("Walk_", look_direction ))

	elif movement == Vector2.RIGHT:
			look_direction = "right"
			facingDir = Vector2(1, 0)
			animation.play(str("Walk_", look_direction ))

	elif movement == Vector2.ZERO:
		animation.stop(false)
		#animation.play(str("Idle_", look_direction ))

# TODO player picks up items
func get_artifact(amount):
	artifacts += amount
	$SoundPickup.play()
	ui.update_artNb_text(artifacts)

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_interact()

func try_interact():
	pass
	rayCast.cast_to = facingDir * interact_dis
	if rayCast.is_colliding():
		# TODO open walls
		if rayCast.get_collider() is KinematicBody2D:
#			rayCast.get_collider().take_damage(damage)
			pass
		elif rayCast.get_collider().has_method("on_interact"):
			rayCast.get_collider().on_interact(self)

# player meets enemy
func lose_artifact(amount):
	artifacts -= amount
	ui.update_artNb_text(artifacts)
	if artifacts <= 0:
		die()
		
func die():
	#TODO back to menu?
	get_tree().reload_current_scene()
