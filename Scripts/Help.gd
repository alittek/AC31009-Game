extends Control

onready var label : Label = get_node("Instructions/Label_text")
signal close

func _ready():	
	#$Back.color = Color.greenyellow
	label.text = "here is help for you"

func _input(event):
	if Input.is_action_just_pressed("menu"):
		Transition.change_stage("res://Scenes/StartScreen.tscn")
		#Transition.play_fadeIn()
		#queue_free()
		#Transition.play_fadeOut()
