# Aidan Musil
# Assigns roles to each player. Each role is a resource of type PlayerRole

extends Node
class_name RoleManager

@export var number_of_slackers: int = 1

@export var cook_role: PlayerRole = preload("uid://c44mkmujarf87")
@export var slacker_role: PlayerRole = preload("uid://2n6elfq1ct8e")
@export var rat_role: PlayerRole = preload("uid://bigqeq7j11kfe")

func assign_roles(players: Array) -> void:
	var shuffled_players = players.duplicate()
	shuffled_players.shuffle()
	
	for i in range(shuffled_players.size()):
		if i < number_of_slackers:
			shuffled_players[i].set_player_role(slacker_role)
		else:
			shuffled_players[i].set_player_role(cook_role)
