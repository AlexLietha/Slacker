extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent
@export var closeButton: CloseButton
var VoteToggle = false

@export var model: CSGBox3D


func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(ToggleVoteUI)
	interactableComponent.GetHoveredSignal().connect(highlight)
	highlightComponent.SetShader(model.material.next_pass)
	
	
func ToggleVoteUI(interactor: Player) -> void:
	if(!VoteToggle):
		interactor.ShowUI()
		VoteToggle = true
	else:
		interactor.HideUI()
		VoteToggle = false
		
func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
