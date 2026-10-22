extends MultiplayerSpawner

@export var network_player: PackedScene
@export var players_container: Node3D


func _ready() -> void:
	# The Players node must be a child of the same parent as this spawner.
	spawn_path = "../Players"

	# Godot calls this function on each peer when a player is spawned.
	spawn_function = _spawn_custom_player

	if not multiplayer.peer_connected.is_connected(_on_peer_connected):
		multiplayer.peer_connected.connect(_on_peer_connected)

	if not multiplayer.peer_disconnected.is_connected(_on_peer_disconnected):
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)

	print("MultiplayerSpawner ready.")
	print("Spawn path: ", spawn_path)
	
	
	if not multiplayer.peer_connected.is_connected(_on_peer_connected_debug):
		multiplayer.peer_connected.connect(_on_peer_connected_debug)

	if not multiplayer.connected_to_server.is_connected(_on_connected_debug):
		multiplayer.connected_to_server.connect(_on_connected_debug)

	if not multiplayer.connection_failed.is_connected(_on_connection_failed_debug):
		multiplayer.connection_failed.connect(_on_connection_failed_debug)


func _on_peer_connected_debug(id: int) -> void:
	print("LOBBY SCRIPT: Peer connected: ", id)


func _on_connected_debug() -> void:
	print("LOBBY SCRIPT: Connected to multiplayer server!")
	print("My peer ID: ", multiplayer.get_unique_id())


func _on_connection_failed_debug() -> void:
	print("LOBBY SCRIPT: Multiplayer connection failed!")


# Called by the host after creating the multiplayer session.
func spawn_host() -> void:
	if not multiplayer.is_server():
		push_warning("Only the server can spawn the host player.")
		return

	_spawn_player(multiplayer.get_unique_id())


# Called on the server when another peer connects.
func _on_peer_connected(id: int) -> void:
	print("SPAWNER: peer_connected fired. ID: ", id)
	print("SPAWNER: is_server = ", multiplayer.is_server())
	print("SPAWNER: unique ID = ", multiplayer.get_unique_id())

	if multiplayer.is_server():
		print("SPAWNER: Requesting spawn for peer ", id)
		_spawn_player(id)



# Only the server requests player creation.
func _spawn_player(id: int) -> void:
	if not multiplayer.is_server():
		return

	if network_player == null:
		push_error("Assign Network Player in the Inspector.")
		return

	if players_container == null:
		push_error("Assign Players Container in the Inspector.")
		return

	if players_container.has_node(str(id)):
		print("Player already exists: ", id)
		return

	print("Spawning player for peer: ", id)
	spawn(id)


# Called by MultiplayerSpawner on each peer.
# Do not call add_child() here; the spawner adds the returned node.
func _spawn_custom_player(data: Variant) -> Node:
	print("SPAWNER: Creating player instance. Data: ", data)
	var player_id: int = int(data)
	var player: Node = network_player.instantiate()

	player.name = str(player_id)
	player.set_multiplayer_authority(player_id, true)

	print("Created player instance for peer: ", player_id)
	return player


# The server removes disconnected players.
func _on_peer_disconnected(id: int) -> void:
	if not multiplayer.is_server():
		return
		
	var player = players_container.get_node_or_null(str(id))
	if player:
		print("Removing disconnected player: ", id)
		player.queue_free()
