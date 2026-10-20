extends CharacterBody3D
class_name rat

const SPEED := 5

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent
@export var model: MeshInstance3D

#States
enum State{
	IDLE, MOVING, RETREATING
}
var state: State = State.IDLE

var stuck_timer: float = 0
@export var max_stuck_time = .1
var last_position: Vector3
var stuck_distance := 0.01

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

@export var final_destination : Vector3
var direction : Vector3
func _ready() -> void:
	last_position = global_transform.origin
	
	interactableComponent.GetInteractSignal().connect(interact)
	interactableComponent.GetHoveredSignal().connect(highlight)
	
	highlightComponent.SetShader(model.mesh.material.next_pass)
	
	
	
func _process(_delta: float) -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	#velocity += get_gravity() * delta
	
	match state:
		State.IDLE:
			idle()
		State.MOVING:
			move()
		State.RETREATING:
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


	
func idle():
	velocity = Vector3.ZERO
	var target_position = get_new_target_location()
	
	var nav_map = navigation_agent_3d.get_navigation_map()
	var safe_target = NavigationServer3D.map_get_closest_point(nav_map, target_position)
	navigation_agent_3d.target_position = safe_target
	
	
	state = State.MOVING
	
func move():
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
	if state == State.RETREATING:
		print("rat escaped")
		queue_free()
		return
		
	state = State.IDLE
	



func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = safe_velocity
	#velocity = velocity.move_toward(safe_velocity, .25)
	pass # Replace with function body.

func interact(interactor: Player):
	if !interactor.HasGrabbedItem():
		return
	if interactor.getGrabbedItem() is Broom:
		print("rat swooped")
		swoop()
	
func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
	
func swoop():
	state = State.RETREATING
	navigation_agent_3d.path_desired_distance = .1
	navigation_agent_3d.target_position = final_destination
