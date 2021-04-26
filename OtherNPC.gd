extends KinematicBody2D

var curArt : int = 0
var maxArt : int = 2
var moveSpeed : int = 30
var state = "patrol"

var rng = RandomNumberGenerator.new()
var direc : Vector2

var stealDist : int = 20
var stolen = false
var amount : int = 1
var chaseDist : int = 400

onready var player = get_tree().root.get_node("WorldMap/Player")

# state pattern to run different NPC behaviour
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

func _physics_process(delta):
	var vel : Vector2
	var dist = position.distance_to(player.position)
	
	if dist > chaseDist:
		state = "patrol"
	if dist < chaseDist and dist > stealDist:
		state = "follow"	
	if dist <= stealDist:
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
		var animation = "Walk_" + get_animation_direction(last_direction)
		# Play the walk animation
		$AnimationPlayer.play(animation)
		if state == "steal":
			$AnimationPlayer.stop(false)
	
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

func patrol(delta):
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
	$AnimationPlayer.stop(false)
	yield(get_tree().create_timer(1.5), "timeout")
	queue_free()
