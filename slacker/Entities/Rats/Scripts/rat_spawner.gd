extends Node3D


var rats : Array[rat] = []

@export var num_of_rats := 20
@export var spawn_point = Vector3(0,0,0)


var rat_scene = preload("uid://b8hneupbcyrxf")




func _ready() -> void:
	for i in range(num_of_rats):
		#Step 1: Spawn Rat
		var new_rat = rat_scene.instantiate() as rat
		add_child(new_rat)
		rats.append(new_rat)
		await get_tree().create_timer(.5).timeout

		

		
