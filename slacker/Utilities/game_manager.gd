extends Node

var role_manager: RoleManager
var players: Array[Player] = []

func _ready() -> void:
	role_manager = RoleManager.new()
	add_child(role_manager)
	
	# waiting for all players to be loaded, then assign the names
	await get_tree().process_frame
	for p in get_tree().get_nodes_in_group("players"):
		players.append(p)
		p.set_player_name()

# during the open phase, roles are assigned and orders should start spawning
func start_round() -> void:
	role_manager.assign_roles(players)
	OrderSpawner.start_spawning_order()
