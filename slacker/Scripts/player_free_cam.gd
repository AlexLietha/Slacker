extends CharacterBody3D
class_name PlayerFreeCam

@export var speed := 5.0
@export var mouseSensitivity := 0.004
@export var joypadSensitivity := 5
@export var player_name = "FreeCam" # temp name
@export var collision = true

@onready var camera = $Camera3D
@onready var collider = $CamCollision
@onready var vote_UI := $VotingBoard
@onready var player_overhead_name = $PlayerName

@export var grabbedItem : Node3D

var counter: int = 0;
var name_generator = preload("res://Scripts/NameGenerator.gd").new()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	vote_UI.visible = false

	update_collision()

func _process(delta: float) -> void:
	var horizontal_look: float = Input.get_axis("lookLeft", "lookRight")
	rotate_y(-horizontal_look * joypadSensitivity * delta)

	var vertical_look: float = Input.get_axis("lookUp", "lookDown")
	camera.rotate_x(-vertical_look * joypadSensitivity * delta)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack")
	var direction: Vector3 = (camera.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	direction = direction.normalized()

	velocity = direction * speed

	move_and_slide()

func _input(event):
	# Camera Controls
	if event is InputEventMouseMotion and Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		rotate_y(-event.relative.x * mouseSensitivity)
		camera.rotate_x(-event.relative.y * mouseSensitivity)
		camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-90),deg_to_rad(90))

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
func update_collision():
	collider.disabled = not collision
