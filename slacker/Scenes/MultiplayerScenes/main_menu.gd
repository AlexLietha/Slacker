extends CanvasLayer

@onready var button_join: Button = %ButtonJoin
@onready var button_quit: Button = %ButtonQuit
const WORLD_FOREST = preload("res://Scenes/MultiplayerScenes/world_main.tscn")
const PLAYER = preload("res://Scenes/MultiplayerScenes/playerMult.tscn")

func _ready() -> void:
	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())
	
	if OS.has_feature('server'):
		Network.start_server()
		add_world()
		hide()

func on_join() -> void:
	Network.join_server()
	add_world()
	hide()
	print("Menu: joined")

func add_world() -> void:
	var new_world = WORLD_FOREST.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)
