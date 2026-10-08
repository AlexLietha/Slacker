extends Node

var player_roles = ["Slacker", "Cook", "Rat"]
var players = []
var player = preload("res://Scripts/playerMovement.gd").new()

@export var number_of_slackers = 1

func _ready() -> void:
	await get_tree().process_frame
	players = get_tree().get_nodes_in_group("players")
	for p in players:
		player.set_player_name()

func assign_roles():
	players.shuffle()
	
	for i in range(0, players.size()):
		if i >= 0:
			players[i].role = player_roles[0] # assigns slacker
		else:
			players[i].role = player_roles[2] # assigns cooks
	
	# Debug to see player roles
	print("Roles assigned")
	for p in players:
		print(player.player_name + " is a " + player.role)
