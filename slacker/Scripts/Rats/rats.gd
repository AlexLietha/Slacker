extends Node3D


var rats : Array[rat] = []

@export var num_of_rats := 20
@export var spawn_point = Vector3(0,0,0)
@export var collision_checker: Area3D

var rat_scene = preload("uid://b8hneupbcyrxf")

# Boundry for finding new point
var min_x : int = -8
var max_x : int = 8
var min_z : int = -5
var max_z : int = 5



func _ready() -> void:
	collision_checker.position = Vector3(-.4, -.125, 5.5)
	for i in range(num_of_rats):
		#Step 1: Spawn Rat
		var new_rat = rat_scene.instantiate() as rat
		add_child(new_rat)
		
		#Step 2: Give rat new position
		#new_rat.add_point(spawn_point)
		set_next_curve_point(new_rat)
		
		
		new_rat.finished_path.connect(set_next_curve_point)
		rats.append(new_rat)
		
#func _process(delta: float) -> void:
	#if collision_checker.has_overlapping_areas():
		#print("in area")
		
func set_next_curve_point(curr_rat : rat) -> void:
	var next_point = get_new_point(curr_rat.position)
	while true:
		if check_if_point_valid(next_point):
			#curr_rat.add_point(next_point)
			return
		

func get_new_point(current_pos : Vector3) -> Vector3:
	#var new_point = Vector3(
	#current_pos.x + randf_range(min_x, max_x),
	#0,
	#current_pos.z + randf_range(min_z, max_z)
	#)
	var new_point = Vector3(
		randf_range(min_x, max_x),
		0,
		randf_range(min_z, max_z)
		)

	return new_point
	

		
	
	
	
func check_if_point_valid(point : Vector3) -> bool:
	var flag = true
	
	# point is out of bounds
	if point.x < min_x || point.x > max_x || point.z < min_z || point.z > max_z:
		flag = false
		
	collision_checker.visible = true
	collision_checker.position = point
	
	if collision_checker.has_overlapping_areas():
		print("point not accessible")
		flag = false
	
	collision_checker.visible = false
	return flag

	


func _collision_checker_entered(area: Area3D) -> void:
	print("checker in area")
	pass # Replace with function body.
