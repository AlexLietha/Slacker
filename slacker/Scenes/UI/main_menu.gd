extends CanvasLayer

@onready var button_join: Button = %ButtonJoin
@onready var button_quit: Button = %ButtonQuit
const WORLD = preload("res://Scenes/FunctionalKitchen_multi.tscn")
const PLAYER = preload("res://Scenes/player.tscn")

var args : PackedStringArray

func _ready() -> void:
	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())
	args = OS.get_cmdline_args()
	
	#if OS.has_feature('server'):
		#Network.start_server()
		#add_world()
		#hide()

func on_join() -> void:	
	
	if (!Network.if_server_open):
		Network.start_server()
	
	#add_world()
	hide()
	Network.join_server()
	print("Menu: joined")

func add_world() -> void:
	var new_world = WORLD.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)
	print("World added")
