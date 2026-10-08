extends Node
class_name NameGenerator

var possible_name = ["Bread Pitt", "Giggle Gumbo", "Sunny Souper", 
			"Chirpy Chili", "Tuna Turner", "Gordon Ramsay",
			"Jamie Oliver", "Anthony Bourdain", "Haul Pollywood"]

func _ready() -> void:
	pass
	
func pick_random_name() -> String:
	# Picks a random name from the list of possible names and returns it
	var i = 0
	i = randi() % possible_name.size()
	return possible_name[i]
