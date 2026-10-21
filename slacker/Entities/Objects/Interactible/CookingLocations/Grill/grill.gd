extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent
@export var idComponent: IDComponent

@export var model: CSGBox3D

@export var itemName := "Burger"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(GrillItem)
	interactableComponent.GetHoveredSignal().connect(highlight)
	
	if highlightComponent:
		highlightComponent.SetShader(model.material.next_pass)
	
func GrillItem(player : Player):
	var item = player.getGrabbedItem()
	if not item:
		return
	if item.GetName() != itemName:
		return
	
	item.Place(self)
	
	item.cooking = true
	item.cook()

		
		
func highlight(interactor: Player, highlighted: bool):
	if not interactor.HasGrabbedItem(): 
		highlightComponent.highlight(interactor, false)
		return
	if interactor.getGrabbedItem().GetName() == itemName:
		highlightComponent.highlight(interactor, highlighted)
	else:
		highlightComponent.highlight(interactor, false)
	
