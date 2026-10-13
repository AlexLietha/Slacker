extends Node

var player_roles = ["Slacker", "Cook", "Rat"]
var players = []
var Player = preload("uid://dqpaw7ty68pbe").new()

@export var number_of_slackers = 1

func _ready() -> void:
	# waiting for all players to be loaded, then assign the names
	await get_tree().process_frame
	for player in get_tree().get_nodes_in_group("players"):
		player.set_player_name()

func assign_roles() -> void:
	players.shuffle()
	for i in range(0, players.size()):
		if i >= (number_of_slackers - 1): # give a slacker role to a player for the number of slackers requested
			players[i].role = player_roles[0]
		else: # everyone else is a cook
			players[i].role = player_roles[1]
	
	Player.set_player_role()
