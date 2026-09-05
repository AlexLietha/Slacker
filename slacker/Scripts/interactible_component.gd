extends Node
class_name InteractableComponent

@export var Interactable = true
signal interacted(interactor : CharacterBody3D)

func Interact(interactor : CharacterBody3D):
	interacted.emit(interactor)
	print("interacted with")
	
func SetInteractible(con : bool) -> void:
	Interactable = con
	
func GetSignal() -> Signal:
	return interacted
