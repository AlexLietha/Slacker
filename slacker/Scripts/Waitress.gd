extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var idComponent: IDComponent

func _ready() -> void:
	interactableComponent.interacted.connect(GiveFood)

func GiveFood(player: CharacterBody3D):
	if player.get_child(4).get_child_count() == 0:
		return
	
	var item : GrabbableObject = player.get_child(4).get_child(0)
	
	if item is GrabbableObject:
		player.get_child(4).remove_child(item)
		OrderManager.report_event("Deliver", "waitress", 1)
