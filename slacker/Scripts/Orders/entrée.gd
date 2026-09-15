extends Resource
class_name entree

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
