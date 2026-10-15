extends CharacterBody3D
class_name rat

const SPEED := 5


#States
enum State{
	IDLE, MOVING
}
var state: State = State.IDLE

var stuck_timer: float = 0
@export var max_stuck_time = .1
var last_position: Vector3
var stuck_distance := 0.01

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

var direction : Vector3
func _ready() -> void:
	last_position = global_transform.origin
	
	
func _process(_delta: float) -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	#velocity += get_gravity() * delta
	
	match state:
		State.IDLE:
			idle()
		State.MOVING:
			move()
	move_and_slide()
	
	if state == State.MOVING:
		var distance_moved = global_position.distance_to(last_position)

		if distance_moved < stuck_distance:
			stuck_timer += delta
		else:
			stuck_timer = 0.0

		if stuck_timer > max_stuck_time:
			unstuck()

	last_position = global_position


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
func unstuck():
	stuck_timer = 0.0

	velocity = Vector3.ZERO
	navigation_agent_3d.velocity = Vector3.ZERO
	
	var target_position = get_new_target_location()

	var nav_map = navigation_agent_3d.get_navigation_map()

	var safe_target = NavigationServer3D.map_get_closest_point(
	nav_map,
	target_position
	)

	navigation_agent_3d.target_position = safe_target

func get_new_target_location() -> Vector3:
	return global_transform.origin + Vector3(randf_range(-30, 30), 0, randf_range(-30, 30))


func _on_navigation_agent_3d_target_reached() -> void:
	#print("reached area")
	state = State.IDLE
	



func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = safe_velocity
	#velocity = velocity.move_toward(safe_velocity, .25)
	pass # Replace with function body.
