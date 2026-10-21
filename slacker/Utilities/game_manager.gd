extends Node

var player_roles = ["Slacker", "Cook", "Rat"]
var players = []
#var player_names:Array[String]
var player = preload("uid://dqpaw7ty68pbe").new()

@export var number_of_slackers = 1

func _ready() -> void:
	# waiting for all players to be loaded, then assign the names
	await get_tree().process_frame
	for p in get_tree().get_nodes_in_group("players"):
		p.set_player_name()
		#player_names.push_back("hello")

func assign_roles() -> void:
	players.shuffle()
	for i in range(0, players.size()):
		if i >= (number_of_slackers - 1): # give a slacker role to a player for the number of slackers requested
			players[i].role = player_roles[0]
		else: # everyone else is a cook
			players[i].role = player_roles[1]
	
	player.set_player_role()
