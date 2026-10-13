extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent

@export var model: CSGBox3D


func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(RetrieveItem)
	#interactableComponent.GetHoveredSignal().connect(highlight)
	
	#highlightComponent.SetShader(model.material.next_pass)
	
	

func RetrieveItem(interactor: Player) -> void:
	print("Interacted")
	interactor.ShowUI()

#func highlight(interactor: Player, highlighted: bool):
	#highlightComponent.highlight(interactor, highlighted)
