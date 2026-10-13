extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent

@export var model: CSGBox3D
@export var icon: Node3D

@export var item: PackedScene

@export var burger =  preload("res://Scenes/Grabbable Objects/burger_patty.tscn")
var burger_path: String = "res://Scenes/Grabbable Objects/burger_patty.tscn"

func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(RetrieveItem)
	interactableComponent.GetHoveredSignal().connect(highlight)
	
	highlightComponent.SetShader(model.material.next_pass)

func spawnBurger() -> void:
	Network.request_spawn_object(burger)
	#var newBurger = burger.instantiate()
	print("Box: burger spawned")

func RetrieveItem(interactor: Player) -> void:
	print("AHH")
	
	if interactor.HasGrabbedItem():
		return
		
	print("BAHH")

	#var newItem = item.instantiate()
	Network.spawn_object_rpc(int(interactor.name), burger_path)
	#add_child(newItem)
	#newItem.Grab(interactor)
	pass

func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
