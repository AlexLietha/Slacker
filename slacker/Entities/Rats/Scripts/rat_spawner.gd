extends Node3D


var rats : Array[rat] = []

@export var num_of_rats := 20
@export var spawn_point = Vector3(0,0,0)


var rat_scene = preload("uid://b8hneupbcyrxf")
signal rats_spawned



func _ready() -> void:
	summon_the_rats()

		
func summon_the_rats() -> void:
	for i in range(num_of_rats):
		#Step 1: Spawn Rat
		var new_rat = rat_scene.instantiate() as rat
		add_child(new_rat)
		new_rat.final_destination = position
		rats.append(new_rat)
		await get_tree().create_timer(1).timeout
		
func get_rat_signal() -> Signal:
	return rats_spawned


		
