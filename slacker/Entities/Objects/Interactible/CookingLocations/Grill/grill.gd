extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent
@export var idComponent: IDComponent

@export var model: CSGBox3D

@export var itemName := "Pancake"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(grill_item)
	interactableComponent.GetHoveredSignal().connect(highlight)
	
	if highlightComponent:
		highlightComponent.SetShader(model.material.next_pass)
	
func grill_item(player : Player):
	var item = player.get_grabbed_item()
	if not item:
		return
	if item._get_name() != itemName:
		return
	
	item.place(self)
	
	item.cooking = true
	item.cook()

		
		
func highlight(interactor: Player, highlighted: bool):
	if not interactor.has_grabbed_item(): 
		highlightComponent.highlight(interactor, false)
		return
	if interactor.get_grabbed_item()._get_name() == itemName:
		highlightComponent.highlight(interactor, highlighted)
	else:
		highlightComponent.highlight(interactor, false)
	
