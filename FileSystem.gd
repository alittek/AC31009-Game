extends Node

var score_file = "user://score.save"
var password = "pass"
#var highscore
var status
var highscores


func start():
	save_score(3)
	save_score(4)
	save_score(100)
	save_score(12)

func save_score(highscore):
	var file = File.new()
	if file.file_exists(score_file):
		#status = file.open_encrypted_with_pass(score_file, File.READ_WRITE, OS.get_unique_id())
		status = file.open(score_file, File.READ_WRITE)
		#status = file.open_encrypted_with_pass(score_file, File.READ_WRITE, password)
	else:
		#status = file.open_encrypted_with_pass(score_file, File.WRITE, OS.get_unique_id())
		status = file.open(score_file, File.WRITE)
		#status = file.open_encrypted_with_pass(score_file, File.WRITE, password)
	
	if status == OK:
		file.seek_end()
		file.store_string(str(highscore) + ",")
		file.close()

func load_score():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		#file.open_encrypted_with_pass(score_file, File.READ, password)
		highscores = file.get_as_text()
		#create_scores(highscore)
		file.close()
	else:
		return
	return highscores
