extends Popup

### does not stop spacebar from working
#onready var Player = preload("res://Player.tscn")
#var player = Player.instance()

#onready var player = get_node("../Player/Player")
var already_paused
var selected_menu

func _ready():
	pass


func change_menu_color():
	$Resume.color = Color.gray
	$SaveGame.color = Color.gray
	$MainMenu.color = Color.gray
	
	match selected_menu:
		0:
			$Resume.color = Color.greenyellow
		1:
			$SaveGame.color = Color.greenyellow
		2:
			$MainMenu.color = Color.greenyellow

func _input(event):
			
	if not visible:
		if Input.is_action_just_pressed("menu"):
			# Pause game
			get_tree().paused = true
			# Reset the popup
			selected_menu = 0
			change_menu_color()
			# Show popup
			#player.set_process_input(false)
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
					# Save game
					pass
#					get_node("/root/Root").save()
#					get_tree().paused = false
#					hide()
				2:
					# Quit game, back to start screen
					pass
					get_node("/root/WorldMap").queue_free()
					get_tree().change_scene("res://StartScreen.tscn")
					get_tree().paused = false
