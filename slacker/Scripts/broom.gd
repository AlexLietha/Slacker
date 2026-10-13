extends StaticBody3D
class_name Broom

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent

func _ready() -> void:
	interactableComponent.GetHoveredSignal().connect(highlight)
	#highlightComponent.SetShader(model.material.next_pass)

func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
