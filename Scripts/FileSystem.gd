extends Node

var score_file = "user://GameScore.save"
var password = "pass"
#var password = OS.get_unique_id()
var status
var highscores

# adding scores for testing
func start():
	#save_score(30)
	#save_score(4)
	#save_score(100)
	#save_score(12)
	pass

# save a new score passed as argument
func save_score(highscore):
	var file = File.new()
	if file.file_exists(score_file):
		status = file.open(score_file, File.READ_WRITE)
		#status = file.open_encrypted_with_pass(score_file, File.READ_WRITE, password)
		#print("exists")
	else:
		status = file.open(score_file, File.WRITE)
		#status = file.open_encrypted_with_pass(score_file, File.WRITE, password)
		#print("doesnt exist")
	
	# if file was opened correctly
	print("status: ", status)
	if status == OK:
		print(".....OK.....")
		file.seek_end()
		file.store_string(str(highscore) + ",")
		file.close()
	else:
		print("error opening file")

# load all contents of the file and return them as a string
func load_score():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		#file.open_encrypted_with_pass(score_file, File.READ, password)
		highscores = file.get_as_text()
		print("score: ", highscores)
		file.close()
	else:
		return ""
	#print("score: ", highscores)
	return highscores

func _encrypt():
	pass
	
func decrypt():
	pass
