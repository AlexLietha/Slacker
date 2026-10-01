extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent

@export var model: CSGBox3D
@export var icon: Node3D

@export var item: Array[PackedScene]

var counter = 0

func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(RetrieveItem)
	interactableComponent.GetHoveredSignal().connect(highlight)
	
	highlightComponent.SetShader(model.material.next_pass)
	
	

func RetrieveItem(interactor: Player) -> void:
	print("AHH")
	
	if interactor.HasGrabbedItem():
		return
		
	print("BAHH")

	var newItem = item[counter%item.size()].instantiate()
	counter = counter + 1
	add_child(newItem)
	newItem.Grab(interactor)
	pass

func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
	
