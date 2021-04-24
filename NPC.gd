extends KinematicBody2D

var curArt : int = 0
var maxArt : int = 2
var moveSpeed : int = 30
var stealDist : int = 40
var amount : int = 1
var stealRate : float = 1.0
var chaseDist : int = 400
var stolen : bool = false

var state = "patrol"

var rng = RandomNumberGenerator.new()
var direc : Vector2

onready var timer = $Timer
onready var player = get_tree().root.get_node("WorldMap/Player")

var player_in_range
var player_in_sight

func _ready ():
#	timer.wait_time = stealRate
#	timer.start()
	pass

func _process(delta):
	#state pattern to allow enemy behaviour
	match state:
		"patrol":
			pass
			#print("zzzzzzz")
			patrol(delta)
		"follow":
			#print("taptaptap")
			follow()
		"search":
			pass
		"steal":
			steal()
		"flee":
			flee()
		


func _physics_process(delta):
	check_sight()
	
#	var vel : Vector2
#	var dist = position.distance_to(player.position)
#	# TODO if player not close patrol
#	if dist > chaseDist:
#		pass
#
#	#if player close
#	if dist < chaseDist:
#		vel = (player.position - position).normalized()
#		move_and_slide(vel * moveSpeed)
#
#	animate_NPC(vel)
#
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
		#print(animation)
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
#
## check if player has stolen set number of artifacts
#func steal_artifact(artToTake):
#	curArt += artToTake
#	if curArt >= maxArt:
#		flee()



# check if player is in sight of the enemy
func check_sight():
	if player_in_range == true:
		# get snapshot of world with all bodies
		var space_state = get_world_2d().direct_space_state
		var sight_check = space_state.intersect_ray(position, player.position, [self], collision_mask)
		if sight_check:
			if sight_check.collider.name == "Player":
				player_in_sight = true
				state = "follow"
				print("state: ", state)
				if position.distance_to(player.position) <= stealDist:
					state = "steal"
					print("state: ", state)
					if stolen == true:
						state = "flee"
						print("state: ", state)
						#stolen = false
			else:
				state = "patrol"
				print("state: ", state)
	else:
		player_in_sight = false
		state = "patrol"
		print("state: ", state)
		#print("player in sight ", player_in_sight)

func follow():
	var vel : Vector2	
	vel = (player.position - position).normalized()
	move_and_slide(vel * moveSpeed)
	animate_NPC(vel)

func steal():
	player.lose_artifact(amount)
	stolen = true
	return stolen
#		steal_artifact(amount)
#
## check if player has stolen set number of artifacts
#func steal_artifact(artToTake):
#	curArt += artToTake
#	if curArt >= maxArt:
#		flee()

func patrol(delta):
	#if bounce_countdown == 0:
	
	# If player is too far, randomly decide whether to stand still or where to move
	var random_number = rng.randf()
	if random_number < 0.05:
		direc = Vector2.ZERO
	elif random_number < 0.1:
		direc = Vector2.DOWN.rotated(rng.randf() * 2 * PI)

	var movement = direc * moveSpeed * delta
	var collision = move_and_collide(movement)
	# Update bounce countdown
#	if bounce_countdown > 0:
#		bounce_countdown = bounce_countdown - 1

# enemy disapears
func flee():
	print("..............................................")
	queue_free()


# sight area entered
func _on_Sight_body_entered(body):
	if body == player:
		player_in_range = true
		#print("player in range ", player_in_range)

# sight area exited
func _on_Sight_body_exited(body):
	if body == player:
		player_in_range = false
		player_in_sight = false
		#print("player in range ", player_in_range)
