extends Node

const PLAYER = preload("res://Scenes/player.tscn")
const TIMER = preload("res://UI/TimerUI.tscn")
const WORLD = preload("res://Scenes/FunctionalKitchen_multi.tscn")

## takes request_id : int and spawn_args : Disctionary
var validate_spawn_callable : Callable

var enet_peer = ENetMultiplayerPeer.new()
var server_time: float = 0.0
var game_started:= false
var if_server_open := false
var wifi_port = false

@export var PORT = 1515
@export var IP_ADDRESS = "127.0.0.1"
const MAX_CLIENTS = 3

#This will be set to your computers IP address
#You will get it when it's attacheted to the wifi box
#the implementation for this will happen when we get access to the box
var new_ip = "0.0.0.0" 

func _process(delta: float) -> void:
	if multiplayer.is_server():
		server_time += delta
	pass

func start_server() -> void:
	enet_peer.set_bind_ip(new_ip)
	
	var error = enet_peer.create_server(PORT, MAX_CLIENTS)
	if error != OK:
		print("Server failed to start")
		return
	
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	
	#join_server()
	print("Server started")
	if_server_open = true
	
	spawn_player.rpc(multiplayer.get_unique_id())

func join_server() -> void:
	enet_peer.create_client(IP_ADDRESS, PORT)
	multiplayer.connected_to_server.connect(on_connected_to_server)
	multiplayer.multiplayer_peer = enet_peer
	print("Server joined")

func on_connected_to_server() -> void:
	print("Connected to server!")
	print("My Peer ID: " + str(multiplayer.get_unique_id()))
	#rpc_id(1, "fetch_server_time", Time.get_datetime_dict_from_system())

func fetch_server_time(client_time) -> void:
	var player_id = get_tree().get_rpc_sender_id()
	rpc_id(player_id, "return_server_time", Time.get_datetime_dict_from_system(), client_time)

func add_player(peer_id: int) -> void:
	print("=== ADDING PLAYER ===")
	print("Peer ID: " + str(peer_id))
	# Spawn the new player on every peer
	spawn_player.rpc(peer_id)
	
	# Give the newly connected client all existing players
	for player in get_tree().get_nodes_in_group("Players"):
		var existing_id := int(player.name)
		if existing_id != peer_id:
			spawn_player.rpc_id(peer_id, existing_id)

@rpc("authority", "call_local", "reliable")
func spawn_player(peer_id: int) -> void:
	if get_tree().current_scene.has_node(str(peer_id)):
		print("Player already exists")
		return
	
	var new_player = PLAYER.instantiate()
	new_player.name = str(peer_id)
	new_player.set_multiplayer_authority(peer_id)
	
	get_tree().current_scene.add_child(new_player, true)
	print("=== PLAYER SPAWNED ===")
	print("Player ID: " + str(peer_id))
	print("Authority: " + str(new_player.get_multiplayer_authority()))

func remove_player(peer_id: int) -> void:
	var player = get_tree().current_scene.get_node_or_null(str(peer_id))
	if player:
		player.queue_free()
	print("Player removed: " + str(peer_id))

@rpc("authority", "call_local", "reliable")
func game_started_rpc() -> void:	
	var round_timer = get_tree().get_first_node_in_group("RoundTimer")
	if round_timer == null:
		print("Timer not found")
		return
	
	print("Timer found")
	round_timer.start_game()

func start_game() -> void:
	if multiplayer.is_server():
		game_started_rpc()
	else:
		rpc_id(1, "request_start_game")

@rpc("any_peer", "reliable")
func request_start_game() -> void:
	if not multiplayer.is_server():
		return
	
	game_started_rpc()

#this is currently not being called so it is not needed
@rpc("authority", "call_local", "reliable")
func add_world_rpc() -> void:
	var new_world = WORLD.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)
	print("World added network")

@rpc("any_peer", "call_local", "reliable")
func request_spawn_object(spawn_args: Dictionary) -> void:
	var request_id = multiplayer.get_remote_sender_id()
	
	if not spawn_args.has("resource_path"):
		print("No recourse given to spawn")
		return
	
	var resource_path = spawn_args["resource_path"]
	
	if resource_path is not String:
		print("Resource is not of correct type")
		return
	
	if !ResourceLoader.exists(resource_path) || !resource_path.begins_with("res://"):
		print("Invalid recourse")
		return
	
	if validate_spawn_callable:
		if validate_spawn_callable.call(request_id, spawn_args):
			spawn_object_rpc.rpc()
	else:
		spawn_object_rpc.rpc()

@rpc("authority", "call_local", "reliable")
func spawn_object_rpc(owner_id: int, object: String) -> void:
	var itemScene = load(object) as PackedScene
	if itemScene == null:
		print("Network: Item was null")
		return
	
	var owner: Player = get_tree().current_scene.find_child(str(owner_id))
	if owner == null:
		print("Network: Player was null: ", str(owner_id))
		return
	
	var newItem = itemScene.instantiate()
	get_tree().current_scene.add_child(newItem, true)
	newItem.Grab(owner)
	pass
