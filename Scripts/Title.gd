extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Label").visible = false
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("Label").visible = true
	yield(get_tree().create_timer(2.0), "timeout")
	get_node("Label").visible = false
	yield(get_tree().create_timer(0.5), "timeout")
	Transition.change_stage("res://Scenes/StartScreen.tscn")

