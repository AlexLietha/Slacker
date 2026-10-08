extends Node

var player_roles = ["Slacker", "Cook"]
var players = []
var player_name = preload("res://Scripts/playerMovement.gd").new()

func _ready() -> void:
	await get_tree().process_frame
	players = get_tree().get_nodes_in_group("players")
	for player in players:
		player_name.set_player_name()

func assign_roles():
	players.shuffle()
	
	for i in range(0, players.size()):
		if i < 1: 
			players[i].role = player_roles[i] # assigns slacker and manager
		else:
			players[i].role = player_roles[2] # assigns cooks
	
	print("Roles assigned")
	for player in players:
		print(player.name + " is a " + player.role)
