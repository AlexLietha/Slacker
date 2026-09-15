extends Node3D
class_name ItemStack

var ingredient : Ingredient
var nextItemHeight = 0

func AddItem(item : Ingredient):
	ingredient = item
	
	item.Place(self)
	item.position.y = nextItemHeight
	item.rotation = Vector3.ZERO
	nextItemHeight += item.GetHeight()
	PrintIngredients()
	
func RemoveItem(item : GrabbableObject):
	ingredient = null
	nextItemHeight -= item.GetHeight()
	PrintIngredients()
	
	
func PrintIngredients() -> void:
	if ingredient:
		print(ingredient.GetName())

func HasIngredient() -> bool:
	return ingredient != null
