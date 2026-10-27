extends GrabbableObject
class_name Ingredient


var quality := 100
@export var ingredientName : String = "Ingredient"

var cooked : bool = false

var cooking = false

func get_quality() -> float:
	return quality
	
func _get_name() -> String:
	return ingredientName
	
func _set_name(_name : String) -> void:
	ingredientName = _name

func grab(grabber : Player):
	super(grabber)
	
	cooking = false
	
func cook():
	print("cooking")
	while true:
		await get_tree().create_timer(10).timeout
		if cooking:
			model.material.albedo_color = Color(0.293, 0.18, 0.146, 1.0)
			cooked = true
			print(cooked)
		else:
			return
		
	
