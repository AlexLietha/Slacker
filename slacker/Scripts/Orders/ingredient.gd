extends Resource
class_name Ingredient
var quality := 100
@export var ingredientName : String = "Ingredient"

func GetQuality() -> float:
	return quality
