extends Node3D
class_name ItemStack

var ingredients : Array[Ingredient] = []
var nextItemHeight = 0

func AddItem(item : Ingredient):
	ingredients.append(item)
	
	item.Place(self)
	item.position.y = nextItemHeight
	item.rotation = Vector3.ZERO
	nextItemHeight += item.GetHeight()
	PrintIngredients()
	
func RemoveItem(item : GrabbableObject):
	ingredients.erase(item)
	nextItemHeight -= item.GetHeight()
	PrintIngredients()
	
	
func PrintIngredients() -> void:
	for ingre in ingredients:
		print(ingre.GetName())
