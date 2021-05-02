extends Area2D

signal leaving_level
signal stop_timer

func _on_ExitDoor_body_entered(body):
	if (body.get_name() == "Player"):
		# make sure timer and player stop when exit is reached
		emit_signal("stop_timer")
		# play sound and wait for finish
		$SoundExit.play()
		yield($SoundExit, "finished")
		# signal that the player is leaving
		emit_signal("leaving_level")
