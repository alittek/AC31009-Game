extends Control

onready var label : Label = get_node("Instructions/Label_text")
signal close

func _ready():
	#$Back.color = Color.greenyellow
	label.text = "here is help for you"

func _input(event):
	if Input.is_action_just_pressed("menu"):
		queue_free()
		#emit_signal("closeInstr")
		print("close signel ......2")
