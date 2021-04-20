extends Node2D

const Player = preload("res://Player.tscn")
const Exit = preload("res://ExitDoor.tscn")
const NPC = preload("res://NPC.tscn")
const Chest = preload("res://Chest.tscn")
onready var timer_label = get_tree().root.get_node("WorldMap/CanvasLayer/LevelUI/Label_timer")
onready var level_label = get_tree().root.get_node("WorldMap/CanvasLayer/LevelUI/Level/Label")

onready var game_timer = get_node("Timer")

#TODO change for levels
var xSize = 42
var ySize = 29
var borders = Rect2(1, 1, xSize, ySize)

var steps = 200

onready var tileMap = $TileMap
var load_saved_game = false

func _ready():
	randomize()
	#generate_Maze()
	generate_Level_Walker()
	

func _process(delta):
	timer_label.set_text(str(int(game_timer.get_time_left())))


# inspired by https://github.com/munificent/hauberk/blob/db360d9efa714efb6d937c31953ef849c7394a39/lib/src/content/dungeon.dart
#
func generate_Maze():
	pass



# inspired by https://github.com/uheartbeast/walker-level-gen
# 
func generate_Level_Walker():
	var walker = Walker.new(Vector2(xSize/2, ySize/2), borders)
	var map = walker.walk(steps)
	
	# needs to be placed first because of function calls
	var player = Player.instance()
	add_child(player)
	player.position = map.front()*32
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position*32
	exit.connect("leaving_level", self, "reload_level")

	# place enemies/artifacts:
	# walker.rooms() and the loop through the rooms
	# or only plave in certain size rooms
	var npc = NPC.instance()
	add_child(npc)
	npc.position = walker.get_end_room().position*32
	# place artifacts
	for room in walker.get_rooms():
		var chest = Chest.instance()
		add_child(chest)
		chest.position = room.position*32
	
	

	
	walker.queue_free()
	for location in map:
			tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	get_tree().reload_current_scene()
	

#func _input(event):
#	if event.is_action_pressed("interact"):
#		reload_level()
		
func save():
	pass


func _on_Timer_timeout():
	get_tree().change_scene("res://StartScreen.tscn")
