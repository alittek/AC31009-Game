extends Node2D

onready var score : Label = get_node("Score/Label")
var file = load("res://FileSystem.gd").new()
var intArray = []

func _ready():
	# can be removed, adds values to file
	file.start()
	var scores = file.load_score()
	create_scores(scores)

func display_score():
	$Back.color = Color.greenyellow
	# print top 5 scores
	for i in range(intArray.size()):
		print(intArray[i])
		score.text += str(intArray[i])
	

# create the array with the top five scores
func create_scores(score):
	# split string of scores into array
	var scoreArray = score.split(",", true, 0)
	# remove last empty index
	scoreArray.remove(scoreArray.size()-1)
	
	# change each item in array into int and add to new array
	for i in range(scoreArray.size()):
		var newscore = int(scoreArray[i])
		intArray.append(newscore)
	
	# sort array high to low
	intArray.sort()	
	display_score()

func _input(event):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene("res://StartScreen.tscn")

