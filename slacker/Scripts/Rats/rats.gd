extends Node3D


var rats : Array[rat] = []

@export var num_of_rats := 20

@export var spawn_point = Vector3(0,0,0)

var rat_scene = preload("res://Scenes/Rats/rat.tscn")

# Boundry for finding new point
var min_x : int = -5
var max_x : int = 5
var min_z : int = -5
var max_z : int = 5

func _ready() -> void:
	for i in range(num_of_rats):
		# create new rat
		# set rat position and next path point
		var new_rat = rat_scene.instantiate() as rat
		add_child(new_rat)
		
		new_rat.add_point(spawn_point)
		set_next_curve_point(new_rat)
		new_rat.finished_path.connect(set_next_curve_point)
		rats.append(new_rat)

func get_new_point(current_pos : Vector3 = Vector3.ZERO) -> Vector3:
	var new_point
	if current_pos == Vector3.ZERO:
		print("no argument passed")
		new_point = Vector3(
		randf_range(min_x, max_x),
		0,
		randf_range(min_z, max_z)
		)
	else:
		new_point = Vector3(
		current_pos.x + randf_range(min_x, max_x),
		0,
		current_pos.z + randf_range(min_z, max_z)
		)
	
		
	return new_point
	
func set_next_curve_point(remy : rat) -> void:
	var next_point = get_new_point(remy.position)
	while true:
		if check_if_point_valid(next_point):
			remy.add_point(next_point)
			return
		
		
	
	
	
func check_if_point_valid(point : Vector3) -> bool:
	var flag = true
	
	# point is out of bounds
	if point.x < min_x || point.x > max_x || point.z < min_z || point.z > max_z:
		flag = false
	
	return flag

	
