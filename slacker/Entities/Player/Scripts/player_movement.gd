extends CharacterBody3D
class_name PlayerMovement

var speed : float = 5.0
var direction := Vector3.ZERO
var headbob_freq : float = 4.0
var headbob_amp : float = 0.02
var headbob_time : float = 0.0
var mouse_sensitivity : float = 0.4
var joypad_sensitivity : float = 5.0
var lerp_speed : float = 10.0
var using_phone : bool = false
var in_minigame : bool = false
var debug_print_source = "[player_movement.gd] - "

@onready var neck: Node3D = $PlayerNeckPivot
@onready var camera: Camera3D = $PlayerNeckPivot/Camera
@onready var player_mesh : MeshInstance3D= $PlayerMesh ## to be removed


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority():
		return
	
	# Add the gravity.
	if !is_on_floor():
		velocity += get_gravity() * delta * 2
	
	# Get the input direction and handle the movement/deceleration.
	if !using_phone && !in_minigame:
		var input_dir := Input.get_vector("moveLeft", "moveRight", 
				"moveForward", "moveBack")
		movement(input_dir, delta)


func _input(event: InputEvent) -> void:
	if !is_multiplayer_authority():
		return
	
	# hides and unhides the mouse cursor
	if event.is_action_pressed("cursorToggle"):
		print(debug_print_source + "CursorToggle")
		
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# if you click on the window after pressing esc you can continue controlling the camera
	#if event is InputEventMouseButton && Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event.is_action_pressed("quit"):
		print(debug_print_source + "Ending process...")
		get_tree().quit()
	
	# debug tool to reassign roles after pressing the ` key
	#if Input.is_action_just_pressed("debugKey"):
		#print("reassignRoles called")
		#GameManager.assign_roles()
	
	# when the mouse is captured move the camera via the mouse or joystick
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var x : float
		var y : float
		if event is InputEventMouseMotion:
			x = deg_to_rad(-event.relative.y * mouse_sensitivity)
			y = deg_to_rad(-event.relative.x * mouse_sensitivity)
			rotate_camera(x, y)
			
		elif event is InputEventJoypadMotion:
			var horizontal_look: float = Input.get_axis("lookLeft", "lookRight")
			var vertical_look: float = Input.get_axis("lookUp", "lookDown")
			x = -vertical_look * joypad_sensitivity
			y = -horizontal_look * joypad_sensitivity
			rotate_camera(x, y)


# inputs rotate the camera around that axis
# i.e. x is up and down, and y is left and right
func rotate_camera(x_axis_rotation: float, y_axis_rotation) -> void:
	rotate_y(y_axis_rotation)
	neck.rotate_x(x_axis_rotation)
	neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func headbob(_headbob_time: float) -> Vector3:
	# uses sin and cos functions to calculate the new position of the camera 
	var headbob_pos = Vector3.ZERO
	headbob_pos.y = sin(_headbob_time * headbob_freq) * headbob_amp
	headbob_pos.x = cos(_headbob_time * headbob_freq/2) * headbob_amp
	return headbob_pos


func movement(input_dir: Vector2, delta: float ):
	# lerps the initial movement so its smoother going from a stand still 
	# to moving and vice versa
	direction = lerp(
			direction, 
			(global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), 
			delta * lerp_speed
			)
	
	# sets velocity based on direction
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()
	
	if velocity.length() > 0.00001:
		# if player is moving adjust the camera position based on the headbob
		headbob_time += delta * velocity.length()
		camera.transform.origin = headbob(headbob_time)
	else:
		# else lerp the camera back to the zero position
		camera.transform.origin = lerp(camera.transform.origin, Vector3.ZERO, delta)


func on_voting_board_toggled(_is_visible: bool) -> void:
	using_phone = _is_visible


## leave for now but should be removed/reworked and put in role system
@export var role = "Cook" ## make into its own resource/object w/ enums
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


#func get_id() -> int:
	#if is_multiplayer_authority():
		#return clientNo
	#return 0
