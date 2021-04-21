extends Area2D

#export var artifactNb : int = 1
var triggered = false
onready var effect = get_node("Effect")
onready var sprite = get_node("Sprite")
#onready var collision = create_shape_owner(get_node("CollisionShape2D2"))

func _ready():
	pass
#	effect.interpolate_property(sprite, 'scale', 
#			sprite.get_scale(), Vector2(2.0,2.0), 0.3, 
#			Tween.TRANS_QUAD, Tween.EASE_OUT)
#	effect.interpolate_property(sprite, 'modulate',
#			Color(1,1,1,1), Color(1,1,1,0), 0.3, 
#			Tween.TRANS_QUAD, Tween.EASE_OUT)


# TODO random amount of artifacts
func get_amount():
	pass


# pick up when pressing interact
#func on_interact(player):
#	player.get_artifact(artifactNb)
#	effect.start()


# pick up items when walking into them (also in player)
func _on_Chest_body_entered(body):
	if body.name == "Player":
		#print("1 = triggered: " + str(triggered))
		if triggered == true:
			return
		triggered = true
		#print("....")
		#print("2 = triggered: " + str(triggered))
#		var owners = get_shape_owners()
#		shape_owner_clear_shapes(owners[0])
#		$CollisionShape.set_deferred("disabled", true)
		body.get_artifact()
		#effect.start()
		queue_free()
		


func _on_Effect_tween_completed(object, key):
	queue_free()
