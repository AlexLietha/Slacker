extends GrabbableObject
class_name Plate
@export var itemStack : ItemStack


func grab(grabber : Player) -> void:
	
	if itemStack and grabber.has_grabbed_item():
		grabber.get_grabbed_item().plate = self
		add_item(grabber.get_grabbed_item())
		
		return
	
	super(grabber)

func add_item(item : GrabbableObject):
	itemStack.add_item(item)
	
func remove_item(item : GrabbableObject):
	itemStack.remove_item(item)
	
func get_item() -> Ingredient:
	return itemStack.ingredient
