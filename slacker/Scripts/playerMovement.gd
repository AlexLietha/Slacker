extends CharacterBody3D
class_name Player

@export var speed := 5.0
@export var jumpVelocity := 5
@export var mouseSensitivity := 0.004

@onready var camera = $Camera3D
@onready var nameplate: Label3D = $Nameplate

@export var interactionRayCast : RayCast3D
@export var grabbedItem : Node3D

func _enter_tree() -> void:
	set_multiplayer_authority(int(name))
	print(name)

func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	add_to_group("Players")
	nameplate.text = name
	
	if is_multiplayer_authority():
		camera.current = true
		print("Player Auth = true")

func _input(event: InputEvent):
	if not is_multiplayer_authority():
		return
	
	# Camera Controls
	if event is InputEventMouseMotion: #and Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		rotate_y(-event.relative.x * mouseSensitivity)
		camera.rotate_x(-event.relative.y * mouseSensitivity)
		camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-89),deg_to_rad(89))
	
	if Input.is_action_just_pressed("reassignRoles"):
		print("reassignRoles called")
		GameManager.assign_roles()
	
	if Input.is_action_just_pressed("quit"):
		Network.leave_server()
		
	if Input.is_action_just_pressed("drop"):
		if HasGrabbedItem():
			getGrabbedItem().drop()
		pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump. (Don't need jump)
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

func getGrabbedItem() -> GrabbableObject:
	if not HasGrabbedItem():
		return null
	return grabbedItem.get_child(0)

func HasGrabbedItem() -> bool:
	return grabbedItem.get_child_count() == 1
