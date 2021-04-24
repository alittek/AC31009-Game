extends Node2D

onready var score : Label = get_node("Score/Label")
var file = load("res://FileSystem.gd").new()

func _ready():
	display_score()

func display_score():
	$Back.color = Color.greenyellow
	var newScore = file.load_score()
	score.text = str(newScore)

func _input(event):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene("res://StartScreen.tscn")

