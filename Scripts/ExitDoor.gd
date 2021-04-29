extends Area2D

signal leaving_level
signal stop_timer

func _on_ExitDoor_body_entered(body):
	if (body.get_name() == "Player"):
		emit_signal("stop_timer")
		$SoundExit.play()
		yield($SoundExit, "finished")
		emit_signal("leaving_level")
		
