extends Control

onready var level : Label = get_node("LevelData/Level_Nb")
onready var artNb : Label = get_node("LevelData/Arti_Nb")

# updates the artifact text Label node
func update_artNb_text(number):
	artNb.text = str(number)

# update the level text label
func update_level_text(number):
	level.text = str(number)
