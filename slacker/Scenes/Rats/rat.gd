extends CharacterBody3D
class_name rat

const SPEED := 5


#States
enum State{
	IDLE, MOVING
}
var state: State = State.IDLE

var wait_time: float = 1.0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

var direction : Vector3
func _ready() -> void:
	pass
	#curve = Curve3D.new()
	
	#path_follower.loop = false
	
	
func _process(delta: float) -> void:
	pass
	#Step 3: Move rat
	#path_follower.progress += SPEED * delta
	
	#Step 4: Rat reaches position
	#if is_equal_approx(path_follower.progress_ratio, 1.0):
		#finished_path.emit(self)
	
func _physics_process(delta: float) -> void:
	#velocity += get_gravity() * delta
	
	match state:
		State.IDLE:
			idle()
		State.MOVING:
			move()
	move_and_slide()

#func add_point(new_position : Vector3):
	#curve.add_point(new_position)
	
func idle():
	#print("idle")
	velocity = Vector3.ZERO
	var target_position = get_new_target_location()
	
	var nav_map = navigation_agent_3d.get_navigation_map()
	#sawait NavigationServer3D.map_changed
	print("map changed")
	var safe_target = NavigationServer3D.map_get_closest_point(nav_map, target_position)
	navigation_agent_3d.target_position = safe_target
	print(position)
	print(global_transform.origin)

	print(target_position)
	
	state = State.MOVING
	
func move():
	#print("Moving")
	var current_position = global_transform.origin
	var next_position = navigation_agent_3d.get_next_path_position()
	direction = (next_position - current_position).normalized()
	navigation_agent_3d.velocity = direction * SPEED

func get_new_target_location() -> Vector3:
	return global_transform.origin + Vector3(randf_range(-10, 10), 0, randf_range(-10, 10))


func _on_navigation_agent_3d_target_reached() -> void:
	#print("reached area")
	state = State.IDLE
	



func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	#velocity = safe_velocity
	velocity = velocity.move_toward(safe_velocity, .25)
	pass # Replace with function body.
