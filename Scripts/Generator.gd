extends Node
class_name Generator

# save all four possible directions for steps
const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
# starting position: point left
var direction = Vector2.LEFT
var borders = Rect2()
# save steps taken
var step_history = []
# keep track of number of steps
var steps_since_turn = 0
# array of rooms in existing maze
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
		# update steps taken array
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

# take new step if possible
func step():
	# get target for new step
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
	# reset steps when turning
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	# get random direction from array
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()

# return info of created room
func create_room(position, size):
	return {position = position, size = size}

# place room of random (within limits) size
func place_room(position):
	# get size for new room
	var size = Vector2(randi() % 4 + 2, randi() % 4 + 2)
	var top_left_corner = (position - size/2).ceil()
	rooms.append(create_room(position, size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if borders.has_point(new_step):
				step_history.append(new_step)

# get array of rooms of certain size
# used for placing objects in World.gd
func get_rooms():
	var size = rooms.size()
	var newRooms = rooms
	for room in newRooms:
		# get key from dictionary
		for key in room:
			# only check for size of entry
			if key == 'size':
				# delete very small rooms
				if room[key] < Vector2(1,2):
					newRooms.erase(room)
	var newSize = newRooms.size()
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
