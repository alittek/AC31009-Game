extends Node
class_name Generator

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history = []
var steps_since_turn = 0
var rooms = []

# set up variables
func _init(start_position, new_borders):
	assert(new_borders.has_point(start_position))
	position = start_position
	step_history.append(position)
	borders = new_borders

# take numbe rof steps specifed to create rooms
func walk(steps):
	place_room(position)
	for step in steps:
		# avoid long corridors, so turn after nb of steps
		# change map layout to more/ fewer rooms
		if steps_since_turn >= 7:
			change_direction()
		# update stpes taken array
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

# take new step if possible
func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false

# place room and move into different direction
func change_direction():
	place_room(position)
	steps_since_turn = 0 #reset steps when turning
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()

# return info of created room
func create_room(position, size):
	return {position = position, size = size}

# place room of random (within limits) size
func place_room(position):
	var size = Vector2(randi() % 4 + 2, randi() % 4 + 2)
	var top_left_corner = (position - size/2).ceil()
	rooms.append(create_room(position, size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if borders.has_point(new_step):
				step_history.append(new_step)

# get array of rooms of certain size
# used for placing objects in map
func get_rooms():
	var size = rooms.size()
	var newRooms = rooms
	for room in newRooms:
		for key in room:
			if key == 'size':
				# delete  very small rooms
				if room[key] < Vector2(1,2):
					newRooms.erase(room)
	var newSize = newRooms.size()
	# remove first and last few rooms to 
	#var result = newRooms.slice(1, newSize-2)
	var result = newRooms
	return result
	
# find room farthest from start position
func get_end_room():
	var end_room = rooms.pop_front()
	var starting_position = step_history.front()
	for room in rooms:
		# compare size, if bigger set as new end room
		if starting_position.distance_to(room.position) > starting_position.distance_to(end_room.position):
			end_room = room
	return end_room
