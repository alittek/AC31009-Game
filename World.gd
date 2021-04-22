extends Node2D

const Player = preload("res://Player.tscn")
const Exit = preload("res://ExitDoor.tscn")
const NPC = preload("res://NPC.tscn")
const Chest = preload("res://Chest.tscn")
onready var timer_label = get_tree().root.get_node("WorldMap/CanvasLayer/LevelUI/Label_timer")
onready var level_label = get_tree().root.get_node("WorldMap/CanvasLayer/LevelUI/Level/Label")

#onready var game_timer = get_node("Timer")

#TODO change for levels
var xSize = 42
var ySize = 29
var borders = Rect2(1, 1, xSize, ySize)
var timer

var steps = Global.steps
var level = Global.level
var time = Global.timer
var enemies = Global.enemies

signal death
onready var tileMap = $TileMap
var load_saved_game = false

func _ready():
	randomize()
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.set_wait_time(Global.timer) #value is in seconds: 600 seconds = 10 minutes
	add_child(timer) 
	timer.start() 
	#generate_Maze()
	generate_Level_Walker(steps)
	

func _process(delta):
#	timer_label.set_text(str(int(game_timer.get_time_left())))
	timer_label.set_text(str(int(timer.get_time_left())))
	


# inspired by https://github.com/munificent/hauberk/blob/db360d9efa714efb6d937c31953ef849c7394a39/lib/src/content/dungeon.dart
#
func generate_Maze():
	pass



# inspired by https://github.com/uheartbeast/walker-level-gen
# 
func generate_Level_Walker(newSteps):
	steps = newSteps
	var walker = Walker.new(Vector2(xSize/2, ySize/2), borders)
	var map = walker.walk(steps)
	
	# needs to be placed first because of function calls
	var player = Player.instance()
	add_child(player)
	player.position = map.front()*32
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position*32
	exit.connect("leaving_level", self, "next_level")

	# place artifacts
	var nbChests = 0
	for room in walker.get_rooms():
		if nbChests == Global.level-1:
			break
		else:
			var chest = Chest.instance()
			add_child(chest)
			nbChests += 1
			chest.position = room.position*32
	
#	print("chests: " + str(nbChests))
#	print("______________")

	var nbEnemies = 0
	for room in walker.get_rooms():
		if nbEnemies >= Global.level-5:
			break
		else:
			var npc = NPC.instance()
			add_child(npc)
			nbEnemies += 1
			var newPos = room.position*32 - Vector2(1,-1)
			#npc.position = room.position*32
			npc.position = newPos
			
		print("enemies: " + str(nbEnemies))
		print("______________")
	
	walker.queue_free()
	for location in map:
			tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

# run when a level is finished
func next_level():
	Global.set_steps(steps+20)
	Global.set_level(level+1)
	Global.set_timer(timer.get_time_left()+(level*5))
	Global.set_enemies(enemies+1)
	get_tree().reload_current_scene()
	

#func _input(event):
#	if event.is_action_pressed("interact"):
#		next_level()
		
func save():
	pass

func _on_timer_timeout():
	emit_signal("death")
	Global.reset_values()
