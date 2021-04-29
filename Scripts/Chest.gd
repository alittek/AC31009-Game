extends Area2D

var triggered = false
onready var effect = get_node("Effect")
onready var sprite = get_node("Sprite")

func _ready():
	# Tween effects created
	effect.interpolate_property(sprite, 'scale', 
			sprite.get_scale(), Vector2(2.0,2.0), 0.3, 
			Tween.TRANS_QUAD, Tween.EASE_OUT)
	effect.interpolate_property(sprite, 'modulate',
			Color(1,1,1,1), Color(1,1,1,0), 0.3, 
			Tween.TRANS_QUAD, Tween.EASE_OUT)

# pick up items when walking into them (also in player)
func _on_Chest_body_entered(body):
	if body.name == "Player":
		# prefent triggering same chest twice
		if triggered == true:
			return
		triggered = true
		body.get_artifact()
		effect.start()

# remove artifact after effect is played
func _on_Effect_tween_completed(object, key):
	queue_free()
