extends Node

const PLAYER = preload("res://Scenes/player.tscn")
var enet_peer = ENetMultiplayerPeer.new()

var PORT = 1515
var IP_ADDRESS = '127.0.0.1'
var MAX_CLIENTS = 2

func start_server() -> void:
	enet_peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)

func join_server() -> void:
	enet_peer.create_client(IP_ADDRESS, PORT)
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	multiplayer.connected_to_server.connect(on_connected_to_server)
	multiplayer.multiplayer_peer = enet_peer

func on_connected_to_server() -> void:
	add_player(multiplayer.get_unique_id())
	print("Network: Player adding")

func add_player(peer_id: int) -> void:
	if peer_id == 1 and !is_instance_id_valid(peer_id):
		return
	
	var new_player = PLAYER.instantiate()
	new_player.name = str(peer_id)
	get_tree().current_scene.add_child(new_player, true)
	print("Server: Player added with name: " + str(peer_id))

func remove_player(peer_id: int) -> void:
	if peer_id == 1:
		leave_server()
	
	var players: Array[Node] = get_tree().get_nodes_in_group('Players')
	var player_to_remove = players.find_custom(func(item): return item.name == str(peer_id))
	if player_to_remove != -1:
		players[player_to_remove].queue_free()

func leave_server() -> void:
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = null
	clean_up_signals()
	get_tree().reload_current_scene()

func clean_up_signals() -> void:
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(remove_player)
	multiplayer.connected_to_server.disconnect(on_connected_to_server)
