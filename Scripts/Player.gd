extends KinematicBody2D

onready var ui = get_tree().root.get_node("WorldMap/CanvasLayer/LevelUI")
var moving = true
var speed = 100
var look_direction = "down"
var facingDir = Vector2()
onready var animation = $AnimationPlayer

# initiate Ui displays
func _ready ():
	ui.update_artNb_text(Global.artifacts)
	ui.update_level_text(Global.level)
	
# process player movement and direction to animate player
func _physics_process(_delta):
	if moving == true:
		var movement = Vector2()
		movement.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		movement.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		
		var velocity = movement.clamped(1) * speed 
		velocity = move_and_slide(velocity)
		if not $SoundSteps.is_playing():
			$SoundSteps.play()

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
			$SoundSteps.stop()

# player picks up items, update UI
func get_artifact():
	Global.set_artifacts(Global.artifacts+1)
	ui.update_artNb_text(Global.artifacts)
	$SoundPickup.play()

# player meets enemy, update UI
func lose_artifact(amount):
	var newArti = Global.artifacts-amount
	if newArti < 0:
		return
	Global.set_artifacts(newArti)
	ui.update_artNb_text(Global.artifacts)
	$SoundEnemy.play()

# allows to disable player movement
func disable_movement():
	moving = false
	animation.stop(false)
