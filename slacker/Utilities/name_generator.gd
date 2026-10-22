extends Node
class_name NameGenerator

var possible_names = ["Bread Pitt", "Giggle Gumbo", "Sunny Souper", 
			"Chirpy Chili", "Tuna Turner", "Gordon Ramsay", 
			"Jamie Oliver", "Anthony Bourdain", "Haul Pollywood"]
			
var professor_names = [
	"Seth Blueberrier",		# Seth Berrier
	"Scott Turnip",			# Scott Turner
	"Andrew Grill-iams",	# Andrew Williams
	"Kimchi Loken", 		# Kim Loken
	"Kaelie Tetzloaf", 		# Kaelie Tetzlaff
	"Dave Beckfast",		# Dave Beck
	"Karl Cookie",			# Karl Koehle 
	"Cody Rye-Bread"		# Cody Reimer
]

func _ready() -> void:
	possible_names.append(professor_names)
	
func pick_random_name() -> String:	# Picks a random name from the list of possible names and returns it
	return possible_names.pick_random()
