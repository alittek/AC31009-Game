extends Control

onready var label : Label = get_node("Instructions/Label_text")
signal close

# close help and return to menu
func _input(event):
	if Input.is_action_just_pressed("menu"):
		Transition.change_stage("res://Scenes/StartScreen.tscn")
