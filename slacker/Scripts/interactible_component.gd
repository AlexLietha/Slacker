extends Node

@export var Interactible = false
signal interacted(interactor : CharacterBody3D)

func Interact(interactor : CharacterBody3D):
	interacted.emit(interactor)
	print("interacted with")
	
func SetInteractible(con : bool) -> void:
	Interactible = con
	
func GetSignal() -> Signal:
	return interacted
