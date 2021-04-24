extends Popup

onready var score : Label = get_node("Score/Label")
var file = load("res://FileSystem.gd").new()

func display_score():
	var newScore = file.load_score()
	score.text = str(newScore)


