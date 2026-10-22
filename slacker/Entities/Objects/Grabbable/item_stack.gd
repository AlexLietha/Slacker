extends Node3D
class_name ItemStack

var ingredient : Ingredient
var nextItemHeight = 0

func add_item(item : Ingredient):
	ingredient = item
	
	item.place(self)
	item.position.y = nextItemHeight
	item.rotation = Vector3.ZERO
	nextItemHeight += item.get_height()
	print_ingredient()
	
func remove_item(item : GrabbableObject):
	ingredient = null
	nextItemHeight -= item.get_height()
	print_ingredient()
	
	
func print_ingredient() -> void:
	print(ingredient)
