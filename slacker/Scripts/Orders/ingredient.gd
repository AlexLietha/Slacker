extends GrabbableObject
class_name Ingredient


var quality := 100
@export var ingredientName : String = "Ingredient"

var cooking = false

func GetQuality() -> float:
	return quality

func Grab(grabber : Player):
	super(grabber)
	
	cooking = false
	
func cook():
	while true:
		await get_tree().create_timer(10).timeout
		if cooking:
			model.material.albedo_color = Color(0.293, 0.18, 0.146, 1.0)
			SetName("CBP")
		else:
			return
		
	
