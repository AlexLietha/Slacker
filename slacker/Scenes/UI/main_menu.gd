extends CanvasLayer

@onready var button_join: Button = %ButtonJoin
@onready var button_quit: Button = %ButtonQuit
const WORLD = preload("res://Scenes/test.tscn")
const PLAYER = preload("res://Scenes/player.tscn")

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
	var new_world = WORLD.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)
	print("World added")
