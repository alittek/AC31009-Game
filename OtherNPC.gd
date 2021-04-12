#extends KinematicBody2D
#
#var curHp : int = 5
#var maxHp : int = 5
#
#var moveSpeed : int = 30
#var xpToGive : int = 30
#
#var damage : int = 1
#var attackRate : float = 1.0
#var attackDist : int = 80
#var chaseDist : int = 400
#
#onready var timer = $Timer
#onready var target = get_tree().root.get_node("WorldMap/Player")
#
#func _physics_process (delta):
#	var dist = position.distance_to(target.position)
#	if dist > attackDist and dist < chaseDist:
#		var vel = (target.position - position).normalized()
#		move_and_slide(vel * moveSpeed)
