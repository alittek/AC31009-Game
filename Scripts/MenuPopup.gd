extends Popup

var already_paused
var selected_menu = 0
var instanced = false

func change_menu_color():
	$Resume.color = Color.gray
	$Help.color = Color.gray
	$MainMenu.color = Color.gray
	
	match selected_menu:
		0:
			$Resume.color = Color.greenyellow
		1:
			$Help.color = Color.greenyellow
		2:
			$MainMenu.color = Color.greenyellow

func _input(event):
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
					# Resume game
					if not already_paused:
						get_tree().paused = false
					#player.set_process_input(true)
					hide()
				1:
					# TODO fade not working!!!
					if instanced == false:
						var ins = preload("res://Scenes/Instructions.tscn").instance()
						#Transition.play_fadeIn()
						add_child(ins)
						instanced = true
						print(".................. child added ")
						#Transition.play_fadeOut()
				2:
					# Quit game, back to start screen
					get_node("/root/WorldMap").queue_free()
					#get_tree().change_scene("res://Scenes/StartScreen.tscn")
					Transition.change_stage("res://Scenes/StartScreen.tscn")
					get_tree().paused = false
