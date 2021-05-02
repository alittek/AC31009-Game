extends CanvasLayer
# Singleton pattern used here to handle transition 
# between scenes and the associated animation

# play fade in/ out animation when switching scene
func change_stage(scene_path):
	# transition to black
	play_fadeIn()
	# switch scene
	get_tree().change_scene(scene_path)
	# transition to clear
	play_fadeOut()

# play fade in, wait till finished
func play_fadeIn():
	get_node("SceneTransition/AnimationPlayer").play("Fade")
	yield(get_node("SceneTransition/AnimationPlayer"),"animation_finished")

# play fade out, wait till finished
func play_fadeOut():
	get_node("SceneTransition/AnimationPlayer").play_backwards("Fade")
	yield(get_node("SceneTransition/AnimationPlayer"),"animation_finished")
