extends Popup

onready var finalLevel : Label = get_node("Info/Label_lev")
onready var finalArt : Label = get_node("Info/Label_art")
onready var finalScore : Label = get_node("Info/Label_sco")

var file = load("res://Scripts/FileSystem.gd").new()
onready var world = get_tree().root.get_node("WorldMap")

var already_paused
var selected_menu

func _ready():
	world.connect("death", self, "death_menu")

# change menu to indicate selected option
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

# update the artifact score text
func update_artNb_text():
	var number = calc_totalAtrifacts(Global.level-1)
	finalArt.text = str(Global.artifacts) + " / " + str(number)

# upfdate the level text
func update_level_text():
	finalLevel.text = str(Global.level)

# upfdate the score text
func update_score_text(newScore):
	finalScore.text = str(newScore)

# get the total number of artifacts in the game so far
func calc_totalAtrifacts(x):
	if x == 1 or x == 0:
		return 1
	else:
		return x + calc_totalAtrifacts(x-1)

# initiate game over popup
func death_menu():
	# Pause game
	get_tree().paused = true
	# Reset the popup
	selected_menu = 0
	change_menu_color()
	# updates the final score label
	set_highscore()
	update_artNb_text()
	update_level_text()
	# display gameover screen
	popup()
	#$SoundGameOver.set_volume_db(2)
	$SoundGameOver.play()
	yield($SoundGameOver, "finished")

# calc high score and save to file
func set_highscore():
	var score = Global.level+(Global.level*Global.artifacts)
	file.save_score(score)
	update_score_text(score)
	file.free()

# input in manu handled
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
					# Start again
					get_node("/root/WorldMap").queue_free()
					Transition.change_stage("res://Scenes/Map.tscn")
					get_tree().paused = false
				1:
					# To main menu
					get_node("/root/WorldMap").queue_free()
					Transition.change_stage("res://Scenes/StartScreen.tscn")
					get_tree().paused = false
				2:
					# Quit game
					get_tree().quit()

