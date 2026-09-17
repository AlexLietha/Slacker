extends CharacterBody3D
class_name Player

@export var speed := 5.0
@export var jumpVelocity := 5
@export var mouseSensitivity := 0.004
@export var role = "Cook"

@onready var camera = $Camera3D
@onready var hat := $Camera3D/Hat
@onready var player_mesh := $PlayerMesh

@export var interactionRayCast : RayCast3D
@export var grabbedItem : Node3D

func _ready() -> void:
	add_to_group("players")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	
	if role == "Manager":
		hat.show()
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.WHITE
		player_mesh.material_override = material
		
	if role == "Cook":
		hat.hide()
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.BLUE
		player_mesh.material_override = material
		
	if role == "Slacker":
		hat.hide()
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.RED
		player_mesh.material_override = material
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jumpVelocity

	var input_dir := Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:

		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
	else:
		
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


func _input(event):
	# Camera Controls
	if event is InputEventMouseMotion and Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		rotate_y(-event.relative.x * mouseSensitivity)
		camera.rotate_x(-event.relative.y * mouseSensitivity)
		camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-89),deg_to_rad(89))
	
	if Input.is_action_just_pressed("reassignRoles"):
		print("reassignRoles called")
		GameManager.assign_roles()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("drop"):
		if HasGrabbedItem():
			getGrabbedItem().drop()
		pass

func getGrabbedItem() -> GrabbableObject:
	if not HasGrabbedItem():
		return null
	return grabbedItem.get_child(0)
	
func HasGrabbedItem() -> bool:
	return grabbedItem.get_child_count() == 1
		
