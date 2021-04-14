extends Area2D

export var artifact : int = 1

# TODO random amount of artifacts
func get_amount():
	pass

func on_interact(player):
	player.get_artifact(artifact)
	queue_free()
