extends Control

onready var level : Label = get_node("LevelData/Level_Nb")
onready var artNb : Label = get_node("LevelData/Arti_Nb")
#onready var healthBar : TextureProgress = get_node("BG/HealthBar")
#onready var xpBar : TextureProgress = get_node("BG/XpBar")
#onready var goldText : Label = get_node("BG/GoldText")

# updates the level text Label node
func update_artNb_text(number):
	artNb.text = str(number)

func update_level_text(number):
	level.text = str(number)
