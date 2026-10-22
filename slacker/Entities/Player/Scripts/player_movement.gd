extends CharacterBody3D
class_name Player

@export var speed := 5.0
@export var jumpVelocity := 5
@export var mouseSensitivity := 0.004
@export var joypadSensitivity := 5
@export var role = "Cook"
@export var player_name = "PlayerName" # temp name

@onready var camera = $Camera3D
@onready var player_mesh := $PlayerMesh
@onready var vote_ui := $VotingBoard
@onready var player_overhead_name = $PlayerName

@export var interactionRayCast : RayCast3D
@export var grabbedItem : Node3D
@export var vote_pop_up_ui = Control

var use_phone : bool = false
var name_generator = preload("uid://dleg4tpvbkn2q").new()

var debug_print_source = "[player_movement.gd] - "

# Multiplier stuff. Having this code uncommented when testing breaks the player
#func _enter_tree() -> void:
	#print(debug_print_source + "Player enter tree " + name)
	#print(debug_print_source + "Authroity: " + str(get_multiplayer_authority()))
	#set_multiplayer_authority(name.to_int())

func _ready() -> void:
	add_to_group("players")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	vote_ui.visible = false
	vote_ui.closeUI.connect(hide_vote_ui)
	
	if !is_multiplayer_authority():
		set_process(false)
		set_physics_process(false)
		camera.current = false
		return
	
	camera.current = true
	print(debug_print_source + "Player Auth: " + str(get_multiplayer_authority()))

func set_player_name():
	player_name = name_generator.pick_random_name()
	player_overhead_name.text = player_name
	print(debug_print_source + "Player Name: " + player_name)
	
func get_player_name():
	return player_name
	
func set_player_role():
	if role == "Cook":
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.BLUE
		if player_mesh != null:
			player_mesh.material_override = material
		
	if role == "Slacker":
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.RED
		if player_mesh != null:
			player_mesh.material_override = material
			
	if role == "Rat":
		pass

func _process(delta: float) -> void:
	var horizontal_look: float = Input.get_axis("lookLeft", "lookRight")
	rotate_y(-horizontal_look * joypadSensitivity * delta)

	var vertical_look: float = Input.get_axis("lookUp", "lookDown")
	camera.rotate_x(-vertical_look * joypadSensitivity * delta)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
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
	if !is_multiplayer_authority(): return
	
	# Camera Controls
	if event is InputEventMouseMotion and Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		rotate_y(-event.relative.x * mouseSensitivity)
		camera.rotate_x(-event.relative.y * mouseSensitivity)
		camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-89),deg_to_rad(89))

	# debug tool to reassign roles after pressing the ` key
	#if Input.is_action_just_pressed("debugKey"):
		#print("reassignRoles called")
		#GameManager.assign_roles()
	
	if Input.is_action_just_pressed("debugKey"):
		print(debug_print_source + "debug key called")
		vote_pop_up_ui.has_been_voted()
		
	if Input.is_action_just_pressed("cursorToggle"):
		print(debug_print_source + "CursorToggle")
		
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if Input.is_action_just_pressed("quit"):
		print(debug_print_source + "Ending process...")
		get_tree().quit()
		
	if Input.is_action_just_pressed("drop"):
		if has_grabbed_item():
			get_grabbed_item().drop()
		pass
		
	if(Input.is_action_just_pressed("usePhone") && !use_phone):
		show_vote_ui()
		use_phone = true
		
	elif((Input.is_action_just_pressed("usePhone") || Input.is_action_just_pressed("controllerXboxB")) && use_phone):
		hide_vote_ui()
		await get_tree().process_frame
		use_phone = false


func get_grabbed_item() -> GrabbableObject:
	if not has_grabbed_item():
		return null
	return grabbedItem.get_child(0)

func has_grabbed_item() -> bool:
	return grabbedItem.get_child_count() == 1

func show_vote_ui() -> void:
	vote_ui.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func hide_vote_ui() -> void:
	vote_ui.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
