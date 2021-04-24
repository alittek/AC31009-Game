extends Node

var score_file = "user://score.save"
var highscore
var status

func save_score(highscore):
	var file = File.new()
	if file.file_exists(score_file):
		status = file.open(score_file, File.READ_WRITE)
	else:
		status = file.open(score_file, File.WRITE)
	
	if status == OK:
		file.seek_end()
		file.store_string(str(highscore) + "\r")
		file.close()


func load_score():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		highscore = file.get_as_text()
		file.close()
	else:
		highscore = 0
	return highscore
