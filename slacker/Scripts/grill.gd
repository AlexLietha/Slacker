extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var idComponent: IDComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactableComponent.interacted.connect(GrillItem)
	
	
func GrillItem(player : CharacterBody3D):
	if player.get_child(4).get_child_count() == 0:
		return
	
	var item : GrabbableObject = player.get_child(4).get_child(0)
	
	if item is GrabbableObject:
		item.cook()
