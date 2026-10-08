extends Path3D
class_name rat

func _ready() -> void:
	add_point(position)
	
	
func add_point(new_position : Vector3):
	curve.add_point(new_position)
	print(new_position)
