extends CanvasLayer

@onready var button_create: Button = %ButtonCreate
@onready var button_join: Button = %ButtonJoin
@onready var button_quit: Button = %ButtonQuit
const WORLD = preload("uid://daoeojhdxrwf4")
const PLAYER = preload("uid://w1hcy6j1i0vj")

var args : PackedStringArray

func _ready() -> void:
	button_create.pressed.connect(on_create)
	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())
	args = OS.get_cmdline_args()
	
	#if OS.has_feature('server'):
		#Network.start_server()
		#add_world()
		#hide()

func on_create() -> void:
	Network.start_server()
	add_world()
	await get_tree().process_frame
	print("Host joined")
	hide()

func on_join() -> void:	
	#if not Network.if_server_open:
		#Network.start_server()
		#add_world()
		#await get_tree().process_frame
		#print("Host joined")
	#else:
		#add_world()
		#await get_tree().process_frame
		#Network.join_server()
		#print("Menu: joined")
	
	add_world()
	Network.join_server()
	hide()
	print("Menu: joined")

func add_world() -> void:
	if get_tree().current_scene.has_node("FunctionalKitchen_multi"):
		return
	
	var new_world = WORLD.instantiate()
	new_world.name = "FunctionalKitchen_multi"
	get_tree().current_scene.add_child.call_deferred(new_world)
	print("World added")
