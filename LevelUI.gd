extends Control

onready var artNb : Label = get_node("Artifacts/Label")
#onready var healthBar : TextureProgress = get_node("BG/HealthBar")
#onready var xpBar : TextureProgress = get_node("BG/XpBar")
#onready var goldText : Label = get_node("BG/GoldText")

# updates the level text Label node
func update_artNb_text(number):
	artNb.text = str(number)

