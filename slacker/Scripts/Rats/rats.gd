extends Node3D


var rats : Array[rat] = []

@export var num_of_rats := 5

@export var spawn_point = Vector3(0,0,0)

var rat_scene = preload("res://Scenes/Rats/rat.tscn")

# Boundry for finding new point
var min_x : int
var max_x : int
var min_z : int
var max_z : int

func _ready() -> void:
	for i in range(num_of_rats):
		# create new rat
		# set rat position and next path point
		var new_rat = rat_scene.instantiate() as rat
		new_rat.position = spawn_point
		new_rat.add_point(find_new_point())
		
		rats.append(new_rat)

func find_new_point() -> Vector3:
	return Vector3(
		randf_range(min_x, max_x),
		0,
		randf_range(min_z, max_z)
		)
	
