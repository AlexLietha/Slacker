class_name Sink extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var plate_placement: Node3D

var is_cleaning: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("STINKY THE SINK IS READY")
	interactableComponent.GetInteractSignal().connect(clean_item)


func clean_item(player : Player) -> void:
	print("wow so cleaning")
	var item = player.get_grabbed_item()
	if !item:
		return
	if !item.get_node_or_null("DirtyComponent"):
		return
	
	item.place(plate_placement)
	is_cleaning = true
	
