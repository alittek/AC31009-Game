extends CanvasLayer

func change_stage(scene_path):
	# transition to black
	play_fadeIn()
	# switch scene
	get_tree().change_scene(scene_path)
	# transition to clear
	play_fadeOut()
	
func play_fadeIn():
	get_node("SceneTransition/AnimationPlayer").play("Fade")
	yield(get_node("SceneTransition/AnimationPlayer"),"animation_finished")
	print("fade in .............")

func play_fadeOut():
	get_node("SceneTransition/AnimationPlayer").play_backwards("Fade")
	yield(get_node("SceneTransition/AnimationPlayer"),"animation_finished")
	print("fade out  .............")
