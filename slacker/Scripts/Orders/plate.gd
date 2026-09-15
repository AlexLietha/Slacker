extends GrabbableObject
class_name Plate
@export var itemStack : ItemStack


func Grab(grabber : Player):
	
		
	if itemStack and grabber.HasGrabbedItem():
		if itemStack.HasIngredient():
			return
		grabber.getGrabbedItem().plate = self
		AddItem(grabber.getGrabbedItem())
		
		return
	
	super(grabber)

func AddItem(item : GrabbableObject):
	itemStack.AddItem(item)
	
func RemoveItem(item : GrabbableObject):
	itemStack.RemoveItem(item)
	
func GetItem() -> Ingredient:
	return itemStack.ingredient
