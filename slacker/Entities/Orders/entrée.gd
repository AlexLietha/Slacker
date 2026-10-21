extends Order
class_name Entree

@export var ingredients : Array[String]

#func get_quality() -> float:
	#var qualityTotal = 0
	#for ingredient in ingredients:
		#qualityTotal += ingredient.GetQuality()
	#
	#return qualityTotal / ingredients.size()
	#
#func get_ingredients() -> Array[Ingredient]:
	#return ingredients
