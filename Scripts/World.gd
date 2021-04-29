extends Node2D

const Player = preload("res://Scenes/Player.tscn")
var player
const Exit = preload("res://Scenes/ExitDoor.tscn")
const NPC = preload("res://Scenes/NPC.tscn")
const Chest = preload("res://Scenes/Chest.tscn")
const Darkness = preload("res://Scenes/Darkness.tscn")
onready var timer_label = get_tree().root.get_node("WorldMap/CanvasLayer/LevelUI/Timer/Label_timer")

# max sizes for world
var xSize = 42
var ySize = 29
var borders = Rect2(1, 1, xSize, ySize)
var timer

# TODO remove?
var steps = Global.steps
var level = Global.level
var time = Global.timer
var enemies = Global.enemies

var objects = []
signal death
onready var tileMap = $TileMap
var load_saved_game = false

func _ready():
	randomize()
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.set_wait_time(time) #value is in seconds: 600 seconds = 10 minutes
	add_child(timer) 
	timer.start() 
	generate_Level_Walker(steps)
	

# update timer text constantly
func _process(delta):
#	timer_label.set_text(str(int(game_timer.get_time_left())))
	timer_label.set_text(str(int(timer.get_time_left())))


# inspired by https://github.com/uheartbeast/walker-level-gen
# 
func generate_Level_Walker(newSteps):
	steps = newSteps
	var walker = Walker.new(Vector2(xSize/2, ySize/2), borders)
	var map = walker.walk(steps)
	
	# place exit position on map (place in room furthest from player)
	var exitPos = walker.get_end_room().position*32
	if free_space(exitPos):
		var exit = Exit.instance()
		add_child(exit)
		exit.position = exitPos
		exit.connect("stop_timer", self, "pause_player")
		exit.connect("leaving_level", self, "next_level")
	
	# place player on map
	var playerPos = map.front()*32
	# needs to be placed first because of function calls
	if free_space(playerPos):
		player = Player.instance()
		add_child(player)
		player.position = playerPos

	# place enemies on map
	var nbEnemies = 0
	for room in walker.get_rooms():
		if nbEnemies >= level:
			break
		else:
			if free_space(room.position*32):
				var npc = NPC.instance()
				add_child(npc)
				nbEnemies += 1
				npc.position = room.position*32
#				var newPos = room.position*32 - Vector2(1,-1)
#				npc.position = newPos

	# place artifacts on map 
	var nbChests = 0
	for room in walker.get_rooms():
		if nbChests == level-1:
			break
		else:
			if free_space(room.position*32):
				var chest = Chest.instance()
				add_child(chest)
				nbChests += 1
				chest.position = room.position*32
	
#	print("chests: " + str(nbChests))
#	print("______________")

#	var nbEnemies = 0
#	for room in walker.get_rooms():
#		if nbEnemies >= level:
#			break
#		else:
#			if free_space(room.position*32):
#				var npc = NPC.instance()
#				add_child(npc)
#				nbEnemies += 1
#				npc.position = room.position*32
##				var newPos = room.position*32 - Vector2(1,-1)
##				npc.position = newPos

	print("enemies: " + str(nbEnemies))
	print("chests: " + str(nbChests))
	print("______________")
	
	# decide when to r=turn on darkness
	#if Global.level == 5 or Global.level == 7:
	turn_dark()
	
	
	walker.queue_free()
	walker.free()
	for location in map:
			tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

# pause player movement when exit reached
func pause_player():
	yield(get_tree().create_timer(0.3), "timeout")
	timer.paused = true	
	player.disable_movement()

# run when a level is finished
func next_level():
	Global.set_steps(steps+20)
	Global.set_level(level+1)
	Global.set_timer(timer.get_time_left()+(level*3))
	Global.set_enemies(enemies+1)
	timer.free()
	queue_free()
	Transition.change_stage("res://Scenes/Map.tscn")

# check if space is available
func free_space(vector):
	# check if vector already in use
	if objects.has(vector):
		return false
	else:
		# add vector to list of filled spaces
		objects.append(vector)
		return true

# trigger darkness and turn on light
func turn_dark():
	var dark = Darkness.instance()
	add_child(dark)
	player.get_node("Light2D").show()

# triggered when time runs out for player
func _on_timer_timeout():
	emit_signal("death")
	Global.set_values()
