extends Node

var score_file = "user://GameScoreEncry.bin"
# used for file encryption
var encry = "}K5gdp3Y5V,B6!B"
# file status
var status
var highscores

# adding scores for testing
func start():
#	save_score(30)
#	save_score(4)
#	save_score(100)
#	save_score(12)
	pass

# save a new score passed as argument
func save_score(highscore):
	var existing_content = ""
	var file = File.new()
	# if file exists, save contents
	if file.file_exists(score_file):
		existing_content = load_score()
	status = file.open_encrypted_with_pass(score_file, File.WRITE, encry)
	
	# if file was opened correctly
	if status == OK:
		# save existing content plus new score again
		file.store_string(existing_content + str(highscore) + ",")
		file.close()
	else:
		print("error opening file")

# load all contents of the file and return them as a string
func load_score():
	var file = File.new()
	# check if file to load from exists
	if file.file_exists(score_file):
		# read from encrypted file
		file.open_encrypted_with_pass(score_file, File.READ, encry)
		highscores = file.get_as_text()
		print("score: ", highscores)
		file.close()
	else:
		return ""
	return highscores
