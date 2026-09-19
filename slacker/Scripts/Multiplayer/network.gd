extends Node

const PLAYER = preload("res://Scenes/player.tscn")

var enet_peer = ENetMultiplayerPeer.new()

const PORT = 1515
const IP_ADDRESS = "127.0.0.1"
const MAX_CLIENTS = 3


func start_server() -> void:
	enet_peer.create_server(PORT, MAX_CLIENTS)

	multiplayer.multiplayer_peer = enet_peer

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)

	print("Server started")


func join_server() -> void:
	enet_peer.create_client(IP_ADDRESS, PORT)

	multiplayer.connected_to_server.connect(on_connected_to_server)

	multiplayer.multiplayer_peer = enet_peer

	print("Server joined")


func on_connected_to_server() -> void:
	print("Connected to server!")
	print("My Peer ID: " + str(multiplayer.get_unique_id()))


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


@rpc("authority", "reliable")
func spawn_player(peer_id: int) -> void:
	var new_player = PLAYER.instantiate()
	new_player.name = str(peer_id)
	new_player.set_multiplayer_authority(peer_id)
	
	get_tree().current_scene.add_child(new_player, true)
	print("=== PLAYER SPAWNED ===")
	print("Player ID: " + str(peer_id))
	print("My Peer ID: " + str(multiplayer.get_unique_id()))
	print("Authority: " + str(new_player.get_multiplayer_authority()))


func remove_player(peer_id: int) -> void:
	var player = get_tree().current_scene.get_node_or_null(str(peer_id))

	if player:
		player.queue_free()

	print("Player removed: " + str(peer_id))
