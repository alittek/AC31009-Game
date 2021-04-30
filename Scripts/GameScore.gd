extends Node2D

onready var score1 : Label = get_node("Score/Label_1")
onready var score2 : Label = get_node("Score/Label_2")
onready var score3 : Label = get_node("Score/Label_3")
onready var score4 : Label = get_node("Score/Label_4")
onready var score5 : Label = get_node("Score/Label_5")

var file = load("res://Scripts/FileSystem.gd").new()
var array = []

func _ready():
	# used fortesting to add values to file
	#file.start()
	#play sound
	var scores = file.load_score()
	create_scores(scores)

# display the top five scores in the right labels
func display_score():
	var arraySize = array.size()
	# check number of scores saved and print at most the top 5
	if arraySize > 0:
		score1.text = str(array[0])
	if arraySize > 1:
		score2.text = str(array[1])
	if arraySize > 2:
		score3.text = str(array[2])
	if arraySize > 3:
		score4.text = str(array[3])
	if arraySize > 4:
		score5.text = str(array[4])	

# create the array with the top five scores
func create_scores(score):
	var scoreArray = []
	var intArray = []
	# split string of scores into array
	scoreArray = score.split(",", true, 0)
	# remove last empty index
	scoreArray.remove(scoreArray.size()-1)
	
	# change each item in array into int and add to new array
	for i in range(scoreArray.size()):
		var newscore = int(scoreArray[i])
		intArray.append(newscore)
	
	# sort array high to low
	intArray.sort()	
	
	# set number of high scores
	# 5 if 5 or more exist, otherwise all existing scores on file
	var number_of_scores
	if intArray.size() < 5:
		number_of_scores = intArray.size()
	else:
		number_of_scores = 5
	
	# add values from array to highscore array
	for i in range(number_of_scores):
		var finalScore = intArray[intArray.size()-(i+1)]
		array.append(finalScore)
	display_score()

# if esc key pressed return to menu
func _input(event):
	if Input.is_action_just_pressed("menu"):
		file.free()
		queue_free()
		Transition.change_stage("res://Scenes/StartScreen.tscn")

