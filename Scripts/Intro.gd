extends Node2D

# start game if any key is pressed
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			Transition.change_stage("res://Scenes/Map.tscn")
