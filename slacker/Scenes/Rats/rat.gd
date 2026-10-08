extends Path3D
class_name rat

var speed := 5
@onready var path_follower = $PathFollow3D
signal finished_path(rat)
func _ready() -> void:
	curve = Curve3D.new()
	
	path_follower.loop = false
	
	
func _process(delta: float) -> void:
	path_follower.progress += speed * delta
	
	if is_equal_approx(path_follower.progress_ratio, 1.0):
		finished_path.emit(self)
	
func add_point(new_position : Vector3):
	curve.add_point(new_position)
	

	

	
