extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent
@export var idComponent: IDComponent

@export var model: CSGBox3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(GrillItem)
	interactableComponent.GetHoveredSignal().connect(highlight)
	
	highlightComponent.SetShader(model.material.next_pass)
	
func GrillItem(player : Player):
	var item = player.getGrabbedItem()
	
	if item:
		item.cook()
		
		
func highlight(interactor: Player, highlighted: bool):
	if not interactor.HasGrabbedItem(): 
		highlightComponent.highlight(interactor, false)
		return
	if interactor.getGrabbedItem().GetName() == "rawBurgerPatty":
		highlightComponent.highlight(interactor, highlighted)
	else:
		highlightComponent.highlight(interactor, false)
	
