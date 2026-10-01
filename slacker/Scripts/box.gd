extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent

@export var model: CSGBox3D
@export var icon: Node3D

@export var item: PackedScene

@export var burger =  preload("res://Scenes/Grabbable Objects/burger_patty.tscn")

func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(RetrieveItem)
	interactableComponent.GetHoveredSignal().connect(highlight)
	
	highlightComponent.SetShader(model.material.next_pass)

func spawnBurger() -> void:
	var newBurger = burger.instantiate()

func RetrieveItem(interactor: Player) -> void:
	print("AHH")
	
	if interactor.HasGrabbedItem():
		return
		
	print("BAHH")

	var newItem = item.instantiate()
	add_child(newItem)
	newItem.Grab(interactor)
	pass

func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
	
