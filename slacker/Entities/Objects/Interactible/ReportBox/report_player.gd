extends StaticBody3D

@export var interactableComponent: InteractableComponent
@export var highlightComponent: HighlightComponent
#var VoteToggle = false

@export var model: CSGBox3D


func _ready() -> void:
	interactableComponent.GetInteractSignal().connect(ToggleVoteUI)
	interactableComponent.GetHoveredSignal().connect(highlight)
	highlightComponent.SetShader(model.material.next_pass)
	
	
func ToggleVoteUI(interactor: Player) -> void:
	#if(!VoteToggle):
	interactor.show_vote_ui()
	interactor.use_phone = true
		#VoteToggle = true
	#else:
		#interactor.hide_vote_ui
		#VoteToggle = false
		
func highlight(interactor: Player, highlighted: bool):
	highlightComponent.highlight(interactor, highlighted)
func CloseVoteUI(interactor: Player) -> void:
	interactor.hide_vote_ui()
