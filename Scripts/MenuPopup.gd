extends Popup

var already_paused
var selected_menu = 0
var instanced = false

# change menu to indicate selected option
func change_menu_color():
	$Resume.color = Color.gray
	$MainMenu.color = Color.gray
	
	match selected_menu:
		0:
			$Resume.color = Color.greenyellow
		1:
			$MainMenu.color = Color.greenyellow

# handle menu selection
func _input(event):
	# display popup if not visiblke yet
	if not visible and get_tree().paused == false:
		if Input.is_action_just_pressed("menu"):
			# Pause game
			get_tree().paused = true
			# Reset the popup
			selected_menu = 0
			change_menu_color()
			# Show popup
			popup()
	else:
		if Input.is_action_just_pressed("move_down"):
			selected_menu = (selected_menu + 1) % 2;
			change_menu_color()
		elif Input.is_action_just_pressed("move_up"):
			if selected_menu > 0:
				selected_menu = selected_menu - 1
			else:
				selected_menu = 1
			change_menu_color()
		elif Input.is_action_just_pressed("interact"):
			match selected_menu:
				0:
					# Resume game
					if not already_paused:
						get_tree().paused = false
					hide()
				1:
					# Quit game, back to start screen
					get_node("/root/WorldMap").queue_free()
					Transition.change_stage("res://Scenes/StartScreen.tscn")
					# reset variables to allow for new game starting level 1
					Global.set_values()
					get_tree().paused = false
