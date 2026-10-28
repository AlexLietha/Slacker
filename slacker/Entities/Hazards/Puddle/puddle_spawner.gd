# Aidan Musil
# This script spawns puddles!

extends Node3D
class_name PuddleSpawner

@export var puddle_scene: PackedScene
@export var puddle_spawn_radius: float = 5 # I recommend using a range between 3.5 and 5.5

@export var min_spawn_time: float = 1.0
@export var max_spawn_time: float = 3.0

@export var min_final_puddles: int = 3
@export var max_final_puddles: int = 5

var puddle_timer: Timer
var is_spawning: bool = false

func _ready() -> void:
	puddle_timer = Timer.new()
	puddle_timer.one_shot = true
	
	add_child(puddle_timer)
	puddle_timer.timeout.connect(on_puddle_timer_timeout)
	
	
func start_spawning() -> void:
	is_spawning = true
	start_puddle_timer()
	
	
func stop_spawning() -> void:
	is_spawning = false
	puddle_timer.stop()
	
	
func spawn_big_splash() -> void:
	var puddle_count = randi_range(min_final_puddles, max_final_puddles)
	
	for i in range(puddle_count):
		spawn_puddle()
		
		
func start_puddle_timer() -> void:
	var random_time = randf_range(min_spawn_time, max_spawn_time)
	puddle_timer.start(random_time)


func on_puddle_timer_timeout() -> void:
	if is_spawning:
		spawn_puddle()
		start_puddle_timer()
		
		
func spawn_puddle() -> void:
	if puddle_scene == null:
		return
		
	var puddle: Puddle = puddle_scene.instantiate()
	get_tree().current_scene.add_child(puddle)
	
	var angle = randf_range(0.0, PI * 2)
	var distance = sqrt(randf()) * puddle_spawn_radius
	var offset = Vector3(cos(angle) * distance, 0.0, sin(angle) * distance)
	
	puddle.rotation.y = randf_range(0.0, PI * 2)
	
	puddle.global_position = global_position + offset
	puddle.spawn_puddle()
