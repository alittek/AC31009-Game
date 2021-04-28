extends CanvasLayer

func _ready():
	pass

func change_stage(scene_path):
	# transition to black
	get_node("SceneTransition/AnimationPlayer").play("Fade")
	yield(get_node("SceneTransition/AnimationPlayer"),"animation_finished")
	# switch scene
	get_tree().change_scene(scene_path)
	# transition to clear
	get_node("SceneTransition/AnimationPlayer").play_backwards("Fade")
