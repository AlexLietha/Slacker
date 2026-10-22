class_name Sink extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var minigame: SinkMinigame


func _ready() -> void:
	#interactableComponent.SetInteractible(true)
	interactableComponent.GetInteractSignal().connect(clean_item)


func clean_item(player : Player):
	var item = player.get_grabbed_item()
	if !item:
		return
	if !item.get_node_or_null("DirtyComponent"):
		return
	
	minigame.play_minigame(item)
