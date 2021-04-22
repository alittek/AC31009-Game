extends Popup

onready var finalLevel : Label = get_node("Info/Label_lev")
onready var finalArt : Label = get_node("Info/Label_art")

onready var world = get_tree().root.get_node("WorldMap")
#onready var player = get_node("../Player/Player")
var already_paused
var selected_menu

func _ready():
	world.connect("death", self, "death_menu")

func change_menu_color():
	$Restart.color = Color.gray
	$Menu.color = Color.gray
	$Quit.color = Color.gray
	
	match selected_menu:
		0:
			$Restart.color = Color.greenyellow
		1:
			$Menu.color = Color.greenyellow
		2:
			$Quit.color = Color.greenyellow

func update_artNb_text():
	finalArt.text = str(Global.artifacts)

func update_level_text():
	finalLevel.text = str(Global.level)

func death_menu():
	# Pause game
	get_tree().paused = true
	# Reset the popup
	selected_menu = 0
	change_menu_color()
	# updates the final score label
	update_artNb_text()
	update_level_text()
	# display gameover screen
	popup()

func _input(event):
	if not visible:
		pass
	else:
		if Input.is_action_just_pressed("move_down"):
			selected_menu = (selected_menu + 1) % 3;
			change_menu_color()
		elif Input.is_action_just_pressed("move_up"):
			if selected_menu > 0:
				selected_menu = selected_menu - 1
			else:
				selected_menu = 2
			change_menu_color()
		elif Input.is_action_just_pressed("interact"):
			match selected_menu:
				0:
					# start again
					# TODO reset everything
					#Global.reset_values()
					#get_tree().reload_current_scene()
					get_node("/root/WorldMap").queue_free()
					get_tree().change_scene("res://Map.tscn")
					get_tree().paused = false
				1:
					# go to main menu
					get_node("/root/WorldMap").queue_free()
					get_tree().change_scene("res://StartScreen.tscn")
					get_tree().paused = false
				2:
					# Quit game
					get_tree().quit()

