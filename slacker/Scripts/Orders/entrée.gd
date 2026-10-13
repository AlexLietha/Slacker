extends Resource
class_name Entree

@export var ingredients : Array[String]

#func GetQuality() -> float:
	#var qualityTotal = 0
	#for ingredient in ingredients:
		#qualityTotal += ingredient.GetQuality()
	#
	#return qualityTotal / ingredients.size()
	#
#func GetIngredients() -> Array[Ingredient]:
	#return ingredients
