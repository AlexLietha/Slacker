extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent

@export var model: CSGBox3D
@export var icon: Node3D

@export var item: Array[PackedScene]

var counter = 0
@onready var spawner = $MultiplayerSpawner

@export var ingredient =  preload("uid://2riwns1moyus")

func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(RetrieveItem)
	interactableComponent.GetHoveredSignal().connect(highlight)
	
	highlightComponent.set_shader(model.material.next_pass)

func spawn_ingredient() -> void:
	spawner.spawn(ingredient)
	
	#ingredient.instantiate()

func RetrieveItem(interactor: Player) -> void:
	if interactor.has_grabbed_item():
		return

	var newItem = item[counter%item.size()].instantiate()
	counter = counter + 1
	add_child(newItem)
	newItem.grab(interactor)
	pass

func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
