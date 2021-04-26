extends KinematicBody2D

var curArt : int = 0
var maxArt : int = 2
var moveSpeed : int = 30
var state = "patrol"

var rng = RandomNumberGenerator.new()
var direc : Vector2

var stealDist : int = 30
var stolen = false
var amount : int = 1
#var stealRate : float = 1.0
var chaseDist : int = 400

onready var timer = $Timer
onready var player = get_tree().root.get_node("WorldMap/Player")


func _process(delta):
	#state pattern to allow enemy behaviour
	match state:
		"patrol":
			#print("patrol")
			patrol(delta)
		"follow":
			#print("follow")
			follow(delta)
		"steal":
			#print("steal")
			steal()
		"flee":
			#print("flee")
			flee()
		


#func _ready ():
#	timer.wait_time = stealRate
#	timer.start()

func _physics_process(delta):
	var vel : Vector2
	var dist = position.distance_to(player.position)
	
	if dist > chaseDist:
		state = "patrol"
	if dist < chaseDist and dist > stealDist:
		state = "follow"	
	if dist <= stealDist:
		$AnimationPlayer.stop(false)
		state = "steal"
	if stolen == true:
		state = "flee"

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
		print("animation!....... ", animation)
		# Play the walk animation
		$AnimationPlayer.play(animation)
	else:
#		# Choose idle animation based on last movement direction and play it
#		var animation = get_animation_direction(last_direction) + "_idle"
#		$AnimatedSprite.play(animation)
		$AnimationPlayer.stop(false)


#func _on_Timer_timeout():
#	if position.distance_to(player.position) <= stealDist:
#		player.lose_artifact(amount)
#		steal_artifact(amount)
	
func follow(delta):
	var vel : Vector2	
	vel = (player.position - position).normalized()
	move_and_slide(vel * moveSpeed)
	animate_NPC(vel)

func steal():
	player.lose_artifact(amount)
	steal_artifact(amount)
	
# check if player has stolen set number of artifacts
func steal_artifact(artToTake):
	curArt += artToTake
	if curArt >= maxArt:
		stolen = true
	#OS.delay_msec(1000)
#	timer.set_wait_time(3) # Set Timer's delay to "sec" seconds
#	timer.start() # Start the Timer counting down
#	yield(timer, "timeout") # Wait for the timer to wind down
	

func patrol(delta):
	#if bounce_countdown == 0:
	# If player is too far, randomly decide whether to stand still or where to move
	var random_number = rng.randf()
	if random_number < 0.05:
		direc = Vector2.ZERO
	elif random_number < 0.1:
		direc = Vector2.DOWN.rotated(rng.randf() * 2 * PI)
	var movement = direc * moveSpeed * delta
	var collision = move_and_slide(movement)

# enemy disapears
func flee():
	print("..............................................")
	queue_free()
