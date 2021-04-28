extends ColorRect

func _ready():
	pass # Replace with function body.


func change_stage(scene_path):
	# transition to black
	get_node("AnimationPlayer").play("Fade")
	yield(get_node("AnimationPlayer"),"animation_finished")
	
	# switch scene
	get_tree().change_scene(scene_path)
	
	# transition to clear
	get_node("AnimationPlayer").play_backwards("Fade")
	#yield(get_node("AnimationPlayer"),"animation_finished")
	
	pass
