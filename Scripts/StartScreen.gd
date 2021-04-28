extends Node2D

var selected_menu = 0
var instanced = false

func change_menu_color():
	$NewGame.color = Color.gray
	$HighScore.color = Color.gray
	$Instructions.color = Color.gray
	$Quit.color = Color.gray
	
	match selected_menu:
		0:
			$NewGame.color = Color.greenyellow
		1:
			$HighScore.color = Color.greenyellow
		2:
			$Instructions.color = Color.greenyellow
		3:
			$Quit.color = Color.greenyellow

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	change_menu_color()

func _input(event):
	if Input.is_action_just_pressed("move_down"):
		selected_menu = (selected_menu + 1) % 4;
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
				# New game
				Transition.change_stage("res://Scenes/Intro.tscn")
				
			1:
				# Highscore
				Transition.change_stage("res://Scenes/GameScore.tscn")
#				Transition.play_fadeIn()
#				get_tree().change_scene("res://Scenes/GameScore.tscn")
#				Transition.play_fadeOut()
			2:
				# Instructions
				Transition.change_stage("res://Scenes/Instructions.tscn")
#				if instanced == false:
#					var instr = preload("res://Scenes/Instructions.tscn").instance()
#					#Transition.display_scene(instr)
#					Transition.play_fadeIn()
#					add_child(instr)
#					instanced = true
#					print("... child also added ......")
#					Transition.play_fadeOut()
			3:
				# Quit game
				Transition.play_fadeIn()
				get_tree().quit()
