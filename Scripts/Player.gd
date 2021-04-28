extends KinematicBody2D

onready var ui = get_tree().root.get_node("WorldMap/CanvasLayer/LevelUI")

#var artifacts : int = 0
#var level = Global.level
var speed = 100
var look_direction = "down"
var facingDir = Vector2()
#var interact_dis : int = 50
onready var animation = $AnimationPlayer
#onready var rayCast = $RayCast2D

func _ready ():
	ui.update_artNb_text(Global.artifacts)
	ui.update_level_text(Global.level)
	

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
func get_artifact():
	Global.set_artifacts(Global.artifacts+1)
	ui.update_artNb_text(Global.artifacts)
	$SoundPickup.play()

#func _process(delta):
#	if Input.is_action_just_pressed("interact"):
#		try_interact()
#
#func try_interact():
#	rayCast.cast_to = facingDir * interact_dis
#	if rayCast.is_colliding():
#		if rayCast.get_collider().has_method("on_interact"):
#			rayCast.get_collider().on_interact(self)
#			#get_artifact(1)

# player meets enemy
func lose_artifact(amount):
	var newArti = Global.artifacts-amount
	if newArti < 0:
		return
	Global.set_artifacts(newArti)
	ui.update_artNb_text(Global.artifacts)
	#get_node("Light2D").show()
