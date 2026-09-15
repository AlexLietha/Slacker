extends Node
class_name InteractableComponent

@export var Interactable = true
signal interacted(interactor : Player)
signal hovered(interactor : Player, isHovered : bool)

var isHovered = false
@export var canHighlight = true

func Interact(interactor : Player):
	interacted.emit(interactor)
	
func Hover(interactor : Player, hovering: bool):
	if not canHighlight:
		return
		
	hovered.emit(interactor, hovering)
	isHovered = hovering
	
func SetInteractible(con : bool) -> void:
	Interactable = con
	
func GetInteractSignal() -> Signal:
	return interacted
	
func GetHoveredSignal() -> Signal:
	return hovered
