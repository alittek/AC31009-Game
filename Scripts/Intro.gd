extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			Transition.change_stage("res://Scenes/Map.tscn")
			#get_tree().change_scene("res://Scenes/Map.tscn")
